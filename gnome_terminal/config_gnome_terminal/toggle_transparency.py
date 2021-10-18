#!/usr/bin/env python
# -*- coding:utf-8 -*-
from typing import Optional
import subprocess
import argparse
from .profile import get_profile_path, get_profile_uuids


def set_font(profiles: Optional[str], percent: int) -> None:
    if percent < 0 or 100 < percent:
        raise ValueError(f"invalid percent: {percent}")
    if profiles is None:
        names = list()
    else:
        names = [x.strip() for x in profiles.strip().split(',')]
    uuids = get_profile_uuids(names=names)
    if len(uuids) == 0:
        raise ValueError(f"No such profile: {profiles}")
    for uuid in uuids:
        subprocess.run([
            'gsettings', 'set',
            get_profile_path(uuid=uuid),
            'use-theme-transparency', 'false'
        ], encoding='utf-8')
        subprocess.run([
            'gsettings', 'set',
            get_profile_path(uuid=uuid),
            'background-transparency-percent', str(percent)
        ], encoding='utf-8')
        res = subprocess.run([
            'gsettings', 'get',
            get_profile_path(uuid=uuid),
            'use-transparent-background'
        ], encoding='utf-8', capture_output=True)
        is_transparent = res.stdout.strip()
        if is_transparent == 'true':
            new_transparent = 'false'
        else:
            new_transparent = 'true'
        subprocess.run([
            'gsettings', 'set',
            get_profile_path(uuid=uuid),
            'use-transparent-background', new_transparent
        ], encoding='utf-8')
    return


def main() -> None:
    parser = argparse.ArgumentParser(
        description="toggle gnome-terminal transparency"
    )
    parser.add_argument(
        '--profiles', '-p', type=str, default=None,
        help=(
            'profile names (comma separated) '
            '(default: None = all profiles)'
        )
    )
    parser.add_argument(
        '--percent', '-c', type=int, default=20,
        help='transparency percent (default: 20)'
    )
    args = parser.parse_args()
    set_font(**vars(args))
    return


if __name__ == '__main__':
    main()
