pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick

import qs.common
import qs.modules.notifications

Scope {
    id: root
    property bool notificationCenterOpen: false

    ListModel {
        id: history
    }

    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true
        onNotification: n => {
            history.insert(0, {
                summary: n.summary,
                body: n.body,
                appName: n.appName,
                urgency: n.urgency,
                time: Qt.formatDateTime(new Date(), "hh:mm AP")
            });
            n.tracked = true;
        }
    }

    IpcHandler {
        target: "notifications"
        function toggle(): void {
            root.notificationCenterOpen = !root.notificationCenterOpen;
        }
        function show(): void {
            root.notificationCenterOpen = true;
        }
        function hide(): void {
            root.notificationCenterOpen = false;
        }
    }

    NotificationCard {
        server: server
    }

    NotificationCenter {
        notificationCenterOpen: root.notificationCenterOpen
        history: history
    }
}
