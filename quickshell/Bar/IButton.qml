import QtQuick.Controls

Button {
        required property var path
        flat: true
        icon.source: `/home/pechorsk/.config/quickshell/Bar/icons/${path}.svg`
        icon.width: width
        icon.height: height
        icon.color: (!hovered) ? "#d8dee9" : "#88c0d0"
        hoverEnabled: true
        background: null
}
