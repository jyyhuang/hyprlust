pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property real volume: (sink?.audio?.volume ?? 0) * 100
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property real microphoneVolume: (source?.audio?.volume ?? 0) * 100
    readonly property bool microphoneMuted: source?.audio?.muted ?? false

    function setVolume(value: real): void {
        if (!sink?.ready)
            return;
        sink.audio.volume = Math.max(0, Math.min(100, value)) / 100;
    }

    function setMuted(value: bool): void {
        if (sink?.ready)
            sink.audio.muted = value;
    }

    function toggleMuted(): void {
        setMuted(!muted);
    }

    function setMicrophoneVolume(value: real): void {
        if (!source?.ready)
            return;
        source.audio.volume = Math.max(0, Math.min(100, value)) / 100;
    }

    function setMicrophoneMuted(value: bool): void {
        if (source?.ready)
            source.audio.muted = value;
    }

    function toggleMicrophoneMuted(): void {
        setMicrophoneMuted(!microphoneMuted);
    }

    PwObjectTracker {
        objects: [root.sink, root.source]
    }
}
