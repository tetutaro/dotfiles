* /snap/bin/ubuntu-budgie-welcome.budgie-welcome で WhiteSur のアイコンテーマをインストールする
* icon はなるべく /usr/share/icons/WhiteSur/apps/symbolic に統一する
* AppMenu
    * Budgie デスクトップの設定から、mediaplayer-app-symbol
* LightPad
    * Budgie デスクトップの設定から、apps-symbolic
* Ghostty
    * /usr/share/applications/com.mitchellh.ghostty.desktop
    * これを同じディレクトリの com.mitchellh.ghostty.desktop.backup に backup
    * Icon=org.gnome.Settings-secure-shell-symbolic
* Chrome
    * /usr/share/applications/google-chrome.desktop
    * これを同じディレクトリの google-chrome.desktop.backup に backup
    * Icon=chromium-browser-symbolic
* Nemo
    * /usr/share/applications/nemo.desktop
    * これを同じディレクトリの nemo.desktop.backup に backup
    * Icon=filemanager-app-symbolic
* デスクトップの日時表示
    * 行っているのは Raven の ShowTime
    * 前は dateformat を変えられたが、今は出来ない
        * 前は gsettings や dconf editor でスキーマを変更するという手段も使えたが、それもできない
    * 発想の逆転をして、時刻の表示を英語表記にしてみる
        * zshrc で LC_ALL の設定をやめ、LC_TIME=en_US.UTF-8 にする
        * en_US.UTF-8 のロケールがない場合は sudo locale-gen en_US.UTF-8
            * date "+%Y/%m/%d (%a) %H:%M:%S" で確認
        * sudo update-locale LANG=ja_JP.UTF-8 LC_TIME=en_US.UTF-8
        * /etc/default/locale に LANG=ja_JP.UTF-8 だけでなく LC_TIME=en_US.UTF-8 を記載
        * sudo localectl set-locale LC_TIME=en_US.UTF-8
            * localectl status で確認
        * gsettings set org.gnome.system.locale region 'en_US.UTF-8'
