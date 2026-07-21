import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

import QtQuick
import QtQuick.Layouts

Row {
    id: cpuMonitor
    spacing: 0
    property var oldCpu: null
    property int cpuUsage: 0
    Process {
        id: cpuReader
        command: ["cat", "/proc/stat"]
        stdout: StdioCollector {
            onStreamFinished: {
                var line = text.split("\n")[0]
                var values = line
                    .trim()
                    .split(/\s+/)
                    .slice(1)
                    .map(Number)
                var idle = values[3] + values[4]
                var total = values.reduce((a, b) => a + b, 0)
                if (cpuMonitor.oldCpu !== null) {
                    var idleDelta = idle - cpuMonitor.oldCpu.idle
                    var totalDelta = total - cpuMonitor.oldCpu.total
                    cpuMonitor.cpuUsage = Math.round(
                        100 * (totalDelta - idleDelta) / totalDelta
                    )
                }
                cpuMonitor.oldCpu = {
                    idle: idle,
                    total: total
                }
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuReader.running = true
        }
    }

    Image {
        anchors.top:parent.top
        anchors.topMargin:-2
        source: "../Images/Kings_Brand_inventory.png"
        sourceSize.width: 30   
        sourceSize.height: 30 
    }
            
//30x47+ rotation trasfo
    Text {
        width: 30
        horizontalAlignment: Text.AlignRight
    	color: "#ffffff"
    	topPadding:6
    	font {
                family: taskbar.fontFamily
                pixelSize: taskbar.fontSize
                bold: true
    	}
    	text:cpuMonitor.cpuUsage+"% "
    	Timer {
                interval: 1000
                running: true
                repeat: true
        }
    }
}
