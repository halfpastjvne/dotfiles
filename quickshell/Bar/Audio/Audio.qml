import ".."
import QtQuick
import Quickshell.Services.Pipewire

InnerWidget {
        id: aw
        property var index
        property list<PwNode> audioNodes: {
                var an = [];
                for (const nodeIndex in Pipewire.nodes.values) {
                        var node = Pipewire.nodes.values[nodeIndex];
                        if (node.audio != null && !node.isStream && node.isSink) {
                                an.push(node);
                                if (node == Pipewire.defaultAudioSink)
                                        aw.index = an.length-1;
                        }
                }
                return an
        }
        PwObjectTracker {
                objects: aw.audioNodes
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
                        text: (Pipewire.defaultAudioSink == aw.audioNodes[aw.index]) ? "" : "󰜉"
                        font.pointSize: 30
                        MouseArea {
                                hoverEnabled: true
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                onClicked: (mouse) => {
                                        if (mouse.button == Qt.LeftButton) {
                                                aw.index = aw.index > 0 ? aw.index - 1 : aw.audioNodes.length - 1;
                                        } else {
                                                aw.index = aw.index < aw.audioNodes.length - 1 ? aw.index + 1 : 0;
                                        }
                                        Pipewire.preferredDefaultAudioSink = aw.audioNodes[aw.index];
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
                        text: {
                                if (Pipewire.defaultAudioSink.audio.muted)
                                        return "";
                                var vol = Math.round(Pipewire.defaultAudioSink.audio.volume*100);
                                if (vol > 100) {
                                        Pipewire.defaultAudioSink.audio.volume=1;
                                        return "";
                                }
                                if (vol == 100)
                                        return "";
                                if (vol == 0)
                                        return "";
                                return vol.toString().padStart(2, '0');
                        }
                        font.pointSize: 25
                        MouseArea {
                                hoverEnabled: true
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                onClicked: (mouse) => {
                                        if (Pipewire.defaultAudioSink.audio.muted)
                                                return;
                                        if (mouse.button == Qt.LeftButton) {
                                                Pipewire.defaultAudioSink.audio.volume+=0.05;
                                        } else {
                                                Pipewire.defaultAudioSink.audio.volume-=0.05;
                                        }
                                }
                                onEntered: {
                                        parent.color = "#88c0d0"
                                }
                                onExited: {
                                        parent.color = "#d8dee9"
                                }
                        }
                }
        }
}
