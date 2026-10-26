import QtQuick

import qs.common
import qs.modules.bar.components

Row {
    id: root
    spacing: 10

    Text {
        id: notification
        text: Config.icons.notification
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }

    Network {}
    Bluetooth {}
    Clock {}
}
