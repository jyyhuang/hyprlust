import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
    id: workspace
    spacing: 5

    Repeater {
        model: 5
        delegate: WorkspaceButton {
            workspaceId: index + 1
        }
    }

    property var extraWorkspace: Hyprland.workspaces.values.find(w => w.focused && w.id > 5)

    WorkspaceButton {
        visible: extraWorkspace != null
        workspaceId: extraWorkspace ? extraWorkspace.id : 0
    }
}
