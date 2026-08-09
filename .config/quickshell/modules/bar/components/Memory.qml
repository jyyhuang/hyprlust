import QtQuick
import Quickshell.Io

import qs.common

Item {
    id: root

    property int memoryTotal: 0
    property int memoryAvailable: 0
    readonly property int memoryUsed: memoryTotal - memoryAvailable
    readonly property string text: Config.icons.memory + (memoryUsed / 1024 ** 2).toFixed(1) + "/" + (memoryTotal / 1024 ** 2).toFixed(1) + "GB"

    implicitWidth: memoryText.implicitWidth
    implicitHeight: memoryText.implicitHeight

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            memProc.running = true;
        }
    }

    Process {
        id: memProc
        command: ["bash", "-c", "cat /proc/meminfo | awk '/MemTotal|MemAvailable/ {print $2}'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const values = this.text.trim().split("\n");
                root.memoryTotal = parseInt(values[0], 10);
                root.memoryAvailable = parseInt(values[1], 10);
            }
        }
    }

    Text {
        id: memoryText
        text: root.text
        anchors.centerIn: parent
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }
}
