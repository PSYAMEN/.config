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

    property var sink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [sink]
    }

    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 420
    Image{
        source:"../Images/Icon_HK_Howling_Wraiths.png"
        sourceSize.width: 27
        sourceSize.height: 30
    }
    Text {
        color: "#ffffff"
        topPadding:6
        font {
            family: taskbar.fontFamily
            pixelSize: taskbar.fontSize
            bold: true
        }
        text: audio.vol + '%'
    }
}