import QtQuick
import Quickshell.Widgets
//modular blocks

ClippingRectangle {
        property var blockWidth: 1
        property var blockHeight: 1
        width: blockWidth*200+(blockWidth-1)*40
        height: blockHeight*200+(blockHeight-1)*40
        radius: 20
        border.width: 6
        border.color: "#2e3440"
        color: "#3b4252"
}
