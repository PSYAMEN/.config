import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

import QtQuick
import QtQuick.Layouts

ShellRoot{
    Variants{
        model:Quickshell.screens
        PanelWindow {
            id: taskbar
            required property var modelData
            screen:modelData
            // Theme
            property color colBg: "#000000"
            property color colFg: "#a9b1d6"
            property color colMuted: "#444b6a"
            property color colCyan: "#0db9d7"
            property color colBlue: "#7aa2f7"
            property color colYellow: "#e0af68"
            property string fontFamily: "Trajan-Regular"
            property int fontSize: 14
            // System data
            property int memUsage: 0
            property var lastCpuIdle: 0
            property var lastCpuTotal: 0
            // Processes and timers here...
            anchors.top: true
            anchors.left: true
            anchors.right: true
            implicitHeight: 65


            color: "#00000000"
            margins{
            	top:0
            	right:0
            	left:0
            }

            Rectangle {
                id: info
                width:parent.width-4
                height:parent.height-15
                anchors.top:parent.top
                anchors.horizontalCenter:parent.horizontalCenter
                anchors.topMargin:10
                color: "#000000"
                border.color: "#ffffff"
                border.width: 0
                radius:5

                RowLayout {
                    anchors.fill:parent
                    anchors.leftMargin:10
                    anchors.rightMargin:10
                    anchors.topMargin:0
                    spacing:5

                    Workspaces {}

                    Spacer{}

                    Wifi {}

                    Spacer{}

                    Audio {}



                    Clock {}

                    Item {
                        Layout.fillWidth: true
                    }
                    PowerProfile{}
                    Spacer{}
                    Battery {}

                    Spacer{}

                    Temp {}

                    Spacer{}

                    Cpu {}

                    Spacer{}

                    Ram {}
                } 
            }
            Stereo{}
            Row{
                spacing:0
                anchors.top:info.top
                anchors.horizontalCenter:parent.horizontalCenter
                anchors.fill:parent
                Image{
                    anchors.right:parent.horizontalCenter
                    anchors.rightMargin:59
                    source: "../Images/Top_Bar_Side(Right).png"
                    width: parent.width/2-20
                    sourceSize.height: 20
                    mirror:true
                }
                Image{
                    anchors.horizontalCenter:parent.horizontalCenter
                    source: "../Images/Top_Bar_Middle.png"
                    sourceSize.width: 200
                    sourceSize.height: 20
                }
                Image{
                    anchors.left:parent.horizontalCenter
                    anchors.leftMargin:59
                    source: "../Images/Top_Bar_Side(Right).png"
                    width: parent.width/2-20
                    sourceSize.height: 20
                }
            }
            Row{
                spacing:0
                anchors.top:info.bottom
                anchors.topMargin:10
                anchors.horizontalCenter:parent.horizontalCenter
                height:10
                width:parent.width
                Image{
                    anchors.right:parent.horizontalCenter
                    anchors.rightMargin:59
                    source: "../Images/Top_Bar_Side(Right).png"
                    width: parent.width/2-20
                    sourceSize.height: 20
                    mirror:true
                    transform: Scale{ yScale: -1 }
                }
                Image{
                    anchors.horizontalCenter:parent.horizontalCenter
                    source: "../Images/Top_Bar_Middle2.png"
                    sourceSize.width: 200
                    sourceSize.height: 18
                    transform: Scale{ yScale: -1 }
                }
                Image{
                    anchors.left:parent.horizontalCenter
                    anchors.leftMargin:59
                    source: "../Images/Top_Bar_Side(Right).png"
                    width: parent.width/2-20
                    sourceSize.height: 20
                    transform: Scale{ yScale: -1 }
                }
            }

        }    
    }
}

