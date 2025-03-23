import Quickshell
import QtQuick
import "Clock"
import "Workspace"
import "Mpris"
import "Audio"
import "Settings"

Scope {
        Variants {
                model: Quickshell.screens
                PanelWindow {
                        id: bar
                        property var modelData
                        screen: modelData
                        anchors {
                                bottom: true
                                top: true
                                left: true
                        }
                        width: 80
                        color: "transparent"
                        Rectangle {
                                color: "#3b4252"
                                anchors.fill: parent
                                anchors {
                                        leftMargin:  6
                                        topMargin: 8
                                        bottomMargin: 8
                                }
                                radius: 16
                                border.width: 4
                                border.color: "#2e3440"
                                Column {
                                        id: topCol
                                        spacing: 5
                                        anchors {
                                                horizontalCenter: parent.horizontalCenter
                                                top: parent.top
                                                topMargin: 0
                                        }
                                        Gear {}
                                        Workspaces {}
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
                                        Audio {}
                                        Music {}
                                        Time2Col {}
                                }
                        }
                }
        }
}
