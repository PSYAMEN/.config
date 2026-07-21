import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Networking


import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel 2.11
import QtCore

import "taskbar" as Taskbar
import "utils" as Utils
import "popups" as Popups



///hunter journal for applications
Scope{
    id: root


    property string themeRoot: Quickshell.env("HOME")
        + "/.config/hyprlandThemes/HollowKnight"
    FileView {
        id: currentBackgroundFile

        path: Quickshell.env("HOME") +
            "/.config/hyprlandThemes/HollowKnight/mpvplayer/saveBG"

        watchChanges: true

        onLoaded: {
            console.log("Loaded background:", text())
        }
    }
    Timer {
        interval: 100
        running: true
        repeat: false
        onTriggered: {

            console.log("Timer sees", Hyprland.monitors.values.length, "monitors");

            if (Hyprland.monitors.values.length === 0)
                return;

            running = false;
            const cmd = [
                themeRoot + "/scripts/background.sh",
                ...startbackscreen.getArgs()
            ];

            console.log("Starting with", JSON.stringify(cmd));

            startbackscreen.command = cmd;
            startbackscreen.running = true;
        }
    }
    Process { 
        id:startbackscreen
        running:false
        function getArgs() {
            console.log("Monitor count:", Hyprland.monitors.values.length);

            let result = []; 
            Hyprland.monitors.values.forEach(monitor => {
                console.log("Found monitor:", monitor.name);
                result.push(monitor.name);
                result.push((monitor.width / monitor.height).toString());
            });
            let background = currentBackgroundFile.text().trim();

            if (background === "") {
                background = `${themeRoot}/Backgrounds/Classic.gif`;
            }
            result.push(background);
            return result;
        }
        
        stdout: StdioCollector {
            onStreamFinished: {
                console.log("STDOUT:", text)
            }
        }

        stderr: StdioCollector {
            onStreamFinished: {
                console.log("STDERR:", text)
            }
        }
        onExited: {
            running = false
            console.log(command)
            console.log("Launching:", JSON.stringify(command))
            console.log("exit code:", exitCode)
        }
    }

    
    Popups.AppLauncher{
        id:launcher
        visible:false 
    } 
    Popups.AppFocuser{
        id:focuser
        visible:false
    }
    Popups.Background{
        id:backgroundSwitcher
        visible:false}

    Popups.Profile{
        id:profile
        visible:false
    }

    Taskbar.Bar {}


    IpcHandler {
        target: "appLauncher"
        function makeVisible(): void { launcher.visible=true }
    }


    IpcHandler {
        target: "appFocuser"
        function makeVisible(): void { focuser.visible=true }
    }
    IpcHandler {
        target: "background"
        function makeVisible(): void { backgroundSwitcher.visible=true }
    }
    IpcHandler {
        target: "profileSwitcher"
        function makeVisible(): void { profile.visible=true }
    }
}


