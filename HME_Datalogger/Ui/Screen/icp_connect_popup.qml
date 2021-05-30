import QtQuick 2.7
import QtQuick.Window 2.2
import EnumID 1.0

Item {
    id: connected_screen
    property alias timeout: time.interval
    property alias message: tittle.text
    width: 800
    height: 480

    Timer{
        id: time
        repeat: false
        onTriggered: UIBridge.hmiEvent(this.objectName, EnumID.HMI_HIDE_POPUP, "")
    }

    Rectangle{
        anchors.fill: parent
        color: "#000000"
        opacity: 0.5
    }

    Rectangle{
        id: qnBgr
        width: 400
        height: 100
        anchors.centerIn: parent
        color: "#315b7d"
        opacity: 0.95
    }

    Text{
        id: tittle
        anchors.fill: qnBgr
        text: qsTr("Connected")
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 25
        wrapMode: Text.Wrap
    }

    MouseArea{
        anchors.fill: parent
        onClicked: UIBridge.hmiEvent(this.objectName, EnumID.HMI_HIDE_POPUP, "")
    }

    Component.onCompleted: {
        time.start()
    }
}
