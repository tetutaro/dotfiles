#!/usr/bin/env python
# -*- coding:utf-8 -*-
import os
import re
import subprocess

res = subprocess.run(
    'fc-list',
    encoding='utf-8',
    capture_output=True
)
font_list = res.stdout.strip().splitlines()
fonts = list()
for font in font_list:
    path, name, weight = font.split(':')
    if not '.fonts' in path:
        continue
    path = path.split(os.sep)[-1].strip()
    name = name.strip()
    weight = re.sub('style=', '', weight).strip()
    fonts.append((path, name, weight))
for font in sorted(fonts, key=lambda x: (x[1].lower(), x[2], x[0])):
    print('|' + '|'.join(font) + '|')
