# YapyterLab App

Yet Another JupyterLab App: The simplest desktop application only for [JupyterLab](https://github.com/jupyterlab/jupyterlab), based on [Electron](https://www.electronjs.org/)

![](screenshot.png)

## Motivation

As you know, [JupyterLab App](https://github.com/jupyterlab/jupyterlab_app) is the awesome desktop application for JupyterLab, developed by [Project Jupyer](https://jupyter.org/).

[JupyterLab App](https://github.com/jupyterlab/jupyterlab_app) contains the desktop application (JupyterLab client) based on Electron and Python virtual environment (venv) with the JupyterLab server.

But it is too much for me. I want to run the JupyterLab server on my own venv. I just need a simple application which only access to `http://localhost:8888/lab`.

On the other hand, [Electron](https://www.electronjs.org/) provides a great sample implementation: [electron-quick-start](https://github.com/electron/electron-quick-start). It is a simple desktop application that only displays `index.html` with `electron.BrowserWindow().loadFile('index.html')`.

That is very close to what I'm looking for. The app I need is doing `electron.BrowserWindow().loadURL('http://localhost:8888/lab')` instead of `loadFile()`.

So, I made it.

## Necessities for building the app

* git
* [Node.js](https://nodejs.org/)
    * My recommended way to install Node.js
        * Install [nodenv](https://github.com/nodenv/nodenv)
            * `> git clone git://github.com/nodenv/nodenv.git ~/.nodenv`
        * Install [node-build](https://github.com/nodenv/node-build)
            * `> git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build`
        * Install [node-build-update-defs](https://github.com/nodenv/node-build-update-defs)
            * `> git clone https://github.com/nodenv/node-build-update-defs.git ~/.nodenv/plugins/node-build-update-defs`
        * Setup nodenv
        * Install Node.js with nodenv and set it as global use
            * `> nodenv install --list`
            * `> nodenv install x.x.x`
            * `> nodenv global x.x.x`
* [yarn](https://yarnpkg.com/)
    * My recommended way to install yarn
        * `> npm install -g yarn`
            * `npm` is automatically installed when you install Node.js
            * Don't forget to add `-g` option

## Build the app

* `> git clone https://github.com/tetutaro/yapyterlab_app.git`
* `> cd yapyterlab_app`
* `> yarn`
* `> yarn build`
* The built package is generated under the `build` directory
    * Mac OSX: JupyterLab-x.x.x.dmg
    * Linux: JupyterLab_x.x.x_amd64.snap
* The environment confirmed that the app can be built
    * Node.js: 16.10.0
    * npm: 7.24.0
    * yarn: 1.22.15
    * electron: 15.1.1
    * electron-builder: 22.11.7

## Install the app

* How to install
    * Mac OSX: `> open build/JupyterLab-x.x.x.dmg` and drug the icon to the `Applications` folder
    * Linux: `> sudo snap install --dangerous build/JupyterLab_x.x.x_amd64.snap`
* OSs confirmed that the app works
    * Mac OSX: Mac OSX 11.6 (Big Sur)
    * Linux: Ubuntu 21.04 (Hirsute Hippo) kernel 5.11.0-37-generic

## JupyterLab configs

* To know the config directories where the JupyterLab reads config files
    * `> jupyter --paths`
* Place a config file with following contents under the filename `jupyter_lab_config.py` in one of the above config directories

```
c.ServerApp.use_redirect_file = False
# For Mac OSX
c.ServerApp.browser = '/Applications/JupyterLab.app/Contents/MacOS/JupyterLab %s'
# For Linux
c.ServerApp.browser = '/snap/bin/jupyterlab %s'
```

## Use the JupyterLab with the app

* Run the JupyterLab
    * `> jupyter-lab`
