import QtQuick

import qs.common
import qs.services

Item {
    id: root

    implicitWidth: 2 * volume.width
    implicitHeight: volume.height

    readonly property string volumeIcon: {
        if (AudioService.muted || AudioService.volume == 0) {
            return Config.volume.muted;
        } else if (AudioService.volume <= 33) {
            return Config.volume.low;
        } else if (AudioService.volume <= 66) {
            return Config.volume.medium;
        }
        return Config.volume.high;
    }

    Row {
        id: row
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        StatusRing {
            id: volume
            width: 24
            height: 24
            value: AudioService.volume / 100
            ringWidth: 4
            ringColor: AudioService.muted ? Config.colors.color0 : Config.colors.color14
            icon: volumeIcon
            onScrolled: delta => AudioService.setVolume(AudioService.volume + delta * 100)
            onClicked: AudioService.toggleMuted()
        }

        StatusRing {
            id: microphone
            width: 24
            height: 24
            value: AudioService.microphoneVolume / 100
            ringWidth: 4
            ringColor: AudioService.microphoneMuted ? Config.colors.color0 : Config.colors.color14
            icon: AudioService.microphoneMuted ? Config.microphone.muted : Config.microphone.active
            onScrolled: delta => AudioService.setMicrophoneVolume(AudioService.microphoneVolume + delta * 100)
            onClicked: AudioService.toggleMicrophoneMuted()
        }
    }
}
