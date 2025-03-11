import ".."
import QtQuick
import Quickshell

InnerWidget {
        height: col.implicitHeight
        property var date: new Date()
        Column {
                id: col
                anchors.centerIn: parent
                Text {
                        text: date.getHours().toString().padStart(2, '0')
                        color: "#d8dee9"
                        font.family: "CaskaydiaCove Nerd Font"
                        font.pointSize: 20
                }
                Text {
                        text: date.getMinutes().toString().padStart(2, '0')
                        color: "#d8dee9"
                        font.family: "CaskaydiaCove Nerd Font"
                        font.pointSize: 20
                }
        }
        Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: date = new Date()
        }
}
