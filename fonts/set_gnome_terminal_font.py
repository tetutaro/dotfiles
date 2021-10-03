#!/usr/bin/env python
# -*- coding:utf-8 -*-
import subprocess
import argparse


def set_font(font: str, size: int) -> None:
    res = subprocess.run(
        ['gsettings', 'get', 'org.gnome.Terminal.ProfilesList', 'list'],
        encoding='utf-8',
        capture_output=True
    )
    uuids = eval(res.stdout.strip())
    for uuid in uuids:
        subprocess.run([
            'gsettings', 'set',
            f'org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:{uuid}/',
            'font', f'"{font} {size}"'
        ], encoding='utf-8')
    return


def main() -> None:
    parser = argparse.ArgumentParser(
        description="set font to gnome-terminal"
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
