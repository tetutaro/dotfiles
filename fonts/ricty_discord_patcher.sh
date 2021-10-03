#!/usr/bin/env bash

# The glyph to replace
GLYPH="0u007e"
# Diminished or not
DIM=""

# help function
ricty_discord_pather_help()
{
    echo "Usage: ricty_discord_patcher [options]"
    echo ""
    echo "Options:"
    echo "  -h         Display this information"
    echo "  -d         Patch to RictyDiminishedDiscord"
    echo "  -g glyph   The glyph to replace (default: 0u007e = ~)"
    exit 0
}

while getopts hdg: OPT
do
    case "${OPT}" in
        "h" )
            ricty_discord_pather_help
            ;;
        "d" )
            DIM="Diminished"
            ;;
        "g" )
            GLYPH="${OPTARG}"
            ;;
        * )
            exit 1
            ;;
    esac
done
shift `expr $OPTIND - 1`

# Path to fontforge command
fontforge_command="/usr/bin/fontforge"

# Check fontforge existance
if [ ! which $fontforge_command > /dev/null 2>&1 ]; then
    echo "Error: ${fontforge_command} command not found" >&2
    exit 1
fi

# Check fonts existance
weights="Regular Italic Bold BoldItalic"
for weight in ${weights}; do
    if [ ! -f "IBMPlexMono-${weight}.ttf" ]; then
        echo "Error: IBMPlexMono-${weight}.ttf font not found" >&2
        exit 2
    fi
done
weights="Regular Oblique Bold BoldOblique"
for weight in ${weights}; do
    if [ ! -f "RictyDiscord-${weight}.ttf" ]; then
        echo "Error: RictyDiscord-${weight}.ttf font not found" >&2
        exit 3
    fi
done

# Make temporary directory and trap signals
tmpdir=`mktemp -d /tmp/ricty_discord_pather_tmpdir.XXXXXX` || exit 2
echo "tmpdir = ${tmpdir}"
trap "if [ -d \"${tmpdir}\" ]; then echo 'Remove temporary files'; rm -rf ${tmpdir}; echo 'Abnormally terminated'; fi; exit 4" HUP INT QUIT
trap "if [ -d \"${tmpdir}\" ]; then echo 'Remove temporary files'; rm -rf ${tmpdir}; echo 'Abnormally terminated'; fi" EXIT

# Filenames
extract_script="extract_glyph.pe"
eliminate_script="eliminate_glyph.pe"
merge_script="merge_rd_ipm.pe"

# Generate script of extracting GLYPH from IBMPlexMono
cat > ${tmpdir}/${extract_script} << _EOT_
#!${fontforge_command} -script

Print("Extract GLYPH (${GLYPH}) from IBMPlexMono")

inputs = ["IBMPlexMono-Regular.ttf", "IBMPlexMono-Italic.ttf", "IBMPlexMono-Bold.ttf", "IBMPlexMono-BoldItalic.ttf"]
outputs = ["IPM-Regular.sfd", "IPM-Italic.sfd", "IPM-Bold.sfd", "IPM-BoldItalic.sfd"]

i = 0
while (i < SizeOf(inputs))
    Print("Open " + inputs[i])
    Open(inputs[i])
    SelectWorthOutputting()
    UnlinkReference()
    ScaleToEm(860, 140)
    Select(${GLYPH}); SelectInvert(); Clear()
    Select(${GLYPH}); Scale(90, 100); SetWidth(500)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    SelectWorthOutputting()
    ClearInstrs()
    Print("Save " + outputs[i])
    Save("${tmpdir}/" + outputs[i])
    Close()
    i += 1
endloop
Quit()
_EOT_

# Generate script of eliminating GLYPH from RictyDiscord
cat > ${tmpdir}/${eliminate_script} << _EOT_
#!${fontforge_command} -script

Print("Eliminate GLYPH (${GLYPH}) from Ricty${DIM}Discord")

inputs = ["Ricty${DIM}Discord-Regular.ttf", "Ricty${DIM}Discord-Oblique.ttf", "Ricty${DIM}Discord-Bold.ttf", "Ricty${DIM}Discord-BoldOblique.ttf"]
outputs = ["R${DIM}D-Regular.sfd", "R${DIM}D-Oblique.sfd", "R${DIM}D-Bold.sfd", "R${DIM}D-BoldOblique.sfd"]

i = 0
while (i < SizeOf(inputs))
    Print("Open " + inputs[i])
    Open(inputs[i])
    SelectWorthOutputting()
    UnlinkReference()
    Select(${GLYPH}); Clear()
    SelectWorthOutputting()
    ClearInstrs()
    Print("Save " + outputs[i])
    Save("${tmpdir}/" + outputs[i])
    Close()
    i += 1
endloop
Quit()
_EOT_

# Generate script of merging
cat > ${tmpdir}/${merge_script} << _EOT_
#!${fontforge_command} -script

Print("Patch GLYPH from IBMPlexMono to Ricty${DIM}Discord")

rds = ["${tmpdir}/R${DIM}D-Regular.sfd", "${tmpdir}/R${DIM}D-Oblique.sfd", "${tmpdir}/R${DIM}D-Bold.sfd", "${tmpdir}/R${DIM}D-BoldOblique.sfd"]
ipms = ["${tmpdir}/IPM-Regular.sfd", "${tmpdir}/IPM-Italic.sfd", "${tmpdir}/IPM-Bold.sfd", "${tmpdir}/IPM-BoldItalic.sfd"]
outputs = ["Ricty${DIM}Discord-Regular.ttf", "Ricty${DIM}Discord-Oblique.ttf", "Ricty${DIM}Discord-Bold.ttf", "Ricty${DIM}Discord-BoldOblique.ttf"]

i = 0
while (i < SizeOf(rds))
    Print("Merge " + ipms[i]:t + " to " + rds[i]:t)
    Open(rds[i])
    MergeFonts(ipms[i])
    Print("Generate " + outputs[i])
    Generate(outputs[i], "", 0x84)
    Close()
    i += 1
endloop
Quit()
_EOT_

${fontforge_command} -script ${tmpdir}/${extract_script} 2> /dev/null || exit 5
${fontforge_command} -script ${tmpdir}/${eliminate_script} 2> /dev/null || exit 5
weights="Regular Oblique Bold BoldOblique"
for weight in ${weights}; do
    if [ -f "RictyDiscord-${weight}.ttf" ]; then
        rm -f RictyDiscord-${weight}.ttf
    fi
done
${fontforge_command} -script ${tmpdir}/${merge_script} 2> /dev/null || exit 5

rm -rf ${tmpdir}
exit 0
