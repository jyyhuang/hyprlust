import QtQuick
import Quickshell.Hyprland

import qs.modules.common

Item {
    id: root
    property int workspaceId
    property var hyprWorkspace: Hyprland.workspaces.values.find(w => w.id === workspaceId)
    property bool isFocused: hyprWorkspace ? hyprWorkspace.focused : false
    property bool hasTopLevels: hyprWorkspace ? hyprWorkspace.toplevels != null : false

    width: 24
    height: 24

    Text {
        anchors.centerIn: parent
        text: root.workspaceId
        color: root.isFocused ? Config.colors.color13 : root.hasTopLevels ? Config.colors.color3 : Config.colors.foreground
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.hyprWorkspace.activate()
    }
}
