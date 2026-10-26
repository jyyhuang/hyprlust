pragma Singleton

import Quickshell
import Quickshell.Networking

Singleton {
    id: root

    readonly property bool wifiEnabled: Networking.wifiEnabled
    readonly property var devices: Networking.devices ? Networking.devices.values : []
    readonly property var wifiDevice: devices.find(d => d.type === DeviceType.Wifi) || null
    readonly property var wifiNetworks: wifiDevice ? wifiDevice.networks.values : []
    readonly property var wifiActive: wifiNetworks.find(n => n.connected) || null
    readonly property real wifiSignalStrength: wifiActive ? Math.round(wifiActive.signalStrength * 100) : 0
}
