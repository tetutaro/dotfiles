#!/usr/bin/env python
# -*- coding:utf-8 -*-
from typing import List
import subprocess


def _get_fontnames() -> List[str]:
    res = subprocess.run(
        'fc-list',
        encoding='utf-8',
        capture_output=True
    )
    font_list = res.stdout.strip().splitlines()
    fonts = set()
    for font in font_list:
        path, names, weight = font.split(':')
        if '.fonts' not in path:
            continue
        for name in names.strip().split(','):
            fonts.add(name)
    return list(fonts)


def check_fontname(fontname: str) -> bool:
    return fontname in _get_fontnames()
