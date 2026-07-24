import Quickshell.Wayland
import Quickshell.Services.UPower
import Quickshell.Io
import QtQuick

import QtQuick
import QtQuick.Layouts

RowLayout{
    id: powerprofile
    spacing:7

    property var battery: UPower.displayDevice
    property var profile:PowerProfiles.profile
    property bool charging : battery.state === UPowerDeviceState.Charging
    readonly property int level: Math.round(battery.percentage * 100)
    Image{
        anchors.verticalCenter: parent.verticalCenter
        anchors.topMargin:0
        source:"../Images/Badge_"+profile+".png"
        sourceSize.width: 27
        sourceSize.height: 27

    }
    Text{
        width: 35   
        anchors.verticalCenter: parent.verticalCenter     
        horizontalAlignment: Text.AlignRight
        color: "#ffffff"        
        font {
            family: taskbar.fontFamily
            pixelSize: taskbar.fontSize
            bold: true
        }
        topPadding:0
        text:profile==0 ? "LOW" : (profile==1 ? "MED" : "HIGH") 
    }
    MouseArea {
        anchors.fill:parent
        onClicked:  {
            PowerProfiles.profile = (profile +1)% 3
        }
    }
}