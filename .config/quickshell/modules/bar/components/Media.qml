import QtQuick

import qs.common
import qs.services

Item {
    id: root

    readonly property int maxLength: 30
    readonly property string fullText: MediaService.hasActivePlayer && MediaService.trackArtist.length > 0 ? MediaService.trackArtist + " - " + MediaService.trackTitle : "(˶˃⤙˂˶)"

    implicitWidth: visible ? mediaText.implicitWidth : 0
    implicitHeight: visible ? mediaText.implicitHeight : 0

    Text {
        id: mediaText
        text: root.fullText.length > root.maxLength ? root.fullText.substring(0, root.maxLength - 1) + "…" : root.fullText
        anchors.centerIn: parent
        color: Config.colors.color14
        font.pixelSize: Config.font.fontSize
        font.family: Config.font.fontFamily
        font.bold: true
    }
}
