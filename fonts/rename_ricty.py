#!/usr/bin/env python
# -*- coding:utf-8 -*-
from typing import Optional
import os
import sys
import argparse
import fontforge


def rename(font: str, outputdir: Optional[str]) -> None:
    if not os.path.exists(font):
        raise ValueError(f'{font} is not exists')
    if outputdir is not None:
        if not os.path.isdir(outputdir):
            raise ValueError(f'{outputdir} is not directory')
    try:
        sourceFont = fontforge.open(font)
    except Exception as e:
        raise e
    fam = list()
    wei = list()
    pat = list()
    for name in sourceFont.fullname.strip().split():
        if name in ['Ricty', 'Diminished', 'Discord']:
            fam.append(name)
        elif name in ['Regular', 'Bold', 'Oblique']:
            if name == 'Oblique':
                name = 'Italic'
            wei.append(name)
        elif name in ['Nerd']:
            pat.append(name)
    if len(fam) == 0:
        raise ValueError('invalid fullname')
    if not (('Regular' in wei) or ('Bold' in wei)):
        wei = ['Regular'] + wei
    if len(pat) > 0:
        fontname = ''.join(fam) + '-' + ''.join(pat) + '-' + ''.join(wei)
        familyname = ' '.join([' '.join(fam), ' '.join(pat)])
    else:
        fontname = ''.join(fam) + '-' + ''.join(wei)
        familyname = ' '.join(fam)
    stylename = ' '.join(wei)
    fullname = ' '.join([familyname, stylename])
    sourceFont.fontname = fontname
    sourceFont.fullname = fullname
    sourceFont.familyname = familyname
    sourceFont.appendSFNTName(
        'English (US)', 'PostScriptName', fontname
    )
    sourceFont.appendSFNTName(
        'English (US)', 'Fullname', fullname
    )
    sourceFont.appendSFNTName(
        'English (US)', 'Family', familyname
    )
    sourceFont.appendSFNTName(
        'English (US)', 'SubFamily', stylename
    )
    sourceFont.appendSFNTName(
        'English (US)', 'Preferred Family', familyname
    )
    sourceFont.appendSFNTName(
        'English (US)', 'Compatible Full', fullname
    )
    if outputdir is None:
        path = fontname + '.ttf'
    else:
        path = os.path.join(outputdir, fontname + '.ttf')
    sourceFont.generate(
        path, flags=('opentype', 'PfEd-comments')
    )
    sourceFont.close()
    return


def main() -> None:
    parser = argparse.ArgumentParser(description='rename Ricty Font')
    parser.add_argument(
        'font', help='The path to the Ricty font to rename'
    )
    parser.add_argument(
        '--outputdir', '--out', type=str, default=None,
        help='The directory to output the renamed font file to'
    )
    args = parser.parse_args()
    rename(**vars(args))
    return


if __name__ == '__main__':
    main()
