import QtQuick
import Quickshell.Io

import qs.common
import qs.services

Item {
    id: root

    implicitWidth: networkText.implicitWidth
    implicitHeight: networkText.implicitHeight

    readonly property string wifiIcon: {
        if (!WifiService.wifiEnabled || !WifiService.devices || !WifiService.wifiDevice || !WifiService.wifiNetworks || !WifiService.wifiActive) {
            return Config.wifi.wifiOff;
        } else if (WifiService.wifiSignalStrength >= 76) {
            return Config.wifi.wifi100;
        } else if (WifiService.wifiSignalStrength >= 51) {
            return Config.wifi.wifi75;
        } else if (WifiService.wifiSignalStrength >= 26) {
            return Config.wifi.wifi50;
        } else if (WifiService.wifiSignalStrength >= 1) {
            return Config.wifi.wifi25;
        } else {
            return Config.wifi.wifi0;
        }
    }

    Text {
        id: networkText
        text: root.wifiIcon
        anchors.centerIn: parent
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.OpenHandCursor
        onClicked: {
            networkProcess.running = true;
        }
    }

    Process {
        id: networkProcess
        command: ["wezterm", "start", "--always-new-process", "nmtui"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                console.log(this.text.trim());
            }
        }
        onExited: networkProcess.running = false
    }
}
