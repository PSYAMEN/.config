import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts


Row{
    anchors.horizontalCenter:parent.horizontalCenter
    anchors.bottom:parent.bottom
    Item {
        id: cava

        property var cavaValues: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

        Process {

            command: [
                "cava",
                "-p",
                "/home/psyamen/.config/hyprlandThemes/HollowKnight/cava/confs/waybarConf1"
            ]

            running: true

            stdout: SplitParser {
                onRead: data => {
                    //console.log("RAW:", JSON.stringify(data))
                    let values = data.trim().split(";")
                    let output = []

                    for (let i = 0; i < 16; i++) {
                        let value = Number(values[i])

                        if (isNaN(value))
                            value = 0

                        output[i] = value
                    }

                //console.log("CAVA PARSED:", output)
                    cava.cavaValues = output
                }
            }
            onExited: {
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