pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import qs.modules.common

PanelWindow {
    id: root
    required property var notificationCenterOpen
    required property var history

    visible: notificationCenterOpen
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
                    visible: root.history.count > 0
                    color: Config.colors.color13
                    font.family: Config.font.fontFamily
                    font.pixelSize: Config.font.fontSize - 1
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.history.clear()
                    }
                }
            }

            Repeater {
                model: root.history
                delegate: Rectangle {
                    id: centerCard
                    required property int index
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
                                    onClicked: root.history.remove(centerCard.index)
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
