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
        property string fontFamily: "Fira Sans"
        property int fontSize: 16
    }

    bar: QtObject {
        property int height: 44
    }

    notifications: QtObject {
        property int timeout: 5000
    }
}
