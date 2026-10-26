import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import qs.common

PanelWindow {
    id: root
    required property var server
    property int maxCardHeight: 180

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
                Layout.preferredHeight: Math.min(contentLayout.implicitHeight + 20, root.maxCardHeight)
                radius: 8
                clip: true
                color: Config.colors.background
                border.width: 2
                border.color: card.modelData.urgency === NotificationUrgency.Critical ? Config.colors.color13 : Config.colors.color14

                Flickable {
                    anchors.fill: parent
                    anchors.margins: 10
                    contentWidth: width
                    contentHeight: contentLayout.implicitHeight
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds

                    RowLayout {
                        id: contentLayout
                        width: parent.width
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
                                wrapMode: Text.WordWrap
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
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: card.modelData.dismiss()
                }
            }
        }
    }
}
