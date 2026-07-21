import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

Row {
    id : root
    spacing: 0

    // Workspaces
    Repeater {
        model: 9
        Image {
            anchors.verticalCenter: parent.verticalCenter
            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
         	source: isActive
                    ? "../Images/Charm_Notch_Selected.png": (ws ? "../Images/Charm_Notch.png" : "")
            sourceSize.width:30
            sourceSize.height:30
        	MouseArea {
                anchors.fill: parent
                    onClicked: Hyprland.dispatch("hl.dsp.focus({workspace =" +(index+1)+ "})")
        	}
        }

    }
}