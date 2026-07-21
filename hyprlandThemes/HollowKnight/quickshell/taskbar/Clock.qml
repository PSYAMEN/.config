import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

import QtQuick
import QtQuick.Layouts
Row {
    anchors.centerIn: parent
    spacing: 5
    Image {
        source: "../Images/Wayward_Compass.png"
        sourceSize.width: 30
        sourceSize.height: 30
    }
    SystemClock{
        id: clock
        precision:SystemClock.Minutes
    }
    Text {
        color: "#ffffff"
        topPadding:7
        font {
            family: taskbar.fontFamily
            pixelSize: taskbar.fontSize
            bold: true
        }
        text: Qt.formatDateTime(clock.date, "HH:mm")
    }


}