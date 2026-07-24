import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick

import QtQuick
import QtQuick.Layouts

Row{
    id: audio
    spacing:5

    property var mic: Pipewire.defaultAudioSource

    PwObjectTracker {
        objects: [mic]
    }

    Image{
        anchors.verticalCenter:parent.verticalCenter
        source: !mic.audio.muted ? "../Images/Map_Pin_Knight.png" : "../Images/Map_Pin_Hornet.png"
        sourceSize.width: 30
        sourceSize.height: 30
        MouseArea{
            anchors.fill:parent
            onClicked: {
                mic.audio.muted=!mic.audio.muted; 
            }
        }
    }


}