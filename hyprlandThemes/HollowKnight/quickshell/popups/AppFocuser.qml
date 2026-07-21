import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQml.Models

import "../utils" as Utils


PanelWindow {
    id: appFocuser

    property string fontFamily: "Trajan-Regular"

    property int menuWidth: 0
    property int popupWidth: 600
    property int screenHeight: 0
    property var closeCallback: function () {}
    WlrLayershell.layer: WlrLayer.Top
    exclusionMode: ExclusionMode.Ignore //Ignore 
    //WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    property var currentWindows: Hyprland.toplevels

    property var filteredWindows:currentWindows


    function fuzzyMatch(query, text) {
        query = query.toLowerCase()
        text = text.toLowerCase()

        var queryIndex = 0

        for (var i = 0; i < text.length; i++) {
            if (text[i] === query[queryIndex]) {
                queryIndex++

                if (queryIndex === query.length)
                    return true
            }
        }

        return false
    }

    function updateFilteredWindows(query : string) {
            console.log("Query:",query)
        if (query.length === 0) {
            filteredWindows=currentWindows
            return 
        }
        var result = []

        for (var i = 0; i < Hyprland.toplevels.values.length; i++) {
            var win = Hyprland.toplevels.values[i]

            var searchable = (win.wayland.appId + win.title.split("-")[0].split("—")[0] + win.title.split("-").pop())

            if (fuzzyMatch(query, searchable)) {
                result.push(win)
            }
        }

        filteredWindows = result
    }
    

    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }
    MouseArea {
        z: -1
        anchors.fill: parent
        onClicked: {
            appFocuser.visible=false
        }
    }
    

    color:"transparent"
    Image{
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.verticalCenter:parent.verticalCenter
        source:"../Images/Backpanel.png"
        height:1350
        width:1000
        }
    Rectangle {
        id: frame
        opacity: 1
        //anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        implicitHeight: 800
        implicitWidth: 500
        width:500
        color:"transparent"
        border.color:"#ffffff"
        border.width:0

        Image{
            id:topimage
            anchors.top:parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source:"../Images/Find_Menu_Top.png"
        }
        Image{
            id:bottomImage
            anchors.bottom:parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            source:"../Images/Find_Menu_Bottom.png" 
        }
        ColumnLayout{
            anchors.top:topimage.bottom
            //focus:true
            anchors.topMargin:10
            anchors.bottomMargin:10
            anchors.bottom:bottomImage.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: 500
            spacing:0
            TextField {
                id: searchBar
                focus: true
                width: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.leftMargin:50

                horizontalAlignment: Text.AlignHCenter
                color:"#ffffff"
                font.family: appFocuser.fontFamily
                font.weight: 200
                font.pixelSize: 20

                leftPadding: 0
                rightPadding: 0
                Text {
                    anchors.fill: parent
                    text: searchBar.text.length === 0 ? "Search..." : ""
                    color: "#20ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font: searchBar.font
                }
                cursorDelegate: Rectangle {
                    id: cursor

                    width: 1
                    height: 28
                    color: "#88ffffff"

                    SequentialAnimation on opacity {
                        loops: Animation.Infinite

                        NumberAnimation {
                            to: 0
                            duration: 3000
                        }

                        NumberAnimation {
                            to: 1
                            duration: 1000
                        }
                    }
                }

                background: Rectangle {
                    color: "transparent"
                    border.width: 0
                }
                onTextChanged: {
                    appFocuser.updateFilteredWindows(searchBar.text)
                    appsView.currentIndex = 0
                }
                Keys.onUpPressed: {
                    if (appsView.currentIndex > 0)
                        appsView.currentIndex--
                }
                Keys.onDownPressed: {
                    if (appsView.currentIndex < appsView.count - 1)
                        appsView.currentIndex++
                }
                Keys.onReturnPressed: {
                    if (appsView.currentItem){
                        Hyprland.dispatch("hl.dsp.focus({ window = \"address:0x" +appsView.currentItem.launch()+"\" })") 
                        //console.log("hl.dsp.focus({ window = \"address:\" .. " + modelData.address+" })")
                        appFocuser.visible = false 
                        searchBar.text=""
                    }
                        
                }
                Keys.onEnterPressed: { 
                    if (appsView.currentItem){
                        Hyprland.dispatch("hl.dsp.focus({ window = \"address:0x" +appsView.currentItem.launch()+"\" })") 
                        //console.log("hl.dsp.focus({ window = \"address:\" .. " + modelData.address+" })")
                        appFocuser.visible = false 
                        searchBar.text=""
                    }
                }                   
                Keys.onEscapePressed: {
                    appFocuser.visible=false
                }
            }
            Image {
                id:sperator
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../Images/Spacer_Horizontal.png"  
                sourceSize.width:450
                //height:50
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width:700
                //anchors.bottom:bottomImage.top
                anchors.top:seperator.top
                anchors.topMargin:10
                border.color:"#ffffff"
                border.width:0
                color:"transparent"
                implicitHeight:parent.height-50
            
                ListView{
                    clip: true
                    anchors.topMargin:20
                    anchors.bottomMargin:30
                    id:appsView
                    interactive: true
                    model:filteredWindows
                    flickableDirection: Flickable.VerticalFlick    
                    anchors.horizontalCenter: parent.horizontalCenter                        
                    maximumFlickVelocity: 500000   
                    //clip:true        
                    anchors.fill: parent
                    //anchors.margins: 8
                    spacing:0
                    currentIndex: 0
                    width:700
                    delegate: Item {
                        id: delegateRoot
                        width: parent.width
                        height: 50
                        function launch() {
                            return modelData.address
                        }
                        Rectangle{
                            id:containerRect
                            anchors.fill:parent
                            color:"transparent"
                            property bool selected: delegateRoot.ListView.isCurrentItem
                            anchors.horizontalCenter: parent.horizontalCenter
                            TapHandler {
                                onTapped: {
                                        modelData.execute();
                                        appFocuser.visible=false
                                    }
                            }
                            HoverHandler {
                                id: mouse
                                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                                cursorShape: Qt.PointingHandCursor
                                onHoveredChanged: {
                                if (hovered)
                                    appsView.currentIndex = index
                                }
                            }
                            RowLayout {
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 10
                                //property var iconPath: Utils.AppSearch.getIcon(modelData.icon)
                                //property bool selected: false
                                Image {
                                    source: containerRect.selected ? "../Images/Selector_Left.png" : ''
                                    sourceSize.width:30
                                    sourceSize.height:30
                                }
                                Text {
                                    color: "#ffffff"
                                    text: modelData.wayland.appId +' - '+ modelData.title.split("-")[0].split("—")[0]
                                    font.family: appFocuser.fontFamily
                                    font.weight: 200
                                    horizontalAlignment: Text.AlignHCenter
                                    font.pixelSize: 20
                                    //clip: true

                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 600
                                    maximumLineCount: 1
                                    elide: Text.ElideRight
                                }
                                Image {
                                    source: containerRect.selected ? "../Images/Selector_Right.png" : ''
                                    sourceSize.width:30
                                    sourceSize.height:30
                                }
                            }
                        }
                    }
                }
            }
        }  
    } 
}
