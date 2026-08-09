import Quickshell
import QtQuick

import qs.common

Item {
    id: root
    property string timeFormat: "ddd, MM/dd · hh:mm AP"
    implicitWidth: timeText.implicitWidth
    implicitHeight: timeText.implicitHeight

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        id: timeText
        text: Qt.formatDateTime(clock.date, root.timeFormat)
        anchors.centerIn: parent
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }
}
