# Schemes

color schemes.

## Guideline

- The background color represents the situation that line/word is in.
- The foreground color represents the category that word is belongs to.

The below table showes each color's system name ("colorX") and
the xterm color name for easily grasping the meanings each color has.
But, it is better not to be scolded by the xterm name.
You can set any color as you like.

|  name  |  xterm  | fg/bg |  Description                               |
|:------:|:-------:|:-----:|:-------------------------------------------|
| baseBG |   black |   bg  | Default (Darkest) Background               |
| baseBg |   black |   bg  | Darker Background (Used for gutter)        |
| baseBf |    grey |   bg  | Lighter Background (Used for popup menu)   |
| baseBF |  silver |   bg  | Lightest Background (Used for status bar)  |
| baseB1 |  maroon |   bg  | Error, Diff Deleted                        |
| baseB2 |   olive |   bg  | Visual Mode, Warning, Diff Changed         |
| baseB3 |   green |   bg  | Safety, Diff Inserted                      |
| baseB4 |    navy |   bg  | Normal Mode, Highlight                     |
| baseB5 |  purple |   bg  | Insert Mode, Emphasis                      |
| baseFG |   white |   fg  | Default Foreground                         |
| baseFg |   white |   fg  | Comments, Invisible                        |
| baseF1 |     red |   fg  | Error, Exception                           |
| baseF2 |  orange |   fg  | Todo                                       |
| baseF3 |  yellow |   fg  | Emphasis (Used for highlighting)           |
| baseF4 |    lime |   fg  | Statement (Conditional, Repeat), Special   |
| baseF5 |    aqua |   fg  | Constant (Number, String)                  |
| baseF6 |    blue |   fg  | Identifier(Function), Heading              |
| baseF7 | fuchsia |   fg  | Preprocesser (Include, Define), Link       |

## Directory & File

```
- /sources.yaml
- /schemes/
    +- scheme-group-A/
    |   +- scheme-1.yaml
    |   +- scheme-2.yaml
    +- scheme-group-B/
        +- scheme-3.yaml
```

The directory name (with dashes as separator) under the "schemes" directory
represents "scheme group".
scheme group can contain some schemes.
YAML formatted file (which filename with dashes as separator)
under the scheme group directory represents "scheme".

## Registration to sources.yaml

```source.yaml
schemes: [
    scheme-group-A,
    scheme-group-B,
]
```

all scheme (YAML file) under the regisrated scheme group
is automatically registered to the builder.

## Scheme File Format

```ansi.yaml
scheme: "ANSI"  # scheme name
author: "Ansi"  # author of scheme
base00: "000000"
base01: "800000"
base02: "008000"
base03: "808000"
base04: "000080"
base05: "800080"
base06: "008080"
base07: "c0c0c0"
base08: "808080"
base09: "ff0000"
base0A: "00ff00"
base0B: "ffff00"
base0C: "0000ff"
base0D: "ff00ff"
base0E: "00ffff"
base0F: "ffffff"
```

## Schemes

My favorite color schemes

* [chriskempson/base16-tomorrow-scheme](https://github.com/chriskempson/base16-tomorrow-scheme)
* [cocopon/iceberg.vim](https://github.com/cocopon/iceberg.vim)
* [Nord Theme](https://www.nordtheme.com/)
