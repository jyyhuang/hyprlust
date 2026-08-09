import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.modules.bar.components
import qs.common

PanelWindow {
    id: root

    anchors.top: true
    anchors.left: true
    anchors.right: true

    color: "transparent"
    implicitHeight: Config.bar.height

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(Config.colors.background.r, Config.colors.background.g, Config.colors.background.b, 0.8)
        anchors.leftMargin: 6
        anchors.topMargin: 6
        anchors.rightMargin: 6

        radius: 10
        border.width: 1
        border.color: Config.colors.color14

        RowLayout {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10

            Text {
                text: Config.icons.arch
                color: Config.colors.color14
                font.pixelSize: Config.font.fontSize
                font.family: Config.font.fontFamily
            }

            Workspaces {}

            IdleButton {
                window: root
            }
        }

        RowLayout {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
            spacing: 10

            Memory {}
            Battery {}
            Clock {}
            Power {}
        }
    }
}
