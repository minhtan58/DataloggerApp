import QtQuick 2.7
import EnumID 1.0
import "../Widget"

Item {
    objectName: "scr_settings_serial_port"
    anchors.fill: parent
    property string listSerialPort: ""
    property string currentSerialPort: ""
    onListSerialPortChanged: {
        UIBridge.log("listSerialPort = " + listSerialPort)
        var listPort = listSerialPort.split(",")
        var listModel = []
        if(!listPort.length) {
            return
        }
        for(var idx = 0; idx < listPort.length; idx++)
            listModel.push(listPort[idx])
        UIBridge.log("listModel = " + listModel)
        settings_serialport_portname.model = listModel
        if(contains(listModel, currentSerialPort))
            settings_serialport_portname.currentValue = currentSerialPort
        else
            settings_serialport_portname.currentValue = listModel[0]
    }

    function setFocus() {
//        var oldState = this.pressed
//        settings_serialport_portname.pressed = false
//        settings_serialport_baudrate.pressed = false
//        this.pressed = oldState
    }

    function contains(list, element) {
        for(var idx = 0; idx < list.length; idx++)
            if(list[idx] === element)
                return true
        return false
    }

    QLeftTabView {
        currentIndex: 3
    }

    Item {
        x: 210
        width: 1290
        height: 800

        Rectangle {
            id: background
            anchors.fill: parent
            color: "#315b7d"
            opacity: 0.3
        }

        Item {
            id: header
            x: 0
            y: 0
            width: parent.width
            height: 50
            Rectangle {
                anchors.fill: parent
                anchors.bottomMargin: 1
                opacity: 0.8
                clip: true
                border.color: "steelblue"
                border.width: 2
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#6a9bc3" }
                    GradientStop { position: 0.4; color: "#1c3448" }
                    GradientStop { position: 0.6; color: "#1c3448" }
                    GradientStop { position: 1.0; color: "#6a9bc3" }
                }
            }

            Text {
                anchors.fill: parent
                text: "Serial Port Settings"
                elide: Text.ElideRight
                font.bold: true
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }
        }

        Item {
            x: 150
            y: 100
            Text {
                x: 0
                y: 0
                width: 120
                height: 40
                text: "Port Name:"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            QComboBox {
                id: settings_serialport_portname
                objectName: "settings_serialport_portname"
                x: 120
                y: 0
                onComboBoxClicked: setFocus()
            }

            Text {
                x: 0
                y: 50
                width: 120
                height: 40
                text: "Baudrate:"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            QComboBox {
                id: settings_serialport_baudrate
                objectName: "settings_serialport_baudrate"
                x: 120
                y: 50
                model: ["4800", "9600", "19200", "38400", "57600", "115200"]
                onComboBoxClicked: setFocus()
            }

            Text {
                x: 0
                y: 100
                width: 350
                height: 40
                text: settings_serialport_portname.currentValue === '' ? '' : settings_serialport_portname.currentValue
                                                                         + " " + settings_serialport_baudrate.currentValue
                                                                         + "bps 8, N, 1, None"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                font.bold: true
                wrapMode: Text.Wrap
            }

            QButton {
                x: 0
                y: 160
                width: 170
                height: 40
                text: "Test Connection"
                eventID: EnumID.HMI_TEST_CONNECTIONS_SERIALPORT
                eventParams: settings_serialport_portname.currentValue + "," +
                             settings_serialport_baudrate.currentValue;
            }

            Rectangle {
                id: connect_server_button
                x: 180
                y: 160
                width: 150
                height: 40
                border.color: "black"
                color: "#ffffff"
                Text {
                    id: connection_status
                    objectName: "connection_status"
                    anchors.centerIn: parent
                    color: "gray"
                    font.pixelSize: 20
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        UIBridge.hmiEvent(this.objectName, EnumID.HMI_CONNECTIONS_SERIALPORT,
                                          settings_serialport_portname.currentValue + "," +settings_serialport_baudrate.currentValue)
                    }
                }
            }

            Text {
                id: name
                x: 675
                y: 580
                width: 350
                height: 50
                text: '<html><style type="text/css"></style><a href="http://google.com">Forgot password?</a></html>' //qsTr("Forgot password?")
                font.pointSize: 14
                onLinkActivated: UIBridge.hmiEvent("", EnumID.HMI_HOME_SCREEN, "")
            }

            /*
            Rectangle {
                id: start_network
                x: 500
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
                id: pemit_join
                x: 500
                y: 200
                width: 100
                height: 25
                border.color: "black"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Get Version")
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        UIBridge.hmiEvent(this.objectName, EnumID.HMI_REQUEST_PERMIT_JOIN, "")
                    }
                }
            }

            Rectangle {
                id: permit_join_state
                x: 500
                y: 250
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
            */
        }
    }
}
