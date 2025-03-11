import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot {
        PanelWindow {
                width: 800
                height: 400
                color: "transparent"
                WlrLayershell.layer: WlrLayer.Overlay
                Rectangle {
                        property var str
                        id: toplevel
                        anchors.centerIn: parent
                        width: 600
                        height: 250
                        radius: 50
                        border.width: 10
                        border.color: "#2e3440"
                        color: "#3b4252"
                        Rectangle {
                                id: searchRect
                                width: 550
                                height: 60
                                radius: 25
                                border.width: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: 25
                                border.color: "#2e3440"
                                color: "#434c5e"
                                TextInput {
                                        id: search
                                        anchors.bottom: parent.bottom
                                        anchors.left: parent.left
                                        anchors.leftMargin: 20
                                        anchors.bottomMargin: 12
                                        text: ""
                                        font.pointSize: 20
                                        font.family: "Comic Mono"
                                        color: "#d8dee9"
                                       // cursorVisible: false
                                        onTextEdited: {
                                                toplevel.str = search.text
                                                console.log(toplevel.str)
                                        }
                                }
                        }
                        Rectangle {
                                width: 550
                                height: 125
                                radius: 25
                                border.width: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 25
                                border.color: "#2e3440"
                                color: "#434c5e"
                                id: iconRect
                                Row {
                                        spacing: 36
                                        anchors.centerIn: parent
                                        Repeater {
                                                model: 5
                                                Image {
                                                        required property var index
                                                        source: Quickshell.iconPath(DesktopEntries.applications.values[index].icon)
                                                        width: 70
                                                        height: 70
                                                }
                                        }
                                }
                        }
                }
                MultiEffect {
                        source: toplevel
                        anchors.fill: toplevel
                        shadowBlur: 0.5
                        shadowEnabled: true
                        shadowColor: "#2e3440"
                        shadowOpacity: 0.2
                        shadowVerticalOffset: 15
                        shadowHorizontalOffset: 11
                }
                WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
        }
}
