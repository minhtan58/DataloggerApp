import QtQuick 2.7

Item {
    property int currentValue: minValue
    property int minValue: 0
    property int maxValue: 100

//    property int eventID: -1
//    property string eventParams: ""

    onMinValueChanged: resetCurrentValue()
    onMaxValueChanged: resetCurrentValue()

    //signal spinClicked
//    onCurrentValueChanged: {
//        if(eventID != -1)
//            UIBridge.hmiEvent(this.objectName, eventID, eventParams)
//    }

    function resetCurrentValue() {
        if(currentValue < minValue)
            currentValue = minValue
        else if(currentValue > maxValue)
            currentValue = maxValue
    }

    width: 150
    height: 40

    Timer {
        id: timerSpin
        interval: 150
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if(mouseSub.containsMouse)
                intervalSub()
            else if (mouseAdd.containsMouse)
                intervalAdd()
        }
    }

    Rectangle {
        anchors.fill: parent
        border.color: parent.enabled ? "#FFFFFF" : "gray"
        border.width: 2
        z: 1
        color: "transparent"
    }

    Rectangle {
        width: 40
        height: 40
        anchors.left: parent.left
        color: mouseSub.containsMouse ? "gray" : "#000000"
        border.color: parent.enabled ? "#FFFFFF" : "gray"
        border.width: 2
        MouseArea {
            id: mouseSub
            anchors.fill: parent
            onClicked: intervalSub()
            onPressAndHold: {
                if(!timerSpin.running)
                    timerSpin.start()
            }
            onReleased: {
                if(timerSpin.running)
                    timerSpin.stop()
            }
            onCanceled: {
                if(timerSpin.running)
                    timerSpin.stop()
            }
        }
    }

    Text {
        width: 40
        height: 40
        anchors.left: parent.left
        text: "-"
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        color: parent.enabled ? "#FFFFFF" : "gray"
    }

    Text {
        id: textContent
        anchors.fill: parent
        text: currentValue
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        color: parent.enabled ? "#FFFFFF" : "gray"
    }

    Rectangle {
        width: 40
        height: 40
        anchors.right: parent.right
        border.color: parent.enabled ? "#FFFFFF" : "gray"
        border.width: 2
        color: mouseAdd.containsMouse ? "gray" : "#000000"
        MouseArea {
            id: mouseAdd
            anchors.fill: parent
            onClicked: intervalAdd()
            onPressAndHold: {
                if(!timerSpin.running)
                    timerSpin.start()
            }
            onReleased: {
                if(timerSpin.running)
                    timerSpin.stop()
            }
            onCanceled: {
                if(timerSpin.running)
                    timerSpin.stop()
            }
        }
    }

    Text {
        width: 40
        height: 40
        anchors.right: parent.right
        text: "+"
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        color: parent.enabled ? "#FFFFFF" : "gray"
    }

    function intervalAdd() {
        if (currentValue >= minValue && currentValue < maxValue)
            currentValue++
        else if(currentValue === maxValue)
            currentValue = minValue
        //spinClicked()
    }

    function intervalSub() {
        if (currentValue > minValue && currentValue <= maxValue)
            currentValue--
        else if(currentValue === minValue)
            currentValue = maxValue
        //spinClicked()
    }
}
