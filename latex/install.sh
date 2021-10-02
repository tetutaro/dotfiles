#!/usr/bin/env bash
set -eu

CTAN_MIRROR="http://ftp.jaist.ac.jp/pub/CTAN/"
TL_REPO="systems/texlive/tlnet/"
TL_TGZ="install-tl-unx.tar.gz"

## install nesessary packages
sudo apt update
sudo apt install -y --upgrade ghostscript evince python3-pandocfilters

## setteing of directories
if [ ! -d ${HOME}/.texlive ]; then
    mkdir ${HOME}/.texlive
fi
if [ ! -e /usr/local/texlive ]; then
    sudo ln -s ${HOME}/.texlive /usr/local/texlive
fi

## install tlmgr
if [ ! -f ${TL_TGZ} ]; then
    wget -O ${TL_TGZ} ${CTAN_MIRROR}${TL_REPO}${TL_TGZ}
fi
tar xvf ${TL_TGZ}
tl_dir=$(find . -maxdepth 1 -type d -name "install-tl-*")
${tl_dir}/install-tl -repository=${CTAN_MIRROR}${TL_REPO} -scheme=basic -no-gui
rm -f ${TL_TGZ}
rm -rf ${tl_dir}

## install texlive packages
tlmgr=$(find ${HOME}/.texlive -name tlmgr | sort | tail -n 1)
${tlmgr} option repository ${CTAN_MIRROR}${TL_REPO}
${tlmgr} update --self --all
${tlmgr} paper a4
${tlmgr} install uplatex biber biblatex latexmk collection-langjapanese collection-latexrecommended collection-fontsrecommended collection-latexextra noto
sudo ${tlmgr} path add


## download and extract Noto {Sans,Serif} Japanese
wget -O Noto_Sans_JP.zip "https://fonts.google.com/download?family=Noto%20Sans%20JP"
wget -O Noto_Serif_JP.zip "https://fonts.google.com/download?family=Noto%20Serif%20JP"
mkdir noto_sans
unzip -d noto_sans Noto_Sans_JP.zip
mv noto_sans/NotoSansJP-*.otf .
rm -rf noto_sans
rm -f Noto_Sans_JP.zip
mkdir noto_serif
unzip -d noto_serif Noto_Serif_JP.zip
mv noto_serif/NotoSerifJP-*.otf .
rm -rf noto_serif
rm -f Noto_Serif_JP.zip

## install local settings
texmf_local=$(kpsewhich -var-value=TEXMFLOCAL)
mkdir -p ${texmf_local}/web2c
cp texmf.conf ${texmf_local}/web2c/.
mkdir -p ${texmf_local}/fonts/map/dvipdfmx
cp uptex-noto-jp.map ${texmf_local}/fonts/map/dvipdfmx/.
mkdir -p ${texmf_local}/fonts/opentype/noto
mv Noto*.otf ${texmf_local}/fonts/opentype/noto/.

## setup japanese
mktexlsr
sudo cjk-gs-integrate --link-texmf --cleanup
sudo cjk-gs-integrate --link-texmf
kanji-config-updmap-sys --ja nofont
