import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules.bar.components
import "../../utils"

PanelWindow {
    id: bar

    anchors.top: true
    anchors.left: true
    anchors.right: true

    color: "transparent"
    implicitHeight: 44

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(Colors.background.r, Colors.background.g, Colors.background.b, 0.8)
        anchors.leftMargin: 6
        anchors.topMargin: 6
        anchors.rightMargin: 6

        radius: 10
        border.width: 1
        border.color: Colors.color14

        RowLayout {

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            anchors.leftMargin: 10
            anchors.rightMargin: 10

            Text {
                color: Colors.color14
                text: ""
            }

            Workspaces {}
        }

        RowLayout {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10

            Power {}
        }
    }
}
