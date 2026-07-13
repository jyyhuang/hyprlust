import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import qs.modules.common

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
                time: Qt.formatDateTime(new Date(), "HH:mm")
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

    //notification card
    PanelWindow {
        anchors {
            top: true
            right: true
        }
        margins {
            top: 12
            right: 12
        }
        implicitWidth: 380
        implicitHeight: Math.max(1, column.implicitHeight)
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        ColumnLayout {
            id: column
            width: parent.width
            spacing: 10
            Repeater {
                model: server.trackedNotifications
                delegate: Rectangle {
                    id: card
                    required property var modelData

                    Timer {
                        running: card.modelData.urgency !== NotificationUrgency.Critical
                        interval: Config.notifications.timeout
                        onTriggered: card.modelData.dismiss()
                    }

                    Layout.fillWidth: true
                    Layout.preferredHeight: 60
                    radius: 8
                    color: Config.colors.background
                    border.width: 2
                    border.color: card.modelData.urgency === NotificationUrgency.Critical ? Config.colors.color13 : Config.colors.color14

                    RowLayout {
                        id: layout
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10
                        Image {
                            Layout.preferredWidth: 36
                            Layout.preferredHeight: 36
                            Layout.alignment: Qt.AlignTop
                            fillMode: Image.PreserveAspectFit
                            visible: source.toString() !== ""
                            source: card.modelData.image || card.modelData.appIcon || ""
                        }
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2
                            Text {
                                Layout.fillWidth: true
                                text: card.modelData.summary
                                color: Config.colors.color14
                                font.family: Config.font.fontFamily
                                font.pixelSize: Config.font.fontSize
                                font.bold: true
                                elide: Text.ElideRight
                            }

                            Text {
                                Layout.fillWidth: true
                                visible: text !== ""
                                text: card.modelData.body
                                color: Config.colors.foreground
                                font.family: Config.font.fontFamily
                                font.pixelSize: Config.font.fontSize - 1
                                wrapMode: Text.WordWrap
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: card.modelData.dismiss()
                    }
                }
            }
        }
    }

    //notification center
    PanelWindow {
        visible: root.notificationCenterOpen
        anchors {
            top: true
            right: true
        }
        margins {
            top: 12
            right: 12
        }
        implicitWidth: 380
        implicitHeight: notificationCenterCol.implicitHeight + 24
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        Rectangle {
            anchors.fill: parent
            radius: 10
            color: Config.colors.background
            border.width: 2
            border.color: Config.colors.color14

            ColumnLayout {
                id: notificationCenterCol
                anchors.fill: parent
                anchors.margins: 12
                spacing: 10

                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        Layout.fillWidth: true
                        text: "Notifications"
                        color: Config.colors.color1
                        font.family: Config.font.fontFamily
                        font.pixelSize: Config.font.fontSize + 2
                        font.bold: true
                    }
                    Text {
                        text: "Clear All"
                        visible: history.count > 0
                        color: Config.colors.color13
                        font.family: Config.font.fontFamily
                        font.pixelSize: Config.font.fontSize - 1
                        MouseArea {
                            anchors.fill: parent
                            onClicked: history.clear()
                        }
                    }
                }

                Repeater {
                    model: history
                    delegate: Rectangle {
                        id: centerCard
                        required property var modelData

                        Layout.fillWidth: true
                        Layout.preferredHeight: 60
                        radius: 8
                        color: Config.colors.background
                        border.width: 2
                        border.color: modelData.urgency === NotificationUrgency.Critical ? Config.colors.color13 : Config.colors.color14

                        ColumnLayout {
                            id: cardCol
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 2

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 6
                                Text {
                                    Layout.fillWidth: true
                                    text: centerCard.modelData.summary
                                    color: Config.colors.foreground
                                    font.family: Config.font.fontFamily
                                    font.pixelSize: Config.font.fontSize
                                    font.bold: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: centerCard.modelData.time
                                    color: Config.colors.color14
                                    font.family: Config.font.fontFamily
                                    font.pixelSize: Config.font.fontSize - 3
                                }

                                Text {
                                    text: "x"
                                    color: Config.colors.color14
                                    font.family: Config.font.fontFamily
                                    font.pixelSize: Config.font.fontSize - 1
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: history.remove(index)
                                    }
                                }
                            }

                            Text {
                                Layout.fillWidth: true
                                visible: centerCard.modelData.body !== ""
                                text: centerCard.modelData.body
                                color: Config.colors.foreground
                                font.family: Config.font.fontFamily
                                font.pixelSize: Config.font.fontSize - 1
                                wrapMode: Text.WordWrap
                            }

                            Text {
                                visible: centerCard.modelData.appName !== ""
                                text: centerCard.modelData.appName
                                color: Config.colors.color14
                                font.family: Config.font.fontFamily
                                font.pixelSize: Config.font.fontSize - 3
                            }
                        }
                    }
                }
            }
        }
    }
}
