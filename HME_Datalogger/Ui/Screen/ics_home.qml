import QtQuick 2.7
import EnumID 1.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.LocalStorage 2.0
import "../Widget"

Item {
    Rectangle {
        id: working_icon
        x: 100
        y: 100
        width: 80
        height: 80
        color: "lightBlue"
        border.color: "black"
        Text {
            text: qsTr("PortCom")
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent("", EnumID.HMI_CONNECTION_PORTCOM_SCREEN, "")
            }
        }
    }

    Rectangle {
        id: connection_icon
        x: 200
        y: 100
        width: 80
        height: 80
        color: "lightBlue"
        border.color: "black"
        Text {
            text: qsTr("Internet")
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent("", EnumID.HMI_CONNECTION_NETWORK_SCREEN, "")
            }
        }
    }

    Rectangle {
        id: dada_view_history
        x: 400
        y: 100
        width: 80
        height: 80
        color: "lightBlue"
        border.color: "black"
        Text {
            text: qsTr("Dataview History")
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent("", EnumID.HMI_VIEW_DATA_HISTORY_SCREEN, "")
            }
        }
    }

    Rectangle {
        id: login_form
        x: 500
        y: 100
        width: 80
        height: 80
        color: "lightBlue"
        border.color: "black"
        Text {
            text: qsTr("Login Form")
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent("", EnumID.HMI_LOGIN_FORM, "")
            }
        }
    }

    Rectangle {
        id: overview_form
        x: 600
        y: 100
        width: 80
        height: 80
        color: "lightBlue"
        border.color: "black"
        Text {
            text: qsTr("Overview Form")
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent("", EnumID.HMI_SETTING_OVERVIEW_SCREEN, "")
            }
        }
    }

    Rectangle {
        id: alarm_form
        x: 700
        y: 100
        width: 80
        height: 80
        color: "lightBlue"
        border.color: "black"
        Text {
            text: qsTr("Alarm Form")
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent("", EnumID.HMI_SETTING_ALARM_SCREEN, "")
            }
        }
    }
}
