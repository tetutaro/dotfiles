# color scheme

ターミナルとVIMのカラースキーマとその自動設定ツール

## 作るもの

* gnome-terminal (Ubuntu) 用カラー設定シェルスクリプト
* iTerm2 (Mac OSX) 用カラースキーマ
* fzf 用設定ファイル
* VIM 用カラー設定ファイル

## インストール方法

* 必ず [pipx](https://pypa.github.io/pipx/) をインストールしてください
* Ubuntu
    * `> ./install_ubuntu.sh`
* Mac OSX
    * `> ./install_macosx.sh`

## 自動設定ツール

* `> manage-color`
    * `i` で下のカラースキーマ、`j` で上のカラースキーマを選ぶ
    * `Return` を押すと、そのカラースキーマを選択し、各種設定ファイルを作る

## 入っているカラースキーマ

* [base16 tomorrow scheme](https://github.com/chriskempson/base16-tomorrow-scheme)
    * tomorrow
    * tomorrow-night
* [iceberg](https://github.com/cocopon/iceberg.vim)
    * iceberg-light
    * iceberg-dark
* [Nord Theme](https://www.nordtheme.com/)
    * nord
* original
    * frontemare
    * frontarith

## カラースキーマの作り方

* `schemes` ディレクトリの下に好きな名前のディレクトリを掘り、その下にスキーマを記載した YAML ファイルを書く
    * ひとつのディレクトリに複数のスキーマ（YAMLファイル）を置いても良い
    * [schemes/README.md](schemes/README.md) にスキーマの書き方等が書いてある
* `sources.yaml` の `schemes` に、そのディレクトリ名を追加する
* `> ./builder.py`
* `analysis/analysys` の下には RGB(255), HSV(255) に変換した値が出来る
* `sample/samples` の下には HTML でのサンプルが出来る
* 両者を参考にして調整する
* 全部やり直したくなったら `> ./cleaner.py`
