import QtQuick 2.7

Text {
    property alias backgroundColor : background.color
    property bool hasBorder: false
    color: "#ffffff"
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignLeft
    font.pixelSize: 20
    wrapMode: Text.Wrap
    height: 35
    Rectangle {
        id: background
        z: -1
        anchors.fill: parent
        color: hasBorder ? "#000000" : "transparent"
        opacity: hasBorder ? 0.5 : 1
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: 2
        border.color: "gray"
        visible: hasBorder
    }
}
