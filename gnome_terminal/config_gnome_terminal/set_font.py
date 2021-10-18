#!/usr/bin/env python
# -*- coding:utf-8 -*-
from typing import Optional
import subprocess
import argparse
from .profile import get_profile_path, get_profile_uuids
from .fc_list import check_fontname


def set_font(profiles: Optional[str], font: str, size: int) -> None:
    if profiles is None:
        names = list()
    else:
        names = [x.strip() for x in profiles.strip().split(',')]
    uuids = get_profile_uuids(names=names)
    if len(uuids) == 0:
        raise ValueError(f"No such profile: {profiles}")
    if not check_fontname(fontname=font):
        raise ValueError(f"No such font: {font}")
    for uuid in uuids:
        subprocess.run([
            'gsettings', 'set',
            get_profile_path(uuid=uuid),
            'use-system-font', 'false'
        ], encoding='utf-8')
        subprocess.run([
            'gsettings', 'set',
            get_profile_path(uuid=uuid),
            'font', f'"{font} {size}"'
        ], encoding='utf-8')
    return


def main() -> None:
    parser = argparse.ArgumentParser(
        description="set font to gnome-terminal"
    )
    parser.add_argument(
        '--profiles', '-p', type=str, default=None,
        help=(
            'profile names (comma separated) '
            '(default: None = all profiles)'
        )
    )
    parser.add_argument(
        '--font', '-f', type=str, default="Ricty Discord Nerd",
        help='fontname to set (default: "Ricty Discord Nerd")'
    )
    parser.add_argument(
        '--size', '-s', type=int, default=14,
        help='fontsize to set (default: 14)'
    )
    args = parser.parse_args()
    set_font(**vars(args))
    return


if __name__ == '__main__':
    main()
