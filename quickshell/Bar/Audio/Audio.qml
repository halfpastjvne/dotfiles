import ".."
import QtQuick
import Quickshell.Services.Pipewire

InnerWidget {
        property var index
        property list<PwNode> audioNodes: {
                var an = [];
                for (const nodeIndex in Pipewire.nodes.values) {
                        var node = Pipewire.nodes.values[nodeIndex];
                        if (node.audio != null && node.audio.volume != null && node.isSink) {
                                an.push(node);
                        }
                }
                return an
        }
        PwObjectTracker {
                objects: audioNodes
        }
        height: col.implicitHeight+20
        Column {
                anchors.centerIn: parent
                id: col
                spacing: 15
                Text {
                        font.family: "CaskaydiaCove Nerd Font"
                        color: "#d8dee9"
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: ""
                        font.pointSize: 30
                        MouseArea {
                                hoverEnabled: true
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                onClicked: (mouse) => {
                                        if (mouse.button == Qt.LeftButton) {
                                                index = index > 0 ? index - 1 : audioNodes.length - 1;
                                        } else {
                                                index = index < audioNodes.length - 1 ? index + 1 : 0;
                                        }
                                        Pipewire.preferredDefaultAudioSink = audioNodes[index];
                                }
                                onEntered: {
                                        parent.color = "#88c0d0"
                                }
                                onExited: {
                                        parent.color = "#d8dee9"
                                }
                        }
                }
                Text {
                        font.family: "CaskaydiaCove Nerd Font"
                        color: "#d8dee9"
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: (Pipewire.defaultAudioSink.audio.volume == 1) ? "" : (Pipewire.defaultAudioSink.audio.volume == 0) ? "" : Math.round(Pipewire.defaultAudioSink.audio.volume*100).toString().padStart(2, '0');
                        font.pointSize: 25
                }
                Text {
                        font.family: "CaskaydiaCove Nerd Font"
                        color: "#d8dee9"
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: ""
                        font.pointSize: 30
                }
        }
}
