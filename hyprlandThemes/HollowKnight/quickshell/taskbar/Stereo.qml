import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel 2.11
import QtCore


Row{
    anchors.horizontalCenter:parent.horizontalCenter
    anchors.bottom:parent.bottom
    Item {
        id: cava

        property var cavaValues: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

        Process {
            id:cavaCommand
            property string homeDir: Quickshell.env("HOME")
            command: [
                "cava",
                "-p",
                homeDir+"/.config/hyprlandThemes/HollowKnight/cava/confs/waybarConf1"
            ]  

            running: true
            //Component.onCompleted: {
            //    console.log("HOME:", homeDir)
            //    console.log("Config path:", command[2])
            //    console.log("Command:", JSON.stringify(command))
            //}
            stdout: SplitParser {
                onRead: data => {
                //console.log("CAVA COMMAND:", command)
                    //console.log("RAW:", JSON.stringify(data))
                    let values = data.trim().split(";")
                    let output = []

                    for (let i = 0; i < 16; i++) {
                        let value = Number(values[i])

                        if (isNaN(value))
                            value = 0

                        output[i] = value
                    }

                    // /console.log("CAVA COMMAND:", command)
                    cava.cavaValues = output
                }
            }
            onExited: {
                console.log("CAVA COMMAND:", command)
                running = true
            }
        }
    }
    spacing:130
    Row{
        spacing:-4
        Repeater {
            model: 8
            Image {
                width: 24
                height: 52
                source: "../Images/Crystal_"  
                        + (cava.cavaValues[index])
                        + ".png"
                fillMode: Image.PreserveAspectFit
            }
        }
    }
    Row{
        spacing:-4
        Repeater {
            model: 8
            Image {
                width: 24
                height: 52
                source: "../Images/Crystal_"  
                        + (cava.cavaValues[index+8])  
                        + ".png"
                fillMode: Image.PreserveAspectFit
                mirror: true
            }
        }
    }
}