import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

LazyLoader {
        loading: true
        PanelWindow {
                id: toplevel
                property var bgs
                visible: false
                WlrLayershell.layer: WlrLayer.Overlay
                exclusionMode: ExclusionMode.Ignore
                anchors {
                        top: true
                        right: true
                        bottom: true
                        left: true
                }
                color: "transparent"
                Process {
                        id: p
                        running: true
                        command: ["swww", "query"]
                        stdout: SplitParser {
                                splitMarker: ''
                                onRead: (data) => {
                                        toplevel.bgs = {};
                                        data.split('\n').forEach(line => {
                                                var parts = line.trim().split(' ');
                                                toplevel.bgs[parts[0].slice(0, -1)] = parts.pop().toString();
                                        });
                                        img.source = toplevel.bgs[bar.screen.name]
                                }
                        }
                }
                Image {
                        id: img
                        anchors.fill: parent
                }
                MultiEffect {
                        source: img
                        anchors.fill: img
                        blurEnabled: true
                        blurMax: 64
                        blurMultiplier: -6
                        blur: 1
                        brightness: -0.2
                }
                MouseArea {
                        anchors.fill: parent
                        onReleased: {
                                if (!region.containsMouse)
                                        toplevel.visible = false
                        }
                }
                MouseArea {
                        hoverEnabled: true
                        id: region
                        anchors.centerIn: parent
                        width: children[0].width
                        height: children[0].height
                        Row {
                                anchors.centerIn: parent
                                spacing: 40
                                Column {
                                        spacing: 40
                                        LayoutBlock {
                                                BlockIcon {
                                                        note: "Lock"
                                                        path: "lock"
                                                        cmd: "thisIsntImportant"
                                                }
                                        }
                                        LayoutBlock {
                                                BlockIcon {
                                                        note: "Reboot"
                                                        path: "rotate-right"
                                                        cmd: "reboot"
                                                }
                                        }
                                        LayoutBlock {
                                                BlockIcon {
                                                        note: "Sleep"
                                                        path: "snooze"
                                                        cmd: "systemctl suspend"
                                                }
                                        }
                                }
                                Column {
                                        spacing: 40
                                        LayoutBlock {
                                                blockWidth: 4
                                                Row {
                                                        anchors.fill: parent
                                                        anchors.topMargin: 10
                                                        anchors.leftMargin: 10
                                                        Column {
                                                                spacing: 10
                                                                Text {
                                                                        font.family: "CaskaydiaCove Nerd Font"
                                                                        font.pixelSize: 30
                                                                        text: "Hello Pechorsk"
                                                                        color: "#d8dee9"
                                                                        font.bold: true
                                                                }
                                                        }
                                                }
                                        }
                                        Row {
                                                spacing: 40
                                                LayoutBlock {
                                                        blockHeight: 2
                                                }
                                                Column {
                                                        spacing: 40
                                                        LayoutBlock {

                                                        }
                                                        LayoutBlock {
                                                                
                                                        }
                                                }
                                                LayoutBlock {
                                                        blockWidth: 2
                                                        blockHeight: 2
                                                }
                                        }
                                }
                                Column {
                                        spacing: 40
                                        LayoutBlock {
                                                BlockIcon {
                                                        note: "Power"
                                                        path: "power-off"
                                                        cmd: "systemctl poweroff"
                                                }
                                        }
                                        LayoutBlock {
                                                blockHeight: 2
                                        }
                                }
                        }
                }
                SystemClock {
                        id: clk
                        precision: SystemClock.Seconds
                }
        }
}
