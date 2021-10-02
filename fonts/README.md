# Install Japanese Fonts

## Fonts to install

* Monospaced fonts (for editor)
	* [Ricty](https://rictyfonts.github.io/)
	* [Migu 1M](https://mix-mplus-ipa.osdn.jp/migu/)
* Proportional fonts (for system and browser)
	* [Migu 1P](https://mix-mplus-ipa.osdn.jp/migu/)
	* [Noto Sans Japanese](https://fonts.google.com/noto/specimen/Noto+Sans+JP)

## Nessesarities

* Python3
* fontforge
    * `> sudo apt install fontforge`
    * The version that has been confirmed to work is `20201107`
* python3-fontforge
    * `> sudo apt install python3-fontforge`
* git, wget, zip(unzip)
* [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
    * `> git clone https://github.com/ryanoasis/nerd-fonts.git`
    * This repository is huge and takes a long time to clone

## Installation

* `> ./install.sh`
    * The OS that has been confirmed to work is `Ubuntu 21.04 (Hirsute Hippo)`
