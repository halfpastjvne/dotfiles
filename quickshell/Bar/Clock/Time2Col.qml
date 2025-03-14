import ".."
import QtQuick
import Quickshell

InnerWidget {
        height: text.implicitHeight
        Text {
                anchors.horizontalCenter: parent.horizontalCenter
                id: text
                text: Qt.formatDateTime(clock.date, "hh\nmm")
                color: "#d8dee9"
                font.family: "CaskaydiaCove Nerd Font"
                font.pointSize: 30
        }
        SystemClock {
                id: clock
                precision: SystemClock.Seconds
        }
}
