# Install Japanese Fonts

## Fonts to install

* Monospaced fonts (for editor)
	* [Ricty](https://rictyfonts.github.io/)
* Proportional fonts (for system and browser)
	* [Noto Sans Japanese](https://fonts.google.com/noto/specimen/Noto+Sans+JP)

## What this does

* download shell scripts and fonts to generate the Ricty font
    * download `ricty_generator.sh` and `os2version_reviser.sh` from [the repository](https://rictyfonts.github.io/)
    * download Inconsolata and Migu-1M
    * generate Ricty and Ricty-Discord
* replace Ricty's `~` with IBM-Plex-Mono's `~`
* apply the nerd-font patch to Ricty
* download Noto-{Sans,Serif}-JP
* copy Ricty and Noto-{Sans,Serif}-JP to the directory which the system can recognize them

## Necessities

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
