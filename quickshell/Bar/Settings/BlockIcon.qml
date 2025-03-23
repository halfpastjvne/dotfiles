import QtQuick
import Quickshell.Io
import "../"
IButton {
        required property var cmd
        property var note
        onClicked: p.running = true
        anchors.centerIn: parent
        width: parent.width/2
        height: parent.height/2
        Process {
                id: p
                running: false
                command: cmd.split(' ')
        }
        Text {
                anchors.top: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 30
                font.family: "CaskaydiaCove Nerd Font"
                color: "#d8dee9"
                font.bold: true
                text: parent.note || ""
        }
}
