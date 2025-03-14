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
        Item {
                id: colWrapper
                anchors.fill: parent
                Column {
                        spacing: 2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        Repeater {
                                model: 20
                                Rectangle {
                                        required property var index
                                        width: cavaData[index]*0.5
                                        height: 34
                                        anchors.left: parent.left
                                        color: "white"
                                }
                        }
                        width: 256
                }
                Column {
                        spacing: 2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        Repeater {
                                model: 20
                                Rectangle {
                                        required property var index
                                        width: cavaData[index]*0.5
                                        height: 34
                                        anchors.right: parent.right
                                        color: "white"
                                }
                        }
                        width: 256
                }
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

