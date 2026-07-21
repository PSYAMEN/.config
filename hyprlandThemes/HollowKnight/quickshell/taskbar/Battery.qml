import Quickshell
import Quickshell.Wayland
import Quickshell.Services.UPower
import Quickshell.Io
import QtQuick

import QtQuick
import QtQuick.Layouts

Row{
    id: audio
    spacing:7

    property var battery: UPower.displayDevice
    property var profile:PowerProfiles.profile
    property bool charging : battery.state === UPowerDeviceState.Charging
    readonly property int level: Math.round(battery.percentage * 100) 
    //readonly property int level:20
    Image{
        anchors.top:parent.top
        anchors.topMargin:-2
        source: level>80 ? "../Images/Soul_Vessel_Full.png" : (level<=20 ? "../Images/Soul_Vessel_Empty.png" : "")
        sourceSize.width: 25
        sourceSize.height: 25
    }
    AnimatedImage {
        anchors.top:parent.top
        anchors.topMargin:-2
        source: level>80? "" : (level>60 ?  "../Images/Soul_Vessel_High.gif" : (level>40 ? "../Images/Soul_Vessel_Medium.gif" : (level>20 ? "../Images/Soul_Vessel_Low.gif" : "")))
        sourceSize.width: 25
        sourceSize.height: 25
        paused: false
        //loops: AnimatedImage.Infinite
    }

    Text {
        width: 35
        horizontalAlignment: Text.AlignRight
        color: "#ffffff"
        topPadding:3
        font {
            family: taskbar.fontFamily
            pixelSize: taskbar.fontSize
            bold: true
        }
        text: level + '% '
    }
}

