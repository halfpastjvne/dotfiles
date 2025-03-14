import QtQuick
import QtQuick.Effects
import Quickshell.Services.Mpris
import Quickshell.Widgets
import Quickshell.Io

ClippingRectangle {
        visible: (Mpris.players.values[0].playbackState != MprisPlaybackState.Stopped || Mpris.players.values[0].playbackState == MprisPlaybackState.Paused)
        width: 60
        height: col.implicitHeight
        radius: 10
        border.width: 3
        border.color: "#2e3440"
        Image {
                id: mprisImage
                source: Mpris.players.values[0].trackArtUrl
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
        Column {
                anchors.centerIn: parent
                id: col
                spacing: 0
                Text {
                        color: "#d8dee9"
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: ""
                        font.pointSize: 30
                        MouseArea {
                                hoverEnabled: true
                                onEntered: {
                                        parent.color = "#88c0d0"
                                }
                                onExited: {
                                        parent.color = "#d8dee9"
                                }
                                anchors.fill: parent
                                onClicked: Mpris.players.values[0].next()
                        }
                }
                Text {
                        color: "#d8dee9"
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: (Mpris.players.values[0].playbackState == MprisPlaybackState.Playing) ? "" : ""
                        font.pointSize: 30
                        MouseArea {
                                hoverEnabled: true
                                onEntered: {
                                        parent.color = "#88c0d0"
                                }
                                onExited: {
                                        parent.color = "#d8dee9"
                                }
                                anchors.fill: parent
                                onClicked: Mpris.players.values[0].togglePlaying()
                        }
                }
                Text {
                        color: "#d8dee9"
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: ""
                        font.pointSize: 30
                        MouseArea {
                                hoverEnabled: true
                                onEntered: {
                                        parent.color = "#88c0d0"
                                }
                                onExited: {
                                        parent.color = "#d8dee9"
                                }
                                anchors.fill: parent
                                onClicked: Mpris.players.values[0].previous()
                        }
                }
        }
}
