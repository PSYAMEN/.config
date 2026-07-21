import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

import QtQuick
import QtQuick.Layouts

Row {
    id: tempMonitor
    property int temperature: 10
    Process {
        id: tempReader
        command: [
            "cat",
            "/sys/class/hwmon/hwmon9/temp1_input"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                var millidegrees = Number(text.trim())
                tempMonitor.temperature =
                    Math.round(millidegrees / 1000)
            }
        }
    }
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            tempReader.running = true
        }
    }

    Image {
        anchors.top:parent.top
        anchors.topMargin:0
        source: "../Images/Grimm_flame_pin.png"
        sourceSize.width: 30
        sourceSize.height: 30
    }
    Text {
        width: 35
        horizontalAlignment: Text.AlignRight
        id: temp
    	color: "#ffffff"
    	topPadding:6
    	font {
                family: taskbar.fontFamily
                pixelSize: taskbar.fontSize
                bold: true
    	}
    	text:tempMonitor.temperature + "°C "
    	Timer {
                interval: 1000
                running: true
                repeat: true
            }
    }
}



