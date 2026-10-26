pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property var players: Mpris.players ? Mpris.players.values : []
    readonly property var activePlayer: players.find(p => p.isPlaying) ?? players[0] ?? null

    readonly property bool hasActivePlayer: activePlayer !== null
    readonly property string trackTitle: activePlayer?.trackTitle ?? ""
    readonly property string trackArtist: activePlayer?.trackArtist ?? ""
}
