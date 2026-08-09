import Quickshell.Services.UPower
import QtQuick

import qs.common

Item {
    id: root

    readonly property var device: UPower.displayDevice
    readonly property bool hasBattery: device !== null && device.isLaptopBattery && device.isPresent && device.ready
    readonly property bool charging: !UPower.onBattery
    readonly property int percent: device ? Math.round(device.percentage * 100) : 0

    readonly property string batteryIcon: {
        if (charging)
            return Config.icons.batteryCharging;
        else if (percent >= 91)
            return Config.icons.battery100;
        else if (percent >= 81)
            return Config.icons.battery90;
        else if (percent >= 71)
            return Config.icons.battery80;
        else if (percent >= 61)
            return Config.icons.battery70;
        else if (percent >= 51)
            return Config.icons.battery60;
        else if (percent >= 41)
            return Config.icons.battery50;
        else if (percent >= 31)
            return Config.icons.battery40;
        else if (percent >= 21)
            return Config.icons.battery30;
        else if (percent >= 11)
            return Config.icons.battery20;
        else if (percent >= 1)
            return Config.icons.battery10;
        else
            return Config.icons.battery0;
    }

    implicitWidth: batteryText.implicitWidth
    implicitHeight: batteryText.implicitHeight

    Text {
        id: batteryText
        text: root.hasBattery ? root.batteryIcon + " " + root.percent + "%" : Config.icons.batteryCharging + " " + "0%"
        anchors.centerIn: parent
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }
}
