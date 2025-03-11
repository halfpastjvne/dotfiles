import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
        id: win
        property list<int> cavaData
        anchors {
                top: true
                bottom: true
                left: true
                right: true
        }
        WlrLayershell.layer: WlrLayer.Background
        color: "transparent"
        Row {
                spacing: 4
                anchors.centerIn: parent
                Repeater {
                        model: 20
                        Rectangle {
                                required property var index
                                width: 30
                                height: cavaData[index]*0.75
                                anchors.bottom: parent.bottom
                                radius: 10
                                color: "white"
                        }
                }
                height: 256
        }
        Process {
                running: true
                command: ["cava"]
                stdout: SplitParser {
                        onRead: (data) => {
                                const d_split = data.split(';');
                                for (let i = 0; i < d_split.length; i++) {
                                        win.cavaData[i] = parseInt(d_split[i]);
                                        if (win.cavaData[i] == 0)
                                                win.cavaData[i] = 1;
                                }
                        }
                }
        }
}

