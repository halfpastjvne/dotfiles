import Quickshell
import QtQuick
import "Clock"

Scope {
        Variants {
                model: Quickshell.screens
                PanelWindow {
                        property var modelData
                        screen: modelData
                        anchors {
                                bottom: true
                                top: true
                                left: true
                        }
                        width: 60
                        color: "transparent"
                        Rectangle {
                                color: "#3b4252"
                                anchors.fill: parent
                                anchors {
                                        leftMargin:  6
                                        topMargin: 8
                                        bottomMargin: 8
                                }
                                radius: 10
                                border.width: 4
                                border.color: "#2e3440"
                                Column {
                                        id: topCol
                                        spacing: 5
                                        anchors {
                                                horizontalCenter: parent.horizontalCenter
                                                top: parent.top
                                                topMargin: 7
                                        }
                                }
                                Column {
                                        id: centerCol
                                        spacing: 5
                                        anchors.centerIn: parent
                                }
                                Column {
                                        id: botCol
                                        spacing: 5
                                        anchors {
                                                horizontalCenter: parent.horizontalCenter
                                                bottom: parent.bottom
                                                bottomMargin: 7
                                        }
                                        Time2Col {}
                                }
                        }
                }
        }
}
