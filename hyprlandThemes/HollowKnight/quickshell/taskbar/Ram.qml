import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

import QtQuick
import QtQuick.Layouts

Row {
    spacing: 5
    id: ramMonitor
    property int ramUsage: 0
    Process {
        id: ramReader
        command: ["cat", "/proc/meminfo"]
        stdout: StdioCollector {
            onStreamFinished: {
            
                var mem = text
                var totalMatch = mem.match(/MemTotal:\s+(\d+)/)
                var availableMatch = mem.match(/MemAvailable:\s+(\d+)/)
                if (!totalMatch || !availableMatch)
                    return
                var total = Number(totalMatch[1])
                var available = Number(availableMatch[1])
                var used = total - available
                ramMonitor.ramUsage = Math.round(
                    (used / total) * 100
                )
            }
        }
    }
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            ramReader.running = true
        }    
    }

     Text {
        text: " "
    }
    Image {
        source: "../Images/Tram_Pass.png"
        sourceSize.width: 30
        sourceSize.height: 30
        //transform: Rotation { origin.x: 15; origin.y: 24; axis { x: 0; y: 0; z: 1 } angle: -90 }
    }
    Text {
        width: 30
        horizontalAlignment: Text.AlignRight
        id: ram
    	color: "#ffffff"
    	topPadding:6
    	font {
                family: taskbar.fontFamily
                pixelSize: taskbar.fontSize
                bold: true
    	}
    	text:ramMonitor.ramUsage+"%"
    	Timer {
                interval: 1000
                running: true
                repeat: true
        }
    }
}
