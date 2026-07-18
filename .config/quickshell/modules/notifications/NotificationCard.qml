import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import qs.modules.common

PanelWindow {
    id: root
    required property var server

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
    exclusionMode: ExclusionMode.Auto

    ColumnLayout {
        id: column
        width: parent.width
        spacing: 10
        Repeater {
            model: root.server.trackedNotifications
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
                            color: Config.colors.color12
                            font.family: Config.font.fontFamily
                            font.pixelSize: Config.font.fontSize
                            font.bold: true
                            elide: Text.ElideRight
                        }

                        Text {
                            Layout.fillWidth: true
                            visible: text !== ""
                            text: card.modelData.body
                            color: Config.colors.color14
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
