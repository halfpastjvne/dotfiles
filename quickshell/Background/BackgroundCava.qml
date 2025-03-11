import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Mpris

Scope {
        Variants {
                model: Quickshell.screens
                PanelWindow {
                        // Show on all screens
                        property var modelData
                        property list<int> cavaData
                        property var date: new Date()
                        property var mp: Mpris.players.values[0]
                        screen: modelData
                        anchors {
                                top: true
                                bottom: true
                                left: true
                                right: true
                        }
                        color: "transparent"
                        WlrLayershell.layer: WlrLayer.Bottom
                        Column {
                                anchors.centerIn: parent
                                Text {
                                        text: date.getHours().toString().padStart(2, '0') + ':' + date.getMinutes().toString().padStart(2, '0')
                                        color: "#e5e9f0"
                                        font.pointSize: 90
                                        font.family: "Comic Mono"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: (mp.trackTitle.split(/[-–]/).slice(1).join('-') || mp.trackTitle).split(/[\[\(\/]/)[0].trim();
                                        color: "#d8dee9"
                                        font.pointSize: 70
                                        font.italic: true
                                        font.family: "Comic Mono"
                                }
                                Row {
                                        height: 255
                                        spacing: 4
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        Repeater {
                                                model: 20
                                                Rectangle {
                                                        required property var index
                                                        width: 40
                                                        height: cavaData[index];
                                                        anchors.bottom: parent.bottom
                                                        topLeftRadius: 7
                                                        topRightRadius: 7
                                                        color: "#e5e9f0"
                                                }
                                        }
                                }
                        }
                        Process {
                                running: true
                                command: ["cava"]
                                stdout: SplitParser {
                                        onRead: (data) => {
                                                var split = data.split(';');
                                                for (let i = 0; i < split.length; i++) {
                                                        cavaData[i] = parseInt(split[i]);
                                                        if (cavaData[i] == 0)
                                                                cavaData[i]++;
                                                }
                                        }
                                }
                        }
                        Timer {
                                interval: 1000
                                running: true
                                repeat: true
                                onTriggered: date = new Date()
                        }
                }
        }
}
