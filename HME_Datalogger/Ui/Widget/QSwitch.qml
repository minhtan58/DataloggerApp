import QtQuick 2.7

Rectangle {
    id: root

    property bool checked: false
    property string textbool: contentText.text
    function changeMode(){
        if(checked == true)checked = false
        else checked = true
    }

    opacity: mouseRoot.containsMouse ? 0.5 : 1

    width: 250
    height: 50
    border.width: 0.05 * root.height
    radius: 0.5  * root.height
    color: checked? '#FFFFFF': '#000000'

    Text {
        id: contentText
        text: checked? 'On': 'Off'
        color: checked? '#000000': '#FFFFFF'
        x: (checked ? 0 : pill.width) + (parent.width - pill.width - width) / 2
        font.pixelSize: 0.5 * root.height
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        id: mouseRoot
        anchors.fill: parent
        onClicked: root.changeMode()
    }

    Rectangle {
        id: pill
        x: checked ? root.width - pill.width: 0
        width: root.height;  height: width
        border.width: parent.border.width
        radius: parent.radius
        opacity: mousePill.containsMouse ? 0.5 : 1

        MouseArea {
            id: mousePill
            anchors.fill: parent

            drag {
                target: pill
                axis: Drag.XAxis
                minimumX: 0
                maximumX: root.width - pill.width
            }

            onReleased: {
                if((!checked  &&  pill.x) || (checked  &&  pill.x < root.width - pill.width)) {
                    root.changeMode()
                }
            }
        }
    }
}
