import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell

import qs.modules.common

Item {
    id: root
    property bool menuOpen: false

    implicitWidth: powerText.implicitWidth
    implicitHeight: powerText.implicitHeight

    Text {
        id: powerText
        anchors.centerIn: parent
        text: "󰐥"
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.OpenHandCursor
        onClicked: {
            root.menuOpen = !root.menuOpen;
        }
    }

    Process {
        id: process
        command: ["bash", "-c", Quickshell.env("HOME") + "/.config/scripts/powermenu.sh"]
        running: root.menuOpen
        stdout: StdioCollector {
            onStreamFinished: {
                console.log(this.text.trim());
            }
        }
        onExited: root.menuOpen = false
    }
}
