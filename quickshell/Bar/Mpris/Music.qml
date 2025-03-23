import QtQuick
import QtQuick.Effects
import Quickshell.Services.Mpris
import Quickshell.Widgets
import "./"
import "../"

ClippingRectangle {
        property var player: Mpris.players.values[0]
        visible: ((player.playbackState != MprisPlaybackState.Stopped || player.playbackState == MprisPlaybackState.Paused) && Mpris.players.values != undefined)
        width: 60
        height: col.height
        radius: 10
        id: musWid
        border.width: 3
        border.color: "#2e3440"
        Image {
                id: mprisImage
                source: player.trackArtUrl
                height: parent.height
                width: parent.height
                anchors.centerIn: parent
        }
        MultiEffect {
                source: mprisImage
                anchors.fill: mprisImage
                blurEnabled: true
                blurMax: 64
                blurMultiplier: -2
                blur: 1.0
        }
        MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onClicked: {
                        mbw.item.visible = !mbw.item.visible;
                }
                MusicWidget {
                        id: mbw
                }
        }
        Column {
                height: implicitHeight+10
                anchors.verticalCenterOffset: 5
                anchors.centerIn: parent
                id: col
                IButton {
                        path: "forward"
                        width: 45
                        height: 45
                        onClicked: player.next()
                }
                IButton {
                        path: (player.playbackState == MprisPlaybackState.Paused) ?
                                "play" : "pause"
                        width: 45
                        height: 45
                        onClicked: player.togglePlaying()
                }
                IButton {
                        path: "backward"
                        width: 45
                        height: 45
                        onClicked: player.previous()
                }
        }
}
