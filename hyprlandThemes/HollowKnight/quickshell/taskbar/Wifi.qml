import Quickshell
import Quickshell.Wayland
import Quickshell.Networking
import Quickshell.Io
import QtQuick

import QtQuick
import QtQuick.Layouts

Row {
    id: wifi
    property var wifiDevice : Networking.devices.values.find( d => d.type === DeviceType.Wifi)
    property var active : wifiDevice ? wifiDevice.networks.values.find(n => n.connected ): null
    property int cpuUsage: 0
    ////////UI/////
    Text{
        text:"  "
    }
    Image {
        source: wifiDevice.connected ? "../Images/Icon_HK_Awoken_Dream_Nail.png" : "../Images/Icon_HK_Dream_Nail.png"
        sourceSize.width: 30   
        sourceSize.height: 47 
        transform: Rotation { origin.x: 15; origin.y: 23; axis { x: 0; y: 0; z: 1 } angle: -90 }
           
    }
    //30 47+ rotation trasfo
    Text {  
        anchors.verticalCenter: parent.verticalCenter
    	color: "#ffffff"
    	leftPadding:10
    	font {
                family: taskbar.fontFamily
                pixelSize: taskbar.fontSize
                bold: true
    	}
    	text:(wifiDevice.connected ? active.name : "Disconnected")
    }
}