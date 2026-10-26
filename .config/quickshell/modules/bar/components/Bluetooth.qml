import QtQuick

import qs.common
import qs.services

Item {
    id: root

    implicitWidth: bluetoothText.implicitWidth
    implicitHeight: bluetoothText.implicitHeight

    readonly property string bluetoothIcon: {
        if (!BluetoothService.enabled) {
            return Config.bluetooth.off;
        } else if (BluetoothService.connected) {
            return Config.bluetooth.connected;
        }
        return Config.bluetooth.on;
    }

    Text {
        id: bluetoothText
        text: root.bluetoothIcon
        anchors.centerIn: parent
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }
}
