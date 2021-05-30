import QtQuick 2.7
import EnumID 1.0
import "../Widget"

Item {
    objectName: "scr_settings_system"
    anchors.fill: parent

    function setVisiblesCursor() {
        settings_station_id.cursorVisible = false
        settings_station_name.cursorVisible = false
        settings_ip_address.cursorVisible = false
        settings_subnet_mask.cursorVisible = false
        settings_gateway.cursorVisible = false
        this.cursorVisible = true
    }

    QLeftTabView {
        currentIndex: 6
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
            width: 1290
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
                text: "System Settings"
                elide: Text.ElideRight
                font.bold: true
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }
        }

        Text {
            x: 100
            y: 100
            width: 150
            height: 50
            text: "Station ID:"
            color: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
            wrapMode: Text.Wrap
        }

        QTextInput {
            id: settings_station_id
            objectName: "settings_station_id"
            x: 250
            y: 100
            width: 250
            height: 40
            isFullKey: true
        }

        Text {
            x: 100
            y: 150
            width: 150
            height: 50
            text: "Station Name:"
            color: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
            wrapMode: Text.Wrap
        }

        QTextInput {
            id: settings_station_name
            objectName: "settings_station_name"
            x: 250
            y: 150
            width: 250
            height: 40
            isFullKey: true
        }

        Text {
            x: 100
            y: 200
            width: 150
            height: 40
            text: "IP Address:"
            color: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
            wrapMode: Text.Wrap
        }

        QTextInput {
            id: settings_ip_address
            objectName: "settings_ip_address"
            x: 250
            y: 200
            width: 250
            height: 40
        }

        Text {
            x: 100
            y: 250
            width: 150
            height: 50
            text: "Subnet Mask:"
            color: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
            wrapMode: Text.Wrap
        }

        QTextInput {
            id: settings_subnet_mask
            objectName: "settings_subnet_mask"
            x: 250
            y: 250
            width: 250
            height: 40
        }

        Text {
            x: 100
            y: 300
            width: 150
            height: 50
            text: "Gateway:"
            color: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
            wrapMode: Text.Wrap
        }

        QTextInput {
            id: settings_gateway
            objectName: "settings_gateway"
            x: 250
            y: 300
            width: 250
            height: 40
        }

        QText {
            text: "Select Date: "
            width: 120
            x: 100
            y: 350
        }

        QDatePicker {
            id: dateSelected
            objectName: "dateSelected"
            x: 250
            y: 350
            width: 290
            height: 35
            z: 1
        }

        QButton {
            x: 200
            y: 460
            width: 150
            height: 40
            text: "Submit"
            eventID: EnumID.HMI_BUTTON_SUBMIT_SYSTEM_SETTING
            eventParams: "1111 " + settings_station_id.text   + " " +
                         settings_station_name.text + " " +
                         settings_ip_address.text   + " " +
                         settings_subnet_mask.text  + " " +
                         dateSelected.datetime  + " " +
                         settings_gateway.text + "\r";
        }

        QButton {
            x: 400
            y: 460
            width: 150
            height: 40
            text: "Reset"
            eventID: EnumID.HMI_BUTTON_RESET_SYS_SETTING
            eventParams: " "
        }
    }
}
