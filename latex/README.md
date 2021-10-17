# install LaTeX

## Necessities

* pandoc
    * Linux (Ubuntu)
        * Go [GitHub repository of pandoc](https://github.com/jgm/pandoc/releases)
        * download and install the latest version of pandoc
    * Mac OSX
        * `> brew install pandoc`
* ghostscript
    * Linux (Ubuntu)
        * `> sudo apt install ghostscript`
    * Mac OSX
        * `> brew install ghostscript`
* PDF viewer
    * Linux (Ubuntu)
        * `> sudo apt install evince`
    * Mac OSX
        * `> brew install --cask skim`
* The owner of `/usr/local/texlive` directory
    * Linux (Ubuntu)
        * Nothing to do (the owner is root)
    * Mac OSX
        * The owner should be you
        * `sudo mkdir /usr/local/texlive`
        * `sudo chown -R [username] /usr/local/texlive`

## Settings

* If you want to change the CTAN mirror site you will download LaTeX package from, you need to modify the `CTAN_MIRROR` variable in `install.sh`
    * the list of CTAN mirror sites is written in [CTAN Sites](https://ctan.org/mirrors)

## Installation

* Linux (Ubuntu)
    * `> sudo ./install.sh`
* Mac OSX
    * `> ./install.sh`
* You will be prompted only once in the installation process, but press "I" to continue

install latexmkrc

* `> ./install_latexmkrc.sh`
