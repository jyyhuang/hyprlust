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
        property color background: "#04070D"
        property color foreground: "#ABAEB5"
        property color cursor: "#6E9FAF"
        property color color0: "#394849"
        property color color1: "#424752"
        property color color2: "#4B6778"
        property color color3: "#6A6374"
        property color color4: "#8F728F"
        property color color5: "#458191"
        property color color6: "#998D9C"
        property color color7: "#7E838D"
        property color color8: "#585B62"
        property color color9: "#454B5B"
        property color color10: "#50778C"
        property color color11: "#7B7087"
        property color color12: "#9E6D9C"
        property color color13: "#3290A9"
        property color color14: "#CCBCD0"
        property color color15: "#7E838D"
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
