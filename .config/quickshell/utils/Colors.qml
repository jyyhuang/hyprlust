pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
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
    property string fontFamily: "Fira Sans"

    Timer {
      id: reloadTimer
      interval: 100
      onTriggered: colorsFile.reload()
    }

    FileView {
      id: colorFile
      path: Quickshell.env("HOME") + "/.config/quickshell/utils/Colors.qml"
      watchChanges: true
      onFileChanged: reloadTimer.restart()
    }
}
