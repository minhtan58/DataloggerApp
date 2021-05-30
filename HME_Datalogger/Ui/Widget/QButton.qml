import QtQuick 2.7

Item {
    width: 50
    height: 30
    property int eventID: -1
    property string eventParams: ""
    property alias source: imgbtn.source
    property alias background: background.color
    property alias text: txtContent.text

    property bool isEnabled: true

    signal buttonClicked

    Rectangle {
        id: background
        anchors.fill: parent
        border.color: isEnabled ? "#FFFFFF" : "gray"
        border.width: 1
        color: mouseBtn.containsMouse ? "gray" : "#000000"
    }

    Image {
        id: imgbtn
        anchors.centerIn: parent
        width: 70
        height: 70
        z: 5
    }

    Text {
        id: txtContent
        anchors.centerIn: parent
        wrapMode: Text.WordWrap
        color: isEnabled ? "#ffffff" : "gray"
        font.pixelSize: 20
    }

    MouseArea {
        id: mouseBtn
        anchors.fill: parent
        enabled: isEnabled
        onClicked: {
            buttonClicked()
            if(eventID !== -1)
                UIBridge.hmiEvent(this.objectName, eventID, eventParams)
        }
    }
}

