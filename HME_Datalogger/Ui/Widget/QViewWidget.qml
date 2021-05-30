import QtQuick 2.7

Item {
    property string textValue: ""
    property alias textName: txtName.text
    property alias textUnit: txtUnit.text
    property alias txtInterval: txtInterval.text
    property string isAlarmOn: "0"
    width: 418
    height: 100
//    enabled: false

    signal viewClicked
    signal viewPressAndHold

    Rectangle {
        id: rect
        anchors.fill: parent
        color: isAlarmOn === "1" ? "#315b7d" : "#99ff66"
        opacity: viewArea.containsMouse ? 0.7 : (isAlarmOn === "1" ? 0.5 : 0.15)
//        gradient: Gradient {
//            GradientStop { position: 0.0; color: "#1c3448" }
//            GradientStop { position: 0.4; color: "#6a9bc3" }
//            GradientStop { position: 0.6; color: "#6a9bc3" }
//            GradientStop { position: 1.0; color: "#1c3448" }
//        }
    }

    Text {
        id: txtValue
        x: 0
        y: 0
        text: textValue.length ? textValue : "--"
        width: parent.width * 4/10
        height: parent.height
        font.pixelSize: 55
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "#FFFFFF"
        elide: Text.ElideRight
    }

    Text {
        id: txtUnit
        x: txtValue.width
        y: txtName.height
        width: parent.width * 2/10
        height: parent.height / 2
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        color: "#FFFFFF"
        elide: Text.ElideRight
    }

    Text {
        id: txtName
        x: parent.width * 7/10
        y: 0
        width: parent.width * 3/10
        height: parent.height / 2
        font.pixelSize: 23
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        color: "#FFFFFF"
        elide: Text.ElideRight
    }

    Text {
        id: txtInterval
        x: parent.width * 7/10
        y: txtName.height
        width: parent.width * 3/10
        height: parent.height / 2
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        color: "#FFFFFF"
        elide: Text.ElideRight
    }

    MouseArea {
        id: viewArea
        anchors.fill: parent
        onClicked: viewClicked()
        onPressAndHold: viewPressAndHold()
    }
}

