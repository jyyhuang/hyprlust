pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell

Singleton {
    id: root
    property QtObject colors
    property QtObject bar
    property QtObject font
    property QtObject notifications
    property QtObject icons
    property QtObject wifi

    colors: QtObject {
        property color background: "{{background}}"
        property color foreground: "{{foreground}}"
        property color cursor: "{{cursor}}"
        property color color0: "{{color0}}"
        property color color1: "{{color1}}"
        property color color2: "{{color2}}"
        property color color3: "{{color3}}"
        property color color4: "{{color4}}"
        property color color5: "{{color5}}"
        property color color6: "{{color6}}"
        property color color7: "{{color7}}"
        property color color8: "{{color8}}"
        property color color9: "{{color9}}"
        property color color10: "{{color10}}"
        property color color11: "{{color11}}"
        property color color12: "{{color12}}"
        property color color13: "{{color13}}"
        property color color14: "{{color14}}"
        property color color15: "{{color15}}"
    }

    font: QtObject {
        readonly property string fontFamily: "Fira Sans"
        readonly property int fontSize: 16
    }

    bar: QtObject {
        readonly property int height: 44
    }

    notifications: QtObject {
        readonly property int timeout: 5000
    }

    icons: QtObject {
        readonly property string close: ""
        readonly property string arch: ""
        readonly property string idleInhibitorEnabled: " "
        readonly property string idleInhibitorDisabled: ""
        readonly property string power: "󰐥"
        readonly property string batteryCharging: "󰂄"
        readonly property string battery100: "󰁹"
        readonly property string battery90: "󰂂"
        readonly property string battery80: "󰂁"
        readonly property string battery70: "󰂀"
        readonly property string battery60: "󰁿"
        readonly property string battery50: "󰁾"
        readonly property string battery40: "󰁽"
        readonly property string battery30: "󰁼"
        readonly property string battery20: "󰁻"
        readonly property string battery10: "󰁺"
        readonly property string battery0: "󰂎"
        readonly property string memory: " "
    }

    wifi: QtObject {
        readonly property string wifiOff: "󰤮"
        readonly property string wifi100: "󰤨"
        readonly property string wifi75: "󰤥"
        readonly property string wifi50: "󰤢"
        readonly property string wifi25: "󰤟"
        readonly property string wifi0: "󰤯"
    }
}
