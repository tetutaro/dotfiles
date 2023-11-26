# JupyterLab on pipx

## Necessities

* pipx
    * pipx is installed in [zsh](/zsh/)

## What this does

* install jupyterlab and packages with pipx (if they have not been installed)
    * packages: python-lsp-server[all], jupyterlab-lsp
* create symbolic links of client config file
    * `user-settings` -> `~/.jupyter/lab/user-settings`
* create symbolic link of server config file
    * `jupyter_lab_config.py.linux` / `jupyter_lab_config.py.macos` -> `${pipx_jupyterlab_etc}/jupyter_lab_config.py`
* install jupyterlab-desktop

## What to do

* `> ./install.sh`

## OSs confirmed that the app works

* Mac OSX: Mac OSX 11.6 (Big Sur)
* Linux: Ubuntu 21.04 (Hirsute Hippo) kernel 5.11.0-37-generic

## Use the JupyterLab with the app

* go to project directory
* Run the JupyterLab
    * `> jupyter-lab`
