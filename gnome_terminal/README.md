# gnome-terminal configuration tools

* `set-gnome-terminal-font`: set font to gnome-terminal
* `toggle-gnome-terminal-transparency`: toggle gnome-terminal transparency

## Necessities

* pipx
    * pipx is installed in [zsh](/zsh/)

## Installation

* `> ./install.sh`

## Uninstallation

* `> ./uninstall.sh`

## Usage

set-gnome-terminal-font

```
> set-gnome-terminal-font --help
usage: set-gnome-terminal-font [-h] [--profiles PROFILES] [--font FONT]
                               [--size SIZE]

set font to gnome-terminal

optional arguments:
  -h, --help            show this help message and exit
  --profiles PROFILES, -p PROFILES
                        profile names (comma separated)
                        (default: None = all profiles)
  --font FONT, -f FONT  fontname to set (default: "Ricty Discord Nerd")
  --size SIZE, -s SIZE  fontsize to set (default: 14)
```

toggle-gnome-terminal-transparency

```
tetutaro@ubuntu2104 > toggle-gnome-terminal-transparency --help
usage: toggle-gnome-terminal-transparency [-h] [--profiles PROFILES]
                                          [--percent PERCENT]

toggle gnome-terminal transparency

optional arguments:
  -h, --help            show this help message and exit
  --profiles PROFILES, -p PROFILES
                        profile names (comma separated)
                        (default: None = all profiles)
  --percent PERCENT, -c PERCENT
                        transparency percent (default: 20)
```
