import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../../utils"

RowLayout {
    id: workspace
    spacing: 5

    Repeater {
        model: 5
        delegate: Item {
            required property int index
            property int workspaceId: index + 1
            property var hyprWorkspace: Hyprland.workspaces.values.find(w => w.id === workspaceId)
            property bool isActive: hyprWorkspace ? hyprWorkspace.active : false
            property bool isFocused: hyprWorkspace ? hyprWorkspace.focused : false

            width: 24
            height: 24

            Rectangle {
                anchors.fill: parent
                radius: 14
                color: isActive ? Colors.color5 : "transparent"
            }

            Text {
                anchors.centerIn: parent
                text: workspaceId
                color: isActive || isFocused ? Colors.background : Colors.color14
                font.pixelSize: 16
                font.family: Colors.fontFamily
            }

            MouseArea {
                anchors.fill: parent
                onClicked: hyprWorkspace.activate()
            }
        }
    }
}
