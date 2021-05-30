import QtQuick 2.7
import EnumID 1.0

Item {
    objectName: "prt_topbar"

    property string stationId: ""
    property string stationName: ""
    property string systemDate: ""
    property string systemTime: ""
    property int alarmCount: 0

    Rectangle {
        width: 1500
        height: 95
        color: "#315b7d"
        opacity: 0.5
    }

    Image {
        x: 10
        y: 10
        width: 200
        height: 80
        source: "qrc:/Ui/Images/logo_hme.png"
    }

    Image {
        x: 200
        y: 0
        width: 70
        height: 68
        source: mouseHome.containsMouse ? "qrc:/Ui/Images/home_active.png" : "qrc:/Ui/Images/home_inactive.png"

        MouseArea {
            id: mouseHome
            anchors.fill: parent
            onClicked: UIBridge.hmiEvent("", EnumID.HMI_HOME_SCREEN, "")
        }
    }

    Text {
        x: 550
        y: 0
        width: 450
        height: 100
        text: "CONFIGUTATION DATALOGGER"
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 25
        wrapMode: Text.Wrap
        font.bold: true
    }

    Text {
        id: sttTime
        x: 1360
        y: 10
        width: 200
        height: 50
        text: systemTime
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 30
        font.bold: true
        wrapMode: Text.Wrap
    }

    Text {
        x: 1330
        y: 60
        width: 50
        height: 30
        text: "Login"
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 16
        wrapMode: Text.Wrap
        onLinkActivated: UIBridge.hmiEvent("", EnumID.HMI_HOME_SCREEN, "")
    }

    Text {
        x: 1385
        y: 60
        width: 50
        height: 30
        text: "Help"
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 16
        wrapMode: Text.Wrap
        onLinkActivated: UIBridge.hmiEvent("", EnumID.HMI_HOME_SCREEN, "")
    }

    Text {
        x: 1430
        y: 60
        width: 50
        height: 30
        text: "About"
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 16
        wrapMode: Text.Wrap
        onLinkActivated: UIBridge.hmiEvent("", EnumID.HMI_HOME_SCREEN, "")
    }
}
