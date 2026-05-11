import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../../utils"

Item {
    id: power

    width: 24
    height: 24

    property bool menuOpen: false

    Text {
        id: powerText
        anchors.centerIn: parent
        text: "󰐥"
        color: Colors.color14
        font.pixelSize: 16
        font.family: Colors.fontFamily
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.OpenHandCursor
        onClicked: {
            power.menuOpen = !power.menuOpen
        }
    }

    PowerDisplay {
        visible: power.menuOpen
    }
}
