import QtQuick 2.7
import QtQuick.Window 2.2
import EnumID 1.0

Item {
    Rectangle {
        id: back_home
        width: 50
        height: 30
        color: "lightsteelblue"
        border.color: "black"
        x: 5
        y: 5
        Text {text: qsTr("Back");anchors.centerIn: parent}
        MouseArea {
            anchors.fill: parent
            onClicked: UIBridge.hmiEvent("", EnumID.ICS_HOME,"")
        }
    }

    Text {
        text: qsTr("IP Adress")
        x: 50
        y: 40
    }

    Rectangle {
        x: 50
        y: 60
        width: 100
        height: 25
        border.color: "black"
        TextInput {
            id: ip_adress
            objectName: "ip_adress"
            anchors.left: parent.left
            width: 250
            height: 25
        }
    }

    Text {
        text: qsTr("Port")
        x: 160
        y: 40
    }

    Rectangle {
        x: 160
        y: 60
        width: 50
        height: 25
        border.color: "black"
        TextInput {
            id: port_to_connect
            objectName: "port_to_connect"
            anchors.left: parent.left
            width: 250
            height: 25
        }
    }

    Rectangle {
        id: connect_server_button
        x: 220
        y: 60
        width: 70
        height: 20
        border.color: "black"
        Text {
            id: connection_status
            objectName: "connection_status"
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_TEST_CONNECTIONS_NETWORK, ip_adress.text
                                  + "," + port_to_connect.text)
            }
        }
    }

    Text {
        text: qsTr("Send Data")
        x: 50
        y: 100
    }

    Rectangle {
        x: 50
        y: 120
        width: 200
        height: 25
        border.color: "black"
        TextInput {
            id: data_send
            objectName: "data_send"
            anchors.left: parent.left
            width: 250
            height: 25
        }
    }

    Rectangle {
        id: send_button
        x: 260
        y: 120
        width: 70
        height: 20
        border.color: "black"
        Text {
            anchors.centerIn: parent
            text: qsTr("Send")
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_SEND_DATA_NETWORK, data_send.text)
            }
        }
    }

    Text {
        id:status
        text: qsTr("Receive/send data")
        x: 50
        y: 160
    }

    Rectangle {
        id: viewData
        width: 300
        height: 150
        border.color: "black"
        x:50
        y:180
        Text {
            id: viewData_network
            objectName: "viewData_network"
        }
    }
}


