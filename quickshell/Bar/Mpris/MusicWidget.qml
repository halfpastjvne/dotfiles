import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import "../"

LazyLoader {
        id: load
        loading: true
        PopupWindow {
                width: 700
                height: 400
                anchor.window: bar
                anchor.rect.x: bar.width + 20
                anchor.rect.y: bar.height-height-100
                color: "transparent"
                id: toplevel
                property MprisPlayer player: Mpris.players.values[0]
                ClippingRectangle {
                        anchors.fill: parent
                        radius: 20
                        border.width: 3
                        border.color: "#2e3440"
                        Image {
                                id: img
                                source: toplevel.player.trackArtUrl
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectCrop
                        }
                        MultiEffect {
                                source: img
                                anchors.fill: img
                                blurEnabled: true
                                blurMax: 64
                                blurMultiplier: -4
                                blur: 0.9
                                brightness: -0.5
                        }
                        // god damn i hate ui
                        
                        Row {
                                anchors.fill: parent
                                spacing: 10
                                anchors.margins: 22
                                ClippingRectangle {
                                        id: simgp
                                        width: 350
                                        height: 350
                                        radius: 20
                                        Image {
                                                id: simg
                                                source: toplevel.player.trackArtUrl
                                                anchors.fill: parent
                                                smooth: true
                                                fillMode: Image.PreserveAspectCrop
                                        }
                                }
                                Column {
                                        spacing: 20
                                        width: 300
                                        anchors.verticalCenter: parent.verticalCenter
                                        Text {
                                                text: (toplevel.player.trackTitle.split(/[-–]/).slice(1).join('-') || toplevel.player.trackTitle).split(/[\[\(\/]/)[0].trim()
                                                font.pixelSize: 40
                                                font.family: "CaskaydiaCove Nerd Font"
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                color: "#d8dee9"
                                                onWidthChanged: {
                                                        if (width > parent.width)
                                                                font.pixelSize = Math.max(parent.width / width * font.pixelSize, 5)
                                                        else
                                                                font.pixelSize = 40
                                                }
                                        }
                                        Text {
                                                text: toplevel.player.trackArtist.split(/[&,]/)[0].trim()
                                                font.pointSize: 20
                                                font.family: "CaskaydiaCove Nerd Font"
                                                color: "#d8dee9"
                                                anchors.horizontalCenter: parent.horizontalCenter
                                        }
                                        Item {
                                                width: 3
                                                height: 75
                                        }
                                        Text {
                                                text: {
                                                        var sec = toplevel.player.position;
                                                        var len = toplevel.player.length;
                                                        if (true)
                                                                return Math.floor(sec/60) + ":" + Math.round(sec % 60).toString().padStart(2, '0') + " / " + Math.floor(len/60) + ":" + Math.round(len % 60).toString().padStart(2, '0');
                                                }
                                                font.pointSize: 20
                                                font.family: "CaskaydiaCove Nerd Font"
                                                color: "#d8dee9"
                                                anchors.horizontalCenter: parent.horizontalCenter
                                        }
                                        Row {
                                                spacing: 12
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                IButton {
                                                        path: (toplevel.player.shuffle) ? "shuffle" : "list"
                                                        width: 50
                                                        height: 50
                                                        onClicked: toplevel.player.shuffle = !toplevel.player.shuffle
                                                }
                                                IButton {
                                                        path: "backward"
                                                        width: 50
                                                        height: 50
                                                        onClicked: toplevel.player.previous()
                                                }
                                                
                                                IButton {
                                                        path: (toplevel.player.playbackState == MprisPlaybackState.Paused) ?
                                                                "play" : "pause"
                                                        width: 50
                                                        height: 50
                                                        onClicked: toplevel.player.togglePlaying()
                                                }
                                                
                                                IButton {
                                                        path: "forward"
                                                        width: 50
                                                        height: 50
                                                        onClicked: toplevel.player.next()
                                                }
                                                IButton {
                                                        path: {
                                                                if (toplevel.player.loopState == MprisLoopState.Track)
                                                                        return "repeat-1";
                                                                if (toplevel.player.loopState == MprisLoopState.Playlist)
                                                                        return "repeat";
                                                                return "xmark";
                                                        }
                                                        width: 50
                                                        height: 50
                                                        onClicked: toplevel.player.loopState += (toplevel.player.loopState == 2) ? -2 : 1;
                                                }
                                        }
                                        Slider {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                from: 0
                                                to: toplevel.player.length
                                                value: toplevel.player.position
                                                width: 250
                                                height: 4
                                                onMoved: toplevel.player.position = value
                                                handle: Rectangle {
                                                        width: 20
                                                        height: 20
                                                        radius: 10
                                                        color: "#d8dee9"
                                                        x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
                                                        y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                                }
                                                background: Rectangle {
                                                        x: parent.leftPadding + parent
                                                        y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                                        width: parent.width
                                                        height: 4
                                                        radius: 2
                                                        color: "#434c5e"
                                                        Rectangle {
                                                                width: parent.parent.visualPosition * parent.width
                                                                height: parent.height
                                                                color: "#81a1c1"
                                                                radius: 2
                                                        }
                                                }
                                                FrameAnimation {
                                                        running: toplevel.player.playbackState == MprisPlaybackState.Playing
                                                        onTriggered: toplevel.player.positionChanged()
                                                }
                                        }
                                }
                        }
                }
        }
}
