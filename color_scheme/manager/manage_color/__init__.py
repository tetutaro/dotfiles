#!/usr/bin/env python3
# -*- coding:utf-8 -*-
"""color scheme manager

Preview color schemes and setup the selected color scheme.

Attributes:
    COLOR_SCHEME_SHELL_PATH (str):
        The pathname of shell script which setups colors for shell.
    COLOR_SCHEME_SHELL_DIR (str):
        The directory name that color schemes for shell are installed.
    COLOR_SCHEME_FZF_PATH (str):
        The pathname of shell script which setups colors for fzf.
    COLOR_SCHEME_FZF_DIR (str):
        The directory name that color schemes for fzf installed.
    COLOR_SCHEME_TMUX_DIR (str):
        The pathname of script which setups colors for tmux.
    COLOR_SCHEME_POWERLINE_DIR (str):
        The pathname of script which setups colors for powerline.
    COLOR_SCHEME_VIM_PATH (str):
        The pathname of vim script which setups colors for vim.
        Your vim config script will read this file.
"""

from typing import List, Optional
import argparse
import curses
import os
import subprocess

COLOR_SCHEME_SHELL_PATH = '~/.config/color_scheme/shell.sh'
COLOR_SCHEME_SHELL_DIR = '~/.config/color_scheme/shell'
COLOR_SCHEME_FZF_PATH = '~/.config/color_scheme/fzf.sh'
COLOR_SCHEME_FZF_DIR = '~/.config/color_scheme/fzf'
COLOR_SCHEME_TMUX_DIR = '~/.config/color_scheme/tmux'
COLOR_SCHEME_TMUX_PATH = '~/.config/tmux/style.conf'
COLOR_SCHEME_POWERLINE_DIR = '~/.config/color_scheme/powerline'
COLOR_SCHEME_POWERLINE_PATH = '~/.config/powerline/colors.json'
COLOR_SCHEME_VIM_PATH = '~/.vim/colors.vim'
COLOR_SCHEME_VIM_RC = '''"" This file is automatically created by manage_color
if !exists('g:colors_name') || g:colors_name != '{theme}'
    colorscheme {theme}
endif
'''


def create_symlink(src: str, dst: str) -> None:
    """Create a symbolic link.

    Unlink destination if already exists and link it symbolically to source.

    Args:
        src (str):
            The pathname that is source of symbolic link
            expanded home directory(~).
        dst (str):
            The pathname that is destination of symbolic link
            expanded home directory(~).

    Returns:
        None

    Raises:
        OSError: If `dst` is already exists and not symbolic link
    """
    if not os.path.exists(src):
        raise ValueError("{} is not exists".format(src))
    if os.path.exists(dst):
        if not os.path.islink(dst):
            raise ValueError("{} is not symbolic link".format(dst))
        os.remove(dst)
    print(f'{src} -> {dst}')
    os.symlink(src, dst)
    return


class Theme(object):
    path = None
    name = None
    shell = os.environ['SHELL']

    def __init__(self, path: str) -> None:
        """Store the color scheme script and run, setup the script

        Args:
            path (str):
                The pathname of color scheme script
                expanded home directory.
        """
        self.path = path
        self.name = os.path.splitext(
            os.path.split(path)[1]
        )[0]
        return

    def run(self) -> None:
        """run the color scheme script"""
        subprocess.Popen([self.shell, self.path])

    def setup(self) -> None:
        """setup the color scheme script"""
        # shell
        create_symlink(
            self.path,
            os.path.expanduser(COLOR_SCHEME_SHELL_PATH)
        )
        # fzf
        create_symlink(
            os.path.join(
                os.path.expanduser(COLOR_SCHEME_FZF_DIR),
                os.path.basename(self.path)
            ),
            os.path.expanduser(COLOR_SCHEME_FZF_PATH)
        )
        # tmux
        tdir = os.path.dirname(os.path.expanduser(
            COLOR_SCHEME_TMUX_PATH
        ))
        if os.path.isdir(tdir):
            create_symlink(
                os.path.join(
                    os.path.expanduser(COLOR_SCHEME_TMUX_DIR),
                    os.path.splitext(os.path.basename(
                        self.path
                    ))[0] + '.conf'
                ),
                os.path.expanduser(COLOR_SCHEME_TMUX_PATH)
            )
        # powerline
        tdir = os.path.dirname(os.path.expanduser(
            COLOR_SCHEME_POWERLINE_PATH
        ))
        if os.path.isdir(tdir):
            create_symlink(
                os.path.join(
                    os.path.expanduser(COLOR_SCHEME_POWERLINE_DIR),
                    os.path.splitext(os.path.basename(
                        self.path
                    ))[0] + '.json'
                ),
                os.path.expanduser(COLOR_SCHEME_POWERLINE_PATH)
            )
        # vim
        with open(os.path.expanduser(COLOR_SCHEME_VIM_PATH), 'w') as wf:
            wf.write(COLOR_SCHEME_VIM_RC.format(theme=self.name))
        return


def get_themes() -> List[Theme]:
    if not os.path.islink(
        os.path.expanduser(COLOR_SCHEME_SHELL_DIR)
    ):
        raise ValueError("manage_color is not installed")
    scripts_dir = os.readlink(
        os.path.expanduser(COLOR_SCHEME_SHELL_DIR)
    )
    return [
        Theme(os.path.join(scripts_dir, f))
        for f in sorted(os.listdir(scripts_dir))
    ]


def get_default_theme() -> Optional[Theme]:
    if not os.path.islink(
        os.path.expanduser(COLOR_SCHEME_SHELL_PATH)
    ):
        return None
    script_path = os.readlink(
        os.path.expanduser(COLOR_SCHEME_SHELL_PATH)
    )
    return Theme(script_path)


class Window(object):
    bg_names = [
        (-1, ' BG '),
        (16, ' Bg '),
        (17, ' Bf '),
        (18, ' BF '),
        (20, ' B1 '),
        (21, ' B2 '),
        (22, ' B3 '),
        (23, ' B4 '),
        (24, ' B5 '),
    ]
    fg_names = [
        (-1, ' FG '),
        (19, ' Fg '),
        (1, ' F1 '),
        (25, ' F2 '),
        (3, ' F3 '),
        (2, ' F4 '),
        (6, ' F5 '),
        (4, ' F6 '),
        (5, ' F7 '),
    ]
    num_colors = len(bg_names) + 1
    scheme_list_columns = 29
    preview_columns = 41
    total_columns = scheme_list_columns + preview_columns


class PreviewWindow(Window):
    window = None

    def __init__(self) -> None:
        self.window = curses.newwin(
            self.num_colors,
            self.preview_columns,
            0,
            self.scheme_list_columns
        )
        return

    def render(self) -> None:
        curses.init_pair(0, -1, -1)
        attr = curses.color_pair(0)
        self.window.addstr(0, 0, 'BGFG', attr)
        for ci, (fgi, fgt) in enumerate(self.fg_names):
            self.window.addstr(0, 4 * (ci + 1), fgt, attr)
        i = 1
        for ri, (bgi, bgt) in enumerate(self.bg_names):
            attr = curses.color_pair(0)
            self.window.addstr(ri + 1, 0, bgt, attr)
            for ci, (fgi, fgt) in enumerate(self.fg_names):
                curses.init_pair(i, fgi, bgi)
                attr = curses.color_pair(i)
                self.window.addstr(ri + 1, 4 * (ci + 1), ' xx ', attr)
                i += 1
        self.window.refresh()
        return


class SchemeListWindow(Window):
    themes = get_themes()
    offset = 0
    selected = 0
    window = None

    def __init__(self) -> None:
        self.window = curses.newwin(
            self.num_colors, self.scheme_list_columns, 0, 0
        )
        return

    def get_selected_theme(self) -> Theme:
        return self.themes[self.selected]

    def up(self) -> None:
        if self.selected > 0:
            self.selected -= 1
        elif self.offset != 0:
            self.offset -= 1
        self.render()

    def down(self) -> None:
        if (self.offset + self.selected) > (len(self.themes) - 2):
            pass
        elif self.selected == (self.num_colors - 1):
            self.offset += 1
        else:
            self.selected += 1
        self.render()
        return

    def render(self) -> None:
        end = self.offset + self.num_colors
        line = 0
        for i, theme in enumerate(self.themes):
            if i < self.offset:
                continue
            elif i == end:
                break
            if line == self.selected:
                attrs = curses.A_REVERSE
            else:
                attrs = 0
            self.window.addstr(
                line, 0, ' ' * (self.scheme_list_columns - 1), attrs
            )
            self.window.addstr(
                line, 0, theme.name, attrs
            )
            line += 1
        self.window.refresh()
        return


class WindowController(Window):
    stdscr = None
    scheme_list_window = None
    preview_window = None
    default_theme = get_default_theme()

    def __init__(self) -> None:
        self.scheme_list_window = SchemeListWindow()
        self.preview_window = PreviewWindow()
        return

    def run_default_theme(self) -> None:
        if self.default_theme is not None:
            self.default_theme.run()
        return

    def setup_theme(self) -> None:
        self.scheme_list_window.get_selected_theme().setup()
        return

    def render(self) -> None:
        self.scheme_list_window.get_selected_theme().run()
        self.scheme_list_window.render()
        self.preview_window.render()
        return

    def down(self) -> None:
        self.scheme_list_window.down()
        return

    def up(self) -> None:
        self.scheme_list_window.up()
        return


def run_curses_app() -> None:
    stdscr = curses.initscr()
    stdscr.refresh()
    stdscr.keypad(True)
    curses.start_color()
    curses.use_default_colors()
    curses.curs_set(0)
    curses.noecho()
    controller = WindowController()
    controller.render()
    while True:
        controller.render()
        c = stdscr.getch()
        if c == ord('j') or c == curses.KEY_DOWN:
            controller.down()
        elif c == ord('k') or c == curses.KEY_UP:
            controller.up()
        elif c == ord('q'):
            controller.run_default_theme()
            break
        elif c == ord('\n'):
            controller.setup_theme()
            break
        elif c == curses.KEY_RESIZE:
            if curses.LINES < controller.num_colors:
                controller.run_default_theme()
                raise ValueError(
                    'Terminal has less than {} lines.'.format(
                        controller.num_colors
                    )
                )
            elif curses.COLS < controller.total_columns:
                controller.run_default_theme()
                raise ValueError(
                    'Terminal has less than {} columns.'.format(
                        controller.total_columns
                    )
                )
    return


def end_run() -> None:
    try:
        curses.endwin()
    except KeyboardInterrupt:
        end_run()
    return


def main() -> None:
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter,
        description="""
keys:
  j,up/k,down  move 1
  q            quit
  enter        enable theme and quit
""")
    parser.add_argument(
        '--version',
        action='version',
    )
    parser.parse_args()
    try:
        run_curses_app()
    except Exception as e:
        end_run()
        print(e)
    else:
        end_run()
    return


if __name__ == '__main__':
    main()
