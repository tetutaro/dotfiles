# `./tmux.zsh` で実現したいこと

## 基本概念

* Project は Project Directory (\${HOME}/Projects/*/<project\_name>/) に対応するものとする
    * Project Directory より上の階層の Directory はすべて default Project に属するものとする
    * すなわち、\${HOME}/Projects/a/project_a/ は project_a Project であり、\${HOME} や /（root directory）は default Project である
* terminal は herdr の session に対応するものとする
    * session 名は `<project_name>-<N>`（N は 1 から始まる番号）とする
    * session 内の Workspace の label は `<project_name>`、Tab の label は `<N>` とする
* herdr の pane は、AI Agent に対応するものとする

### session を terminal ごとに分ける理由

* herdr (0.9.3) の focus（表示中の Workspace / Tab）は server 全体で 1 つしかない
    * 同じ session に複数の terminal を attach すると、全ての terminal が同じ Tab を表示してしまう（ある terminal で Tab を切り替えると他の terminal も切り替わる）
    * client 一覧や client ごとの focus を取得する API も無いため、「誰も表示していない Tab」も判定できない
* そのため 1 terminal = 1 session とし、terminal ごとに独立した表示を持たせる
* session が attach 中かどうかは、terminal ごとに起動される hsl の tmux（`tmux -L hsl-*`）の client の有無と、その global env の `HERDR_SESSION` で判定する

## session の取り扱い

* 各 Project のソースコードは Project Directory (\${HOME}/Projects/*/<project\_name>/) 以下に配置する
* Project Directory より上の階層の directory は全て default Project とする。
* terminal を立ち上げた時は、CWD から Project を求め、以下の順で `<project_name>-N` の session を選んで attach する
    1. 既に存在し（running / stopped どちらでも）、誰も attach していない session があれば、その中で N が最小のもの
    2. 無ければ、まだ存在しない最小の N で新しく session を作る
* herdr に何も session が無い時に terminal を立ち上げた場合
    * その terminal の CWD は \${HOME} であるため default Project に属するので、default-1 という session を作成し、その terminal は default-1 に attach する
* さらに新しく terminal を立ち上げた場合
    * 新しい terminal の CWD は \${HOME} であるので default Project に属するが、default-1 は attach 中なので、default-2 という session を作成し、その terminal は default-2 に attach する
* そこから default-1 の terminal を exit した場合
    * default Project には default-1 と default-2 の session がある（２個以上の session がある）ため、default-1 の session を stop・delete し、terminal を閉じる
    * default Project には default-2 という session しか無くなる
* さらに default-2 の terminal を exit した場合
    * default Project には default-2 というひとつの session しかないので、default-2 は残し、detach のみを行って terminal を閉じる
* さらに新しく terminal を立ち上げた場合
    * 新しい terminal は CWD が \${HOME} なので default Project に属し、default-2 が残っており、かつ default-2 は誰も attach していないので、新しい terminal は default-2 に attach する
* さらに新しい terminal を立ち上げた場合
    * 新しい terminal は CWD が \${HOME} なので default Project に属するが、default-2 は attach 中なので、まだ存在しない最小の番号で session を作り、それに attach する
        * すなわち、この terminal は default-1 を作成して attach する

## exit の取り扱い

* session 内に pane が２個以上ある場合
    * その pane（AI Agent など）を閉じるだけ
* session の最後の pane で exit した場合
    * 同じ Project の session が２個以上ある場合は、その session を stop・delete して terminal を閉じる
    * 同じ Project の session がひとつしか無い場合は、session は残して detach のみを行い terminal を閉じる
* 強制的に shell を終了したい場合は `force-exit` を使う

## 別 Project への移動（cd / cdp）の取り扱い

* 移動の判定
    * Directory が変わるたびに（zsh の chpwd hook）、移動先の Directory から Project を求め、現在の session の Project と比べる
    * `cd` だけでなく、`cdp`（`cdp <query>`、`cdp` + Tab による fzf での Project 選択を含む）や `pushd` / `popd` など、Directory を変える全ての操作が対象となる
    * ただし subshell の中での移動（`(cd ~/Projects/a/project_b && git pull)` や `$(cd dir; pwd)` など）は一時的なものなので対象としない
* 同じ Project 内での移動の場合
    * 何もしない（Project Directory 以下の sub directory 間の移動など）
    * 例: project_a-1 の terminal で `cd ~/Projects/a/project_a/src` しても session は変わらない
    * 例: project_a の sub directory で `cdp`（引数なし）を実行すると project_a の Project Directory に移動するだけで、session は変わらない
* 別 Project への移動の場合
    * 現在の session から detach し、同じ terminal で移動先 Project の session（terminal を立ち上げた時と同じ規則で選ぶ）に attach し直す
        * 例: default-1 の terminal で `cd ~/Projects/a/project_a` すると、その terminal は project_a-1 に attach する
        * 例: default-1 の terminal で `cdp project_b` として project_b を選ぶと、その terminal は project_b-1 に attach する
        * 例: project_a-1 の terminal で `cd`（\${HOME} への移動）すると、default Project への移動なので、その terminal は default Project の session に attach する
        * 例: project_a の外（\${HOME} など）で `cdp`（引数なし）を実行すると \${PROJECT\_TOP\_DIR} に移動するが、これは default Project なので、default Project の session にいれば session は変わらない
    * 移動先 Project の session を新しく作る場合、その session は移動先の Directory で開始する
    * 移動先 Project に誰も attach していない既存の session がある場合はそれに attach する。その session の pane の Directory は、その session で最後にいた Directory のままとなる（移動先の Directory には移動しない）
    * 元の session の pane は移動前の Directory に戻し（`cd -`）、元の session は誰も attach していない session として残す（exit と違い、stop・delete はしない）
    * 元の session に他の pane（AI Agent など）があっても、それらは元の session でそのまま動き続ける
* herdr の外（terminal 起動時のシェルなど）での移動では何もしない
* これを実現するため、terminal 起動時のシェルは hsl を exec せず、hsl の終了後に「次に attach する Directory」の指示があれば再び session を選んで attach し、指示が無ければ terminal を閉じるループとする

## session の切り替え（prefix+s）

* prefix+s で起動する popup では、terminal の session（`<project_name>-<N>` という名前の session）の一覧を表示し、選んだ session に terminal を切り替える
    * herdr 自身の default session（名前なしの session。削除できない）などは表示しない
    * 各 session には状態を表示する
        * current: この terminal が attach している session
        * attached: 他の terminal が attach している session
        * detached: server は動いているが、誰も attach していない session
        * stopped: server が止まっている session
    * detached / stopped の session を選んだ場合は、現在の session から detach し、同じ terminal で選んだ session に attach し直す（元の session は誰も attach していない session として残す）
    * current の session を選んだ場合は何もしない
    * attached の session を選んだ場合は、２つの terminal が同じ Tab を表示してしまうため、切り替えない
* 別 Project への cd と同じく、terminal 起動時のシェルのループが「次に attach する session」の指示を受け取って attach し直す
