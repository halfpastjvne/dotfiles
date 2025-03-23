import QtQuick
import "./"

Text {
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 50
        color: "#434c5e"
        text: ""
        MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse) => {
                        if (mouse.button == Qt.LeftButton) {
                                wlo.item.visible = true;
                        }
                }
                Wlogout {
                        id: wlo
                }
        }
}
