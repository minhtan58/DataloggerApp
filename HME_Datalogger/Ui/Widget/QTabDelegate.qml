import QtQuick 2.7

Rectangle {
    property int parentIndex: 0
    property int tabIndex: 0
    property alias tabIcon: icon.source
    property alias tabContentText: content.text
    width: 205
    height: 50
    color: tabIndex === parentIndex ? "gray" : "transparent"
    opacity: mouseDelegate.containsMouse ? 0.5 : 1

    signal tabCliked

    Image {
        id: icon
        x: 5
        width: 35
        height: 35
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: content
        x: 45
        width: 155
        height: 50
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 18
        wrapMode: Text.Wrap
        font.bold: true
    }

    Rectangle {
        x: 0
        y: 48
        width: 200
        height: 1
        color: "gray"
    }

    MouseArea {
        id: mouseDelegate
        anchors.fill: parent
        onClicked: tabCliked()
    }
}
