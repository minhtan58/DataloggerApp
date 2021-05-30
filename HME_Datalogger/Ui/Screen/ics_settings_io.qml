import QtQuick 2.7
import EnumID 1.0
import "../Widget"

Item {
    objectName: "scr_settings_io"
    anchors.fill: parent

    function setVisiblesCursor() {
        settings_network_server_ip.cursorVisible = false
        settings_network_server_port.cursorVisible = false
        settings_network_ftp_ip.cursorVisible = false
        settings_network_ftp_port.cursorVisible = false
        settings_network_ftp_user.cursorVisible = false
        settings_network_ftp_password.cursorVisible = false
        this.cursorVisible = true
    }

    QLeftTabView {
        currentIndex: 7
    }

    Item {
        x: 210
        width: 1290
        height: 800

        Rectangle {
            anchors.fill: parent
            opacity: 0.3
            gradient: Gradient {
                GradientStop { position: 0.0; color: "steelblue" }
                GradientStop { position: 1.0; color: "#1c3448" }
            }
        }

        QTabWidget {
            id: tabs
            anchors.fill: parent
            Item {
                property string title: "Settings Analog"
                objectName: "scr_history_dataview"
                width: 820
                height: 460

                /************************************/
                QListView {
                    x: 10
                    y: 50
                    width: 630
                    height: 600
                    model: listHistory
                    emptyText: "No Data"
                    delegate: DataHistoryDelegate {}
                    header: Item {
                        width: parent.width
                        height: 35
                        z: 2
                        property int secSize: 10
                        QText {
                            id: txTime
                            text: "AI Chanel"
                            width: parent.width * 2/secSize
                            height: parent.height
                            anchors.leftMargin: 20
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            backgroundColor: "steelblue"
                            font.bold: true
                        }
                        QText {
                            id: txtO2
                            text: "Range"
                            x: txTime.width
                            width: parent.width * 2/secSize
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            backgroundColor: "steelblue"
                            font.bold: true
                        }
                        QText {
                            id: txtCO
                            text: "Status"
                            x: txtO2.x + txtO2.width
                            width: parent.width * 2/secSize
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            backgroundColor: "steelblue"
                            font.bold: true
                        }
                        QText {
                            id: txtNO
                            text: "Name"
                            x: txtCO.x + txtCO.width
                            width: parent.width * 2/secSize
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            backgroundColor: "steelblue"
                            font.bold: true
                        }
                        QText {
                            id: txtNOX
                            text: "Other"
                            x: txtNO.x + txtNO.width
                            width: parent.width * 2/secSize
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            backgroundColor: "steelblue"
                            font.bold: true
                        }
                    }
                }
                /************************************/
                Item {
                    x: 650
                    y: 50
                    width: 630
                    height: 600

                    Rectangle {
                        id: background1
                        anchors.fill: parent
                        color: "#315b7d"
                        opacity: 0.3
                    }

                    Item {
                        id: header1
                        x: 0
                        y: 0
                        width: parent.width
                        height: 50
                        Rectangle {
                            anchors.fill: parent
                            anchors.bottomMargin: 1
                            color: "steelblue"
                            opacity: 0.8
                            clip: true
                            border.color: "steelblue"
                            border.width: 2
                        }

                        Text {
                            anchors.fill: parent
                            text: "Config Chanel"
                            elide: Text.ElideRight
                            font.bold: true
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        Text {
                            x: 100
                            y: 100
                            width: 150
                            height: 40
                            text: "Chanel:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QComboBox {
                            id: combobox_settings_alarm_air_component
                            objectName: "combobox_settings_alarm_air_component"
                            x: 250
                            y: 100
                            model: ["O\u2082", "CO", "NO", "NOx", "SO\u2082", "Temperature", "Oppacity", "Dust PM", "Velocity", "Flow"]
                            onCurrentIndexChanged: {
                                loadList.item.currentIndex = currentIndex
                                txt_settings_alarm_set_low.text = listAlarm.get(currentIndex).airAlarmMin
                                txt_settings_alarm_set_high.text = listAlarm.get(currentIndex).airAlarmMax
                            }
                        }

                        Text {
                            x: 100
                            y: 150
                            width: 150
                            height: 50
                            text: "Input Rage:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QTextInput {
                            id: settings_network_ftp_user
                            objectName: "settings_network_ftp_user"
                            x: 250
                            y: 150
                            width: 250
                            height: 40
                            isFullKey: true
                            onTextInputClicked: {
                                setVisiblesCursor()
                            }
                        }

                        Text {
                            x: 100
                            y: 200
                            width: 150
                            height: 50
                            text: "Name:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QTextInput {
                            id: settings_network_ftp_password
                            objectName: "settings_network_ftp_password"
                            x: 250
                            y: 200
                            width: 250
                            height: 40
                            isFullKey: true
                            onTextInputClicked: {
                                setVisiblesCursor()
                            }
                        }

                        Text {
                            x: 100
                            y: 250
                            width: 150
                            height: 40
                            text: "Interval:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QSpinBox {
                            id: settings_network_server_interval
                            objectName: "settings_network_server_interval"
                            x: 250
                            y: 250
                        }

                        Text {
                            x: 100
                            y: 300
                            width: 150
                            height: 40
                            text: "Output Rage:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        Text {
                            x: 250
                            y: 300
                            width: 100
                            height: 40
                            text: "Min:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QComboBox {
                            id: combobox_settings_output_rage_min
                            objectName: "combobox_settings_output_rage_min"
                            x: 350
                            y: 300
                            model: ["CO", "NO", "NOx"]
                            onCurrentIndexChanged: {
                                loadList.item.currentIndex = currentIndex
                                txt_settings_alarm_set_low.text = listAlarm.get(currentIndex).airAlarmMin
                                txt_settings_alarm_set_high.text = listAlarm.get(currentIndex).airAlarmMax
                            }
                        }

                        Text {
                            x: 250
                            y: 350
                            width: 100
                            height: 40
                            text: "Max:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QComboBox {
                            id: combobox_settings_output_rage_max
                            objectName: "combobox_settings_output_rage_max"
                            x: 350
                            y: 350
                            model: ["CO", "NO", "NOx"]
                            onCurrentIndexChanged: {
                                loadList.item.currentIndex = currentIndex
                                txt_settings_alarm_set_low.text = listAlarm.get(currentIndex).airAlarmMin
                                txt_settings_alarm_set_high.text = listAlarm.get(currentIndex).airAlarmMax
                            }
                        }

                        Text {
                            x: 100
                            y: 400
                            width: 150
                            height: 40
                            text: "Unit:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QComboBox {
                            id: combobox_settings_unit
                            objectName: "combobox_settings_unit"
                            x: 250
                            y: 400
                            model: ["CO", "NO", "NOx"]
                            onCurrentIndexChanged: {
                                loadList.item.currentIndex = currentIndex
                                txt_settings_alarm_set_low.text = listAlarm.get(currentIndex).airAlarmMin
                                txt_settings_alarm_set_high.text = listAlarm.get(currentIndex).airAlarmMax
                            }
                        }

                        Text {
                            x: 100
                            y: 450
                            width: 150
                            height: 40
                            text: "Enable:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QSwitch {
                            x: 250
                            y: 450
                            width: 100
                            height: 35
                            checked: isAutoUpdateTime === 1
                        }

                        QButton {
                            x: 200
                            y: 500
                            width: 200
                            height: 40
                            text: "Save Config"
                            isEnabled: settings_network_server_ip.text.length > 0 && settings_network_server_port.text > 0
                            eventID: EnumID.HMI_BUTTON_TEST_CONNECTIONS_NETWORK_SERVER
                            eventParams: settings_network_server_ip.text + "," +
                                         settings_network_server_port.text;
                        }
                    }
                }
            }

            //-------------------------------------------------------------------------
            Item {
                property string title: "Settings Digital"
                objectName: "scr_history_dataview"
                width: 820
                height: 460

                /************************************/
                QListView {
                    x: 10
                    y: 50
                    width: 630
                    height: 600
                    model: listHistory
                    emptyText: "No Data"
                    delegate: DataHistoryDelegate {}
                    header: Item {
                        width: parent.width
                        height: 35
                        z: 2
                        property int secSize: 10
                        QText {
                            id: ia_chanel
                            text: "AI Chanel"
                            width: parent.width * 2/secSize
                            height: parent.height
                            anchors.leftMargin: 20
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            backgroundColor: "steelblue"
                            font.bold: true
                        }
                        QText {
                            id: range
                            text: "Range"
                            x: ia_chanel.width
                            width: parent.width * 2/secSize
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            backgroundColor: "steelblue"
                            font.bold: true
                        }
                        QText {
                            id: stauts
                            text: "Status"
                            x: range.x + range.width
                            width: parent.width * 2/secSize
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            backgroundColor: "steelblue"
                            font.bold: true
                        }
                        QText {
                            id: name
                            text: "Name"
                            x: stauts.x + stauts.width
                            width: parent.width * 2/secSize
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            backgroundColor: "steelblue"
                            font.bold: true
                        }
                        QText {
                            id: other
                            text: "Other"
                            x: name.x + name.width
                            width: parent.width * 2/secSize
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            backgroundColor: "steelblue"
                            font.bold: true
                        }
                    }
                }

                Item {
                    x: 650
                    y: 50
                    width: 630
                    height: 600

                    Rectangle {
                        id: background2
                        anchors.fill: parent
                        color: "#315b7d"
                        opacity: 0.3
                    }

                    Item {
                        id: header2
                        x: 0
                        y: 0
                        width: parent.width
                        height: 50

                        Rectangle {
                            anchors.fill: parent
                            anchors.bottomMargin: 1
                            color: "steelblue"
                            opacity: 0.8
                            clip: true
                            border.color: "steelblue"
                            border.width: 2
                        }

                        Text {
                            anchors.fill: parent
                            text: "Config Chanel"
                            elide: Text.ElideRight
                            font.bold: true
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        Text {
                            x: 100
                            y: 100
                            width: 150
                            height: 40
                            text: "Chanel:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QComboBox {
                            id: combobox_settings_select_digital_chanel
                            objectName: "combobox_settings_select_digital_chanel"
                            x: 250
                            y: 100
                            model: ["O\u2082", "CO", "NO", "NOx", "SO\u2082", "Temperature", "Oppacity", "Dust PM", "Velocity", "Flow"]
                            onCurrentIndexChanged: {
                                loadList.item.currentIndex = currentIndex
                                txt_settings_alarm_set_low.text = listAlarm.get(currentIndex).airAlarmMin
                                txt_settings_alarm_set_high.text = listAlarm.get(currentIndex).airAlarmMax
                            }
                        }

                        Text {
                            x: 100
                            y: 150
                            width: 150
                            height: 50
                            text: "Input Rage:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QTextInput {
                            id: settings_digital_rage
                            objectName: "settings_digital_rage"
                            x: 250
                            y: 150
                            width: 250
                            height: 40
                            isFullKey: true
                            onTextInputClicked: {
                                setVisiblesCursor()
                            }
                            doneEventID: EnumID.HMI_TEXTINPUT_DONE_FTP_USERNAME
                        }

                        Text {
                            x: 100
                            y: 200
                            width: 150
                            height: 50
                            text: "Name:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QTextInput {
                            id: settings_digital_name
                            objectName: "settings_digital_name"
                            x: 250
                            y: 200
                            width: 250
                            height: 40
                            isFullKey: true
                            onTextInputClicked: {
                                setVisiblesCursor()
                            }
                            doneEventID: EnumID.HMI_TEXTINPUT_DONE_FTP_PASSWORD
                        }

                        Text {
                            x: 100
                            y: 250
                            width: 150
                            height: 40
                            text: "Interval:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QSpinBox {
                            id: settings_digital_interval
                            objectName: "settings_digital_interval"
                            x: 250
                            y: 250
                        }

                        Text {
                            x: 100
                            y: 300
                            width: 150
                            height: 40
                            text: "Output Rage:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        Text {
                            x: 250
                            y: 300
                            width: 100
                            height: 40
                            text: "Min:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QComboBox {
                            id: combobox_settings_digital_rage_min
                            objectName: "combobox_settings_digital_rage_min"
                            x: 350
                            y: 300
                            model: ["CO", "NO", "NOx"]
                            onCurrentIndexChanged: {
                                loadList.item.currentIndex = currentIndex
                                txt_settings_alarm_set_low.text = listAlarm.get(currentIndex).airAlarmMin
                                txt_settings_alarm_set_high.text = listAlarm.get(currentIndex).airAlarmMax
                            }
                        }

                        Text {
                            x: 250
                            y: 350
                            width: 100
                            height: 40
                            text: "Max:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QComboBox {
                            id: combobox_settings_digital_rage_max
                            objectName: "combobox_settings_digital_rage_max"
                            x: 350
                            y: 350
                            model: ["CO", "NO", "NOx"]
                            onCurrentIndexChanged: {
                                loadList.item.currentIndex = currentIndex
                                txt_settings_alarm_set_low.text = listAlarm.get(currentIndex).airAlarmMin
                                txt_settings_alarm_set_high.text = listAlarm.get(currentIndex).airAlarmMax
                            }
                        }

                        Text {
                            x: 100
                            y: 400
                            width: 150
                            height: 40
                            text: "Unit:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QComboBox {
                            id: combobox_digital_unit
                            objectName: "combobox_settings_unit"
                            x: 250
                            y: 400
                            model: ["CO", "NO", "NOx"]
                            onCurrentIndexChanged: {
                                loadList.item.currentIndex = currentIndex
                                txt_settings_alarm_set_low.text = listAlarm.get(currentIndex).airAlarmMin
                                txt_settings_alarm_set_high.text = listAlarm.get(currentIndex).airAlarmMax
                            }
                        }

                        Text {
                            x: 100
                            y: 450
                            width: 150
                            height: 40
                            text: "Enable:"
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        QSwitch {
                            x: 250
                            y: 450
                            width: 100
                            height: 35
                            checked: isAutoUpdateTime === 1
                        }

                        QButton {
                            x: 200
                            y: 500
                            width: 200
                            height: 40
                            text: "Save Config"
                            isEnabled: settings_network_server_ip.text.length > 0 && settings_network_server_port.text > 0
                            eventID: EnumID.HMI_BUTTON_TEST_CONNECTIONS_NETWORK_SERVER
                            eventParams: settings_network_server_ip.text + "," +
                                         settings_network_server_port.text;
                        }
                    }
                }
            }
        }
    }
}
