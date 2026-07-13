import QtQuick
import Quickshell.Hyprland

import qs.modules.common

Item {
    property int workspaceId
    property var hyprWorkspace: Hyprland.workspaces.values.find(w => w.id === workspaceId)
    property bool isActive: hyprWorkspace ? hyprWorkspace.active : false
    property bool isFocused: hyprWorkspace ? hyprWorkspace.focused : false

    width: 24
    height: 24

    Rectangle {
        anchors.fill: parent
        radius: 14
        color: isActive ? Config.colors.color5 : "transparent"
    }

    Text {
        anchors.centerIn: parent
        text: workspaceId
        color: isActive || isFocused ? Config.colors.background : Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
    }

    MouseArea {
        anchors.fill: parent
        onClicked: hyprWorkspace.activate()
    }
}
