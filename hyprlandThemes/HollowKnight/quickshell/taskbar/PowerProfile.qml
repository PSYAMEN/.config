import Quickshell.Wayland
import Quickshell.Services.UPower
import Quickshell.Io
import QtQuick

import QtQuick
import QtQuick.Layouts

Row{
    id: powerprofile
    spacing:7

    property var battery: UPower.displayDevice
    property var profile:PowerProfiles.profile
    property bool charging : battery.state === UPowerDeviceState.Charging
    readonly property int level: Math.round(battery.percentage * 100)
    Image{
        anchors.top:parent.top
        anchors.topMargin:2
        source:"../Images/Nail_"+profile+".png"
        sourceSize.width: 60
        MouseArea {
            anchors.fill: parent
            onClicked:  {
                PowerProfiles.profile = (profile +1)% 3
            }
        }
    }
    Text{
        width: 35        
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
}