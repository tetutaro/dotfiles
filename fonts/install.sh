#!/usr/bin/env bash
set -eu

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

## create fonts directory
if [ -d ${FONTS_DIR} ]; then
    rm -rf ${FONTS_DIR}
fi
mkdir ${FONTS_DIR}

## generate Ricty
./ricty_generator.sh -d "07DZlrz|" Inconsolata-{Regular,Bold}.ttf migu-1m-{regular,bold}.ttf
# ./ricty_generator.sh -d "07DZlrz|" -n Diminished Inconsolata-{Regular,Bold}.ttf circle-mplus-1m-{regular,bold}.ttf
for font in Ricty*.ttf; do
    ./os2version_reviser.sh ${font}
done

## delete Japanese TTFname from Migu 1M
weights="regular bold"
for weight in $weights; do
    fontforge -lang=ff -c 'Open($1,1); SetTTFName(0x411, 0, ""); SetTTFName(0x411, 1, ""); SetTTFName(0x411, 2, ""); SetTTFName(0x411, 4, ""); SetTTFName(0x411, 5, ""); SetTTFName(0x411, 11, ""); SetTTFName(0x411, 12, ""); SetTTFName(0x411, 13, ""); SetTTFName(0x411, 16, ""); SetTTFName(0x411, 17, ""); Generate($fullname+".ttf"); Close();' migu-1m-${weight}.ttf
    rm -f migu-1m-${weight}.ttf
done
for fn in Migu*.ttf; do
    arr=(${fn%.*})
    new=${arr[0]}${arr[1]}-${arr[2]}.ttf
    mv "$fn" $new
done
mv -f Migu1M*.ttf ${FONTS_DIR}/.

## delete backup files and Inconsolata
rm -f *.bak
rm -f Inconsolata-*.ttf
# rm -f circle-mplus-1m-*.ttf

## rename TTYname of Ricty
for ricty in Ricty*.ttf; do
    /bin/python3 ./rename_ricty.py --outputdir ${FONTS_DIR} ${ricty}
done

## patch Nerd Fonts to Ricty
if [ -d nerd-fonts ]; then
    for ricty in Ricty*.ttf; do
        mv -f ${ricty} nerd-fonts/.
        cd nerd-fonts
        /bin/python3 ./font-patcher --fontawesome --fontawesomeextension --fontlinux --octicons --powersymbols --powerline --powerlineextra --material --weather --adjust-line-height --careful ${ricty}
        rm -f ${ricty}
        cd ..
    done
    for ricty in nerd-fonts/Ricty*.ttf; do
        /bin/python3 ./rename_ricty.py --outputdir ${FONTS_DIR} "${ricty}"
        rm -f "${ricty}"
    done
fi

## download and extract Migu 1P
wget -O migu-1p-${MIGU_VERSION}.zip https://osdn.net/projects/mix-mplus-ipa/downloads/72511/migu-1p-${MIGU_VERSION}.zip
unzip migu-1p-${MIGU_VERSION}.zip
mv -f migu-1p-${MIGU_VERSION}/migu-1p-*.ttf .
rm -rf migu-1p-${MIGU_VERSION}
rm -f migu-1p-${MIGU_VERSION}.zip

## delete Japanese TTFname from Migu 1P
weights="regular bold"
for weight in $weights; do
    fontforge -lang=ff -c 'Open($1,1); SetTTFName(0x411, 0, ""); SetTTFName(0x411, 1, ""); SetTTFName(0x411, 2, ""); SetTTFName(0x411, 4, ""); SetTTFName(0x411, 5, ""); SetTTFName(0x411, 11, ""); SetTTFName(0x411, 12, ""); SetTTFName(0x411, 13, ""); SetTTFName(0x411, 16, ""); SetTTFName(0x411, 17, ""); Generate($fullname+".ttf"); Close();' migu-1p-${weight}.ttf
    rm -f migu-1p-${weight}.ttf
done
for fn in Migu*.ttf; do
    arr=(${fn%.*})
    new=${arr[0]}${arr[1]}-${arr[2]}.ttf
    mv "$fn" $new
done
mv -f Migu1P*.ttf ${FONTS_DIR}/.

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

## covert Noto {Sans,Serif} Japanese OTF to TTF
serifs="Sans Serif"
weights="Black Bold ExtraLight Light Medium Regular SemiBold Thin"
for serif in ${serifs}; do
    for weight in ${weights}; do
        if [ "${serif}" == "Sans" ] && [ "${weight}" == "ExtraLight" ]; then
            continue
        fi
        if [ "${serif}" == "Sans" ] && [ "${weight}" == "SemiBold" ]; then
            continue
        fi
        if [ "${serif}" == "Serif" ] && [ "${weight}" == "Thin" ]; then
            continue
        fi
        fontforge -lang=ff -c 'Open($1,1); CIDFlatten(); Generate($1:r+".ttf"); Close();' Noto${serif}JP-${weight}.otf
    done
done
mv -f Noto*.ttf ${FONTS_DIR}/.
rm -f Noto*.otf

## install fonts to the OS
if [ ! -d ${HOME}/.fonts ]; then
    mkdir ${HOME}/.fonts
fi
rm -f ${HOME}/.fonts/*
cp ${FONTS_DIR}/*.ttf ${HOME}/.fonts/.
fc-cache -fv
