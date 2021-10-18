#!/usr/bin/env python
# -*- coding:utf-8 -*-
from typing import List
import subprocess


def get_profile_path(uuid: str) -> str:
    return (
        'org.gnome.Terminal.Legacy.Profile:'
        f'/org/gnome/terminal/legacy/profiles:/:{uuid.strip()}/'
    )


def get_profile_uuids(names: List[str]) -> List[str]:
    res = subprocess.run(
        ['gsettings', 'get', 'org.gnome.Terminal.ProfilesList', 'list'],
        encoding='utf-8',
        capture_output=True
    )
    uuids = eval(res.stdout.strip())
    if len(names) == 0:
        return uuids
    lower_names = [x.lower().strip() for x in names]
    rets = list()
    for uuid in uuids:
        res = subprocess.run([
            'gsettings', 'get',
            get_profile_path(uuid=uuid),
            'visible-name'
        ], encoding='utf-8', capture_output=True)
        visible_name = eval(res.stdout.strip()).lower().strip()
        if visible_name in lower_names:
            rets.append(uuid)
    return rets
