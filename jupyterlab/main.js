const {app, BrowserWindow} = require('electron')
const path = require('path')

function createWindow () {
    var appname = path.basename(process.argv[0])
    var url = null
    const mainWindow = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            nodeIntegration: false
        }
    })
    mainWindow.setMenuBarVisibility(false)
    for (var i = 1; i < 10; i++) {
        var argc = process.argv[i]
        if (!(argc === undefined || argc.startsWith('-'))) {
            url = argc
            break
        }
    }
    if (url === null || url === undefined) {
        url = 'http://localhost:8888/lab'
    }
    console.log(`${appname}: ${url}`)
    mainWindow.loadURL(url)
}

app.whenReady().then(() => {
    createWindow()
    app.on('activate', function () {
        if (BrowserWindow.getAllWindows().length === 0) {
            createWindow()
        }
    })
})

app.on('window-all-closed', function () {
    if (process.platform !== 'darwin') app.quit()
})
