# theme of Typora

## Install Typora Theme

* Typora の document を読んで Themes 設定ファイルの場所を把握
    * https://theme.typora.io/doc/Install-Theme/
    * Linux の場合は ~/.config/Typora/themes
* [themes](themes) の下に作成される css ファイルのシンボリックリンクを上記 themes ディレクトリの下に作る

## Install fonts for Typora Theme

* 必要なフォント
    * Noto Sans JP 
    * Ricty Discord Nerd
        * font セクションで作ったもの
* https://github.com/google/woff2 を clone, make して、ttf を woff2 に変換する
* themes ディレクトリの下に fonts ディレクトリを作り、変換した woff2 を全てその中に入れる
