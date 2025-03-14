import ".."
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Column {
        spacing: 13
        Repeater {
                model: Hyprland.workspaces.values.length
                Rectangle {
                        required property var index
                        property bool active: (Hyprland.focusedMonitor.activeWorkspace.id == (index+1))
                        radius: 7.5
                        height: 15
                        width: 60
                        color: {
                                if (active)                                            return "#d8dee9";
                                if (Hyprland.workspaces.values[index].id == -98)       return "#d08770";
                                if (Hyprland.workspaces.values[index].monitor.id == 1) return "#bf616a";
                                if (Hyprland.workspaces.values[index].monitor.id == 2) return "#a3be8c";
                                if (Hyprland.workspaces.values[index].monitor.id == 0) return "#b48ead";
                        }
                        MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton
                                onClicked: Hyprland.dispatch(`workspace ${index+1}`)
                        }
                }
        }
}
