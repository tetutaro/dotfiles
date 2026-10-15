# install and setup xremap

Emacs-like key bindings for specific applications (Chrome, Slack, ...).
xremap remaps keys at the evdev level,
so it also works in Wayland native applications and inside web pages
(Google Docs, Slack, ...), where AutoKey (X11 only) does not.

## What this does

* install xremap with the `wlroots` feature (if it has not been installed)
    * application-specific remapping via labwc (Ubuntu Budgie)
* add the user to the `input` group (if not yet)
    * NOTE: every process of the user can read all key inputs
* NOTE: `/dev/uinput` must be writable by the `input` group
    * `80-uinput.rules` of the ydotool package does it
      (uinput is built into the Ubuntu kernel, so no module needs loading)
    * without ydotool, add the same rule to `/etc/udev/rules.d/`:
      `KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"`
* create symbolic links of config files
    * `config.yml` -> `~/.config/xremap/config.yml`
    * `xremap.desktop` -> `~/.config/autostart/xremap.desktop`

## What to do

* `> ./install.sh`
* re-login

## Tips

* names of applications (`application.only` in `config.yml`)
    * `> wlrctl toplevel list`
* run manually to see what happens
    * `> xremap --watch=device ~/.config/xremap/config.yml`
* see why a remap does not match (key names and detected application)
    * `> RUST_LOG=debug xremap --watch=device ~/.config/xremap/config.yml`
* modifiers changed by XKB (e.g. `ctrl:nocaps` of Budgie) are invisible to xremap
    * so `config.yml` also maps CapsLock to Ctrl with `modmap`
* `Ctrl-O` in Chrome/JupyterLab is sent as `Henkan` to toggle the IME
    * add `Henkan` to the trigger keys of fcitx5 (`fcitx5-configtool`)
