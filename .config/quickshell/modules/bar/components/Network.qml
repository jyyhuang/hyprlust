import QtQuick
import Quickshell.Io
import Quickshell.Networking

import qs.common

Item {
    id: root

    implicitWidth: networkText.implicitWidth
    implicitHeight: networkText.implicitHeight

    readonly property bool wifiEnabled: Networking.wifiEnabled
    readonly property var devices: Networking.devices ? Networking.devices.values : []
    readonly property var wifiDevice: devices.find(d => d.type === DeviceType.Wifi) || null
    readonly property var wifiNetworks: wifiDevice ? wifiDevice.networks.values : []
    readonly property var wifiActive: wifiNetworks.find(n => n.connected) || null
    readonly property real wifiSignalStrength: wifiActive ? Math.round(wifiActive.signalStrength * 100) : 0

    readonly property string wifiIcon: {
        if (!wifiEnabled || !devices || !wifiDevice || !wifiNetworks || !wifiActive) {
            return Config.wifi.wifiOff;
        } else if (wifiSignalStrength >= 76) {
            return Config.wifi.wifi100;
        } else if (wifiSignalStrength >= 51) {
            return Config.wifi.wifi75;
        } else if (wifiSignalStrength >= 26) {
            return Config.wifi.wifi50;
        } else if (wifiSignalStrength >= 1) {
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
