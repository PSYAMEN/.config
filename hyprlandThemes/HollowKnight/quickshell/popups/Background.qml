import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Qt.labs.folderlistmodel 2.11
import QtCore

import "../utils" as Utils


PanelWindow {
    id: appLauncher

    property string fontFamily: "Trajan-Regular"

    property int menuWidth: 0
    property int popupWidth: 600
    property int screenHeight: 0
    property var closeCallback: function () {}
    WlrLayershell.layer: WlrLayer.Top
    exclusionMode: ExclusionMode.Ignore //Ignore
    //WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    property string themeRoot: Quickshell.env("HOME")
    + "/.config/hyprlandThemes/HollowKnight"


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
            appLauncher.visible=false
        }
    }
    

    color:"transparent"
    Image{
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.verticalCenter:parent.verticalCenter
        source:"../Images/Backpanel.png"
        height:1500
        width:1000
        }
    Rectangle {
        id: frame
        opacity: 1
        //anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        implicitHeight: 900
        implicitWidth: 500
        width:500
        color:"transparent"
        border.color:"#ffffff"
        border.width:0

        Image{
            id:topimage
            anchors.top:parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source:"../Images/Sly_Menu.png"
        }
        Image{
            id:bottomImage
            anchors.bottom:parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            source:"../Images/Shop_Menu_Bottom.png"
        }
        ColumnLayout{
            anchors.top:topimage.bottom
            //focus:true
            anchors.topMargin:10
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
                font.family: appLauncher.fontFamily
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
                    appLauncher.currentApps = Utils.AppSearch.fuzzyQuery(text)
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
                        appsView.currentItem.runProcess()  
                        searchBar.text=""
                    }
                        
                }                    
                Keys.onEscapePressed: {
                    appLauncher.visible=false
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
                border.color:"#ffffff"
                border.width:0
                color:"transparent"
                implicitHeight:parent.height-50
                FolderListModel {
                    id: folderModel
                    folder: "file://"+themeRoot+"/Backgrounds"   
                    nameFilters: [ "*" ]
                }
                ListView{
                    clip: true
                    anchors.topMargin:10
                    anchors.bottomMargin:30
                    id:appsView
                    //focus: true
                    interactive: true
                    model:folderModel
                    
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
                        function runProcess() {
                            replace.running = true
                            appLauncher.visible=false
                        }
                        Process { 
                            id:replace
                            running:false
                            function getArgs() {
                                let result = [];

                                Hyprland.monitors.values.forEach(monitor => {
                                    result.push(monitor.name);
                                    result.push(monitor.width / monitor.height); 
                                });

                                result.push(`${themeRoot}/Backgrounds/${model.fileName}`);

                                return result;
                            }
                            command: [
                                themeRoot+"/scripts/background.sh",
                                ...getArgs()
                            ]
                        
                            onExited: {
                                running = false
                                console.log(command)
                                console.log("exit code:", exitCode)
                            }
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
                                        appLauncher.visible=false
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
                                property var iconPath: Utils.AppSearch.getIcon(modelData.icon)
                                property bool selected: false
                                Image {
                                    source: containerRect.selected ? "../Images/Selector_Left.png" : ''
                                    sourceSize.width:30
                                    sourceSize.height:30
                                }
                                Text {
                                    color: "#ffffff"
                                    text: model.fileName.split('.')[0]
                                    font.family: appLauncher.fontFamily
                                    font.weight: 200
                                    font.pixelSize: 20
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
