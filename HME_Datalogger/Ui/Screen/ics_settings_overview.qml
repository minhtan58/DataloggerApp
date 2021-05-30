import QtQuick 2.7
import EnumID 1.0
import "../Widget"

Item {
    objectName: "scr_settings_overview"
    anchors.fill: parent
    property int gotoDevMode: 0

    onGotoDevModeChanged: {
        if(gotoDevMode == 10)
            UIBridge.hmiEvent("", CEMSEnum.HMI_TAB_SELECT, "development")
    }

    QLeftTabView {
        currentIndex: 0
    }

    Item {
        x: 210
        width: 1290
        height: 800

        Rectangle {
            anchors.fill: parent
            color: "#315b7d"
            opacity: 0.3
        }

        Item {
            id: header
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
                text: "Overview"
                elide: Text.ElideRight
                font.bold: true
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            MouseArea {
                anchors.fill: parent
                onClicked: gotoDevMode++
            }
        }

        Item {
            x: 50
            y: 70
            Text {
                x: 0
                y: 0
                width: 200
                height: 50
                text: "Model Name:"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                objectName: "settings_overview_model_name_information"
                x: 200
                y: 0
                width: 250
                height: 50
                text: "D-SL21"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            /*
            Text {
                objectName: "settings_overview_serialport_status"
                property bool isConnected: false
                x: 400
                y: 0
                width: 150
                height: 60
                text: isConnected ? "Connected" : "Not Connect"
                color: isConnected ? "#00cc00" : "#ff0000"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }
            */

            Text {
                x: 0
                y: 60
                width: 200
                height: 50
                text: "Serial Number:"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                objectName: "settings_overview_serial_number"
                x: 200
                y: 60
                width: 250
                height: 50
                text: "COM7,115200,8,N,1"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                objectName: "settings_overview_serial_number_status"
                property bool isConnected: false
                x: 450
                y: 60
                width: 200
                height: 50
                text: isConnected ? "Connected" : "Not Connect"
                color: isConnected ? "#00cc00" : "#ff0000"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                x: 0
                y: 120
                width: 200
                height: 50
                text: "Mac Addres:"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                objectName: "settings_overview_mac_address"
                x: 200
                y: 120
                width: 250
                height: 50
                text: "192.168.0.100:22"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                objectName: "settings_overview_mac_status"
                property bool isConnected: false
                x: 450
                y: 120
                width: 200
                height: 50
                text: isConnected ? "Connected" : "Not Connect"
                color: isConnected ? "#00cc00" : "#ff0000"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                x: 0
                y: 180
                width: 200
                height: 50
                text: "Station Name:"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                objectName: "settings_overview_station_name"
                x: 200
                y: 180
                width: 250
                height: 50
                text: "HME Datalogger"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                x: 0
                y: 240
                width: 200
                height: 50
                text: "Firmware Version:"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                objectName: "settings_overview_firmware_version"
                x: 200
                y: 240
                width: 250
                height: 50
                text: "00:05:00"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                x: 0
                y: 300
                width: 200
                height: 50
                text: "IP Address:"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            Text {
                objectName: "settings_overview_ip_address"
                x: 200
                y: 300
                width: 250
                height: 50
                text: "192.168.1.1"
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }
        }
    }
}
