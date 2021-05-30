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
            onClicked: UIBridge.hmiEvent("", EnumID.HMI_HOME_SCREEN,"")
        }
    }

    Text {
        text: qsTr("Port")
        x: 50
        y: 40
    }

    Rectangle {
        x: 50
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
        x: 130
        y: 60
        width: 70
        height: 25
        border.color: "black"
        Text {
            id: connection_status
            objectName: "connection_status"
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_TEST_CONNECTIONS_SERIALPORT, port_to_connect.text)
            }
        }
    }

    Rectangle {
        id: popup1
        x: 400
        y: 60
        width: 70
        height: 25
        border.color: "black"
        Text {
            anchors.centerIn: parent
            text: qsTr("Check")
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent("", EnumID.HMI_CONNECTED_POPUP,"")
                console.log("Vao roi day")
            }
        }
    }

    Text {
        text: qsTr("Send Data")
        x: 50
        y: 100
    }

    Rectangle {
        x: 170
        y: 120
        width: 100
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
        x: 50
        y: 120
        width: 70
        height: 25
        border.color: "black"
        Text {
            anchors.centerIn: parent
            text: qsTr("Send")
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_SEND_DATA_SERIALPORT, data_send.text)
            }
        }
    }

    Rectangle {
        id: start_network
        x: 50
        y: 150
        width: 100
        height: 25
        border.color: "black"
        Text {
            anchors.centerIn: parent
            text: qsTr("Start Network")
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_REQUEST_START_NETWORK, "")
            }
        }
    }

    Rectangle {
        id: permit_join_state
        x: 250
        y: 150
        width: 100
        height: 25
        border.color: "black"
        Text {
            anchors.centerIn: parent
            text: qsTr("Permit Join State")
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_REQUEST_PERMIT_JOIN_STATE, "")
            }
        }
    }

    Rectangle {
        id: pemit_join
        x: 50
        y: 180
        width: 100
        height: 25
        border.color: "black"
        Text {
            anchors.centerIn: parent
            text: qsTr("Permit Join")
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_REQUEST_PERMIT_JOIN, adress.text)
            }
        }
    }

    Rectangle {
        x: 170
        y: 180
        width: 50
        height: 25
        border.color: "black"
        TextInput {
            id: adress
            objectName: "adress"
            anchors.left: parent.left
            width: 250
            height: 25
        }
    }

    Rectangle {
        x: 250
        y: 180
        width: 50
        height: 25
        border.color: "black"
        TextInput {
            id: value
            objectName: "value"
            anchors.left: parent.left
            width: 250
            height: 25
        }
    }

    Text {
        id:status
        text: qsTr("Receive/send data")
        x: 50
        y: 210
    }

    Rectangle {
        id: viewData
        width: 300
        height: 150
        border.color: "black"
        x:50
        y:230
        Text {
            id: viewData_portcom
            objectName: "viewData_portcom"
        }
    }

    Text {
        id: text2
        text: qsTr("Receive/send data")
        x: 450
        y: 210
    }

    Rectangle {
        id: viewPacket
        width: 300
        height: 150
        border.color: "black"
        x:450
        y:230
        Text {
            id: view_Packet
            objectName: "view_Packet"
        }
    }

    Rectangle {
        id: on_off_btn
        x: 50
        y: 400
        width: 50
        height: 25
        border.color: "black"
        Text {
            anchors.centerIn: parent
            text: qsTr("OnOff")
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_SEND_DATA_SERIALPORT, data_send.text)
            }
        }
    }

    Rectangle {
        x: 120
        y: 400
        width: 30
        height: 25
        border.color: "black"
        TextInput {
            id: adress_mode
            objectName: "adress_mode"
            anchors.left: parent.left
            width: 250
            height: 25
        }
    }

    Rectangle {
        x: 160
        y: 400
        width: 30
        height: 25
        border.color: "black"
        TextInput {
            id: adress2
            objectName: "adress2"
            anchors.left: parent.left
            width: 250
            height: 25
        }
    }
    Rectangle {
        x: 200
        y: 400
        width: 30
        height: 25
        border.color: "black"
        TextInput {
            id: src_ep
            objectName: "src_ep"
            anchors.left: parent.left
            width: 250
            height: 25
        }
    }
    Rectangle {
        x: 240
        y: 400
        width: 30
        height: 25
        border.color: "black"
        TextInput {
            id: dts_ep
            objectName: "dts_ep"
            anchors.left: parent.left
            width: 250
            height: 25
        }
    }
    Rectangle {
        x: 280
        y: 400
        width: 30
        height: 25
        border.color: "black"
        TextInput {
            id: led_status
            objectName: "led_status"
            anchors.left: parent.left
            width: 250
            height: 25
        }
    }
}


