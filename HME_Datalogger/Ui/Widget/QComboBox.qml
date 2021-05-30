import QtQuick 2.7

Flickable {
    id: comboBox
    width: 150
    height: 40

    contentWidth: 150
    contentHeight: 40 * model.length

    z: pressed ? 1 : 0

    property bool pressed: false
    property int currentIndex: 0
    property string currentValue: ""
    property color color: "#ffffff"
    property color selectionColor: "black"
    property color selectedTextColor: "#ffff00"
    property var model: ["COM1", "COM2", "COM3", "COM7"]
    property int comboBoxType: 1
    property string doneEvent: ""

    signal comboBoxClicked

    onCurrentValueChanged: {
        for(var i = 0; i < model.length; i++) {
            if(model[i] === currentValue) {
                if(currentIndex !== i) {
                    currentIndex = i
                }
                return
            }
        }
    }

    onCurrentIndexChanged: {
        if(currentValue !== model[currentIndex]) {
            currentValue = model[currentIndex]
        }
    }

    Column {
        Item {
            id: header
            width: 150
            height: 40
            Rectangle {
                anchors.fill: parent
                color: "#000000"
                opacity: comboBox.pressed ? 0.5 : 0.7
                border.color: "#FFFFFF"
                border.width: 1
                Rectangle {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    width: parent.height
                    height: parent.height
                    Text {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 20
                        font.bold: true
                        text: "▼"
                    }
                }
            }

            Text {
                anchors.fill: parent
                anchors.rightMargin: parent.height + 10
                anchors.leftMargin: 10
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                text: comboBox.model[comboBox.currentIndex]
                font.pixelSize: 20
                color: comboBox.color
                elide: Text.ElideRight
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    comboBox.pressed = !comboBox.pressed
                    comboBoxClicked()
                }
            }
        }

        Repeater {
            model: comboBox.model
            delegate: Rectangle{
                visible: comboBox.pressed && index !== comboBox.currentIndex
                anchors.left: header.left
                width: comboBox.width
                height: comboBox.height
                color: delegateRect.containsMouse ? "#FFFFFF" : "#000000"
                Text {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    text: modelData
                    font.pixelSize: 20
                    color: delegateRect.containsMouse ? "#000000" : "#FFFFFF"
                }
                MouseArea {
                    id: delegateRect
                    anchors.fill: parent
                    onClicked: {
                        comboBox.currentIndex = index
                        comboBox.pressed = false
                    }
                }
            }
        }
    }
}
