import QtQuick 2.7
import EnumID 1.0

Item {
    property alias cursorPosition: txtInp.cursorPosition
    property alias cursorVisible: txtInp.cursorVisible
    property alias text: txtInp.text
    property bool isTextCenter: true

    property int doneEventID: -1
    property string dontEventParams: ""

    property bool isFullKey: false

    signal textInputClicked

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.5
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "#FFFFFF"
        border.width: 2
    }

    TextInput {
        id: txtInp
        anchors.fill: parent
        anchors.margins: 3
        cursorVisible: false
        horizontalAlignment: isTextCenter ? Text.AlignHCenter : Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 20
        color: "#FFFFFF"
        clip: true

        onCursorVisibleChanged: {
            if(!cursorVisible)
                UIBridge.hmiEvent(this.objectName, doneEventID, text)
        }
    }

//    MouseArea {
//        id: mouseTextInput
//        anchors.fill: parent
//        onClicked: {
//            cursorPosition = txtInp.positionAt(mouseTextInput.mouseX, mouseTextInput.mouseY)
//            textInputClicked()
//        }
//        onPressed: UIBridge.hmiEvent(parent.objectName, EnumID.HMI_TEXTINPUT_FOCUS_CHANGED, isFullKey ? "1" : "0")
//    }

//    function doneInput() {
//        if(doneEventID != -1)
//            UIBridge.hmiEvent(this.objectName, doneEventID, txtInp.text)
//    }
}
