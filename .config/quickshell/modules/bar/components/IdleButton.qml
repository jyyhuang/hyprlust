import Quickshell.Wayland
import QtQuick

import qs.modules.common

Item {
    id: root
    property bool isEnabled: false
    required property var window

    implicitWidth: idleText.implicitWidth
    implicitHeight: idleText.implicitHeight

    IdleInhibitor {
        enabled: root.isEnabled
        window: root.window
    }

    Text {
        id: idleText
        anchors.centerIn: parent
        text: root.isEnabled ? " " : ""
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.OpenHandCursor
        onClicked: {
            root.isEnabled = !root.isEnabled;
        }
    }
}
