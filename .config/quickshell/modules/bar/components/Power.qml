import QtQuick
import QtQuick.Layouts
import Quickshell

import "../../../utils"
import qs.modules.common

Item {
    id: power

    width: 24
    height: 24

    property bool menuOpen: false

    Text {
        id: powerText
        anchors.centerIn: parent
        text: "󰐥"
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.OpenHandCursor
        onClicked: {
            power.menuOpen = !power.menuOpen;
        }
    }

    PowerDisplay {
        visible: power.menuOpen
    }
}
