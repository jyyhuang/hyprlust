import QtQuick
import Quickshell.Io

import qs.common

Item {
    id: root

    implicitWidth: networkText.implicitWidth
    implicitHeight: networkText.implicitHeight

    Text {
        id: networkText
        text: "hello"
        anchors.centerIn: parent
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }
}
