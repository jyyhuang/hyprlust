import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs.modules.common
import qs.modules.bar.components

RowLayout {
    id: root
    spacing: 5

    Repeater {
        model: 5
        delegate: WorkspaceButton {
            workspaceId: index + 1
        }
    }

    property var extraWorkspaces: Hyprland.workspaces.values.filter(w => (w.focused || w.toplevels != null) && w.id > 5)

    Repeater {
        model: root.extraWorkspaces
        delegate: WorkspaceButton {
            workspaceId: modelData.id
        }
    }
}
