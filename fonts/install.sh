#!/usr/bin/env bash
set -eu

FONTFORGE_PYTHON="/bin/python3"
FONTS_DIR="fonts"
MIGU_VERSION="20200307"

## download Ricty Generator
wget -O ricty_generator.sh https://rictyfonts.github.io/files/ricty_generator.sh
chmod +x ricty_generator.sh

## download OS/2 Version Reviser
wget -O os2version_reviser.sh https://rictyfonts.github.io/files/os2version_reviser.sh
chmod +x os2version_reviser.sh

## download Inconsolata
wget -O Inconsolata-Regular.ttf https://github.com/google/fonts/raw/main/ofl/inconsolata/static/Inconsolata-Regular.ttf
wget -O Inconsolata-Bold.ttf https://github.com/google/fonts/raw/main/ofl/inconsolata/static/Inconsolata-Bold.ttf

## download and extract Migu 1M
wget -O migu-1m-${MIGU_VERSION}.zip https://osdn.net/projects/mix-mplus-ipa/downloads/72511/migu-1m-${MIGU_VERSION}.zip
unzip migu-1m-${MIGU_VERSION}.zip
mv -f migu-1m-${MIGU_VERSION}/migu-1m-*.ttf .
rm -rf migu-1m-${MIGU_VERSION}
rm -f migu-1m-${MIGU_VERSION}.zip

## download and extract Circle M+ 1M for Ricty Diminished
# wget -O circle-mplus-1m-${MIGU_VERSION}.zip "https://ja.osdn.net/frs/redir.php?m=gigenet&f=mix-mplus-ipa%2F72512%2Fcircle-mplus-1m-${MIGU_VERSION}.zip"
# unzip circle-mplus-1m-${MIGU_VERSION}.zip
# mv -f circle-mplus-1m-${MIGU_VERSION}/migu-1m-*.ttf .
# rm -rf circle-mplus-1m-${MIGU_VERSION}
# rm -f circle-mplus-1m-${MIGU_VERSION}.zip

## download IBM Plex Mono for Ricty Discord
wget -O IBMPlexMono-Bold.ttf "https://github.com/IBM/plex/raw/master/IBM-Plex-Mono/fonts/complete/ttf/IBMPlexMono-Bold.ttf"
wget -O IBMPlexMono-BoldItalic.ttf "https://github.com/IBM/plex/raw/master/IBM-Plex-Mono/fonts/complete/ttf/IBMPlexMono-BoldItalic.ttf"
wget -O IBMPlexMono-Italic.ttf "https://github.com/IBM/plex/raw/master/IBM-Plex-Mono/fonts/complete/ttf/IBMPlexMono-Italic.ttf"
wget -O IBMPlexMono-Regular.ttf "https://github.com/IBM/plex/raw/master/IBM-Plex-Mono/fonts/complete/ttf/IBMPlexMono-Regular.ttf"

## create fonts directory
if [ -d ${FONTS_DIR} ]; then
    rm -rf ${FONTS_DIR}
fi
mkdir ${FONTS_DIR}

## generate Ricty
./ricty_generator.sh -d "07DZlrz|~" Inconsolata-{Regular,Bold}.ttf migu-1m-{regular,bold}.ttf
# ./ricty_generator.sh -d "07DZlrz|~" -n Diminished Inconsolata-{Regular,Bold}.ttf circle-mplus-1m-{regular,bold}.ttf
for font in Ricty*.ttf; do
    ./os2version_reviser.sh ${font}
done

## delete backup files and Inconsolata, Migu 1M
rm -f *.bak
rm -f Inconsolata-*.ttf
rm -f migu-1m-*.ttf
# rm -f circle-mplus-1m-*.ttf

## patch to RictyDiscord
./ricty_discord_patcher.sh
# ./ricty_discord_patcher.sh -d

## delete IMBPlexMono
rm -f IBMPlexMono-*.ttf

## rename TTYname of Ricty
for ricty in Ricty*.ttf; do
    ${FONTFORGE_PYTHON} ./rename_ricty.py --outputdir ${FONTS_DIR} ${ricty}
done

## patch Nerd Fonts to Ricty
if [ -d nerd-fonts ]; then
    for ricty in Ricty*.ttf; do
        mv -f ${ricty} nerd-fonts/.
        cd nerd-fonts
        ${FONTFORGE_PYTHON} ./font-patcher --fontawesome --fontawesomeextension --fontlinux --octicons --powersymbols --powerline --powerlineextra --material --weather --adjust-line-height ${ricty}
        rm -f ${ricty}
        cd ..
    done
    for ricty in nerd-fonts/Ricty*.ttf; do
        ${FONTFORGE_PYTHON} ./rename_ricty.py --outputdir ${FONTS_DIR} "${ricty}"
        rm -f "${ricty}"
    done
fi

## download and extract Noto {Sans,Serif} Japanese
wget -O Noto_Sans_JP.zip "https://fonts.google.com/download?family=Noto%20Sans%20JP"
wget -O Noto_Serif_JP.zip "https://fonts.google.com/download?family=Noto%20Serif%20JP"
mkdir noto_sans
unzip -d noto_sans Noto_Sans_JP.zip
mv -f noto_sans/NotoSansJP-*.otf ${FONTS_DIR}/.
rm -rf noto_sans
rm -f Noto_Sans_JP.zip
mkdir noto_serif
unzip -d noto_serif Noto_Serif_JP.zip
mv -f noto_serif/NotoSerifJP-*.otf ${FONTS_DIR}/.
rm -rf noto_serif
rm -f Noto_Serif_JP.zip

## install fonts to the OS
os=$(uname -s)
if [ "${os}" == "Darwin" ]; then
    SYS_FONTS_DIR=${HOME}/Library/Fonts
else
    SYS_FONTS_DIR=${HOME}/.fonts
fi
if [ ! -d ${SYS_FONTS_DIR} ]; then
    mkdir ${SYS_FONTS_DIR}
fi
rm -f ${SYS_FONTS_DIR}/*
cp ${FONTS_DIR}/* ${SYS_FONTS_DIR}/.
fc-cache -fv
