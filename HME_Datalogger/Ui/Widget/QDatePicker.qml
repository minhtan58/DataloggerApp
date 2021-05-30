import QtQuick 2.7
import QtQuick.Controls 1.4

Item {
    property alias datetime: datetime.text
    TextInput {
        id: datetime
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: picker.left
        width: parent.width - picker.width
        cursorVisible: false
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 20
        color: "#FFFFFF"
        clip: true
        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: 0.5
            z: -1
        }
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: "#FFFFFF"
            border.width: 2
        }

    }

    Rectangle {
        id: picker
        width: parent.height
        height: parent.height
        anchors.right: parent.right
        anchors.top: parent.top
        color: pick.containsMouse ? "gray" : "#FFFFFF"
        Image {
            anchors.fill: parent
            fillMode: Image.Stretch
            asynchronous: true
            source: "qrc:/Ui/Images/calendar.png"
        }
        MouseArea {
            id: pick
            anchors.fill: parent
            onClicked: calendar.visible = !calendar.visible
        }
    }

    Calendar {
        id: calendar
        anchors.top: datetime.bottom
        x: datetime.x
        width: parent.width
        visible: false
        onClicked: {
            datetime.text = Qt.formatDateTime(date, "yyyy;MM;dd")
            UIBridge.log("date: " + Qt.formatDateTime(date, "yyyy-MM-dd"))
            visible = false
        }
    }
}


