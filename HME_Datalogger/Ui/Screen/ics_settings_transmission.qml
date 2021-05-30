import QtQuick 2.7
import EnumID 1.0
import "../Widget"

Item {
    objectName: "scr_settings_transmission"
    anchors.fill: parent

    property int isAutoUpdateTime: 0

    onIsAutoUpdateTimeChanged: UIBridge.log("onIsAutoUpdateTimeChanged: " + isAutoUpdateTime)

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
        currentIndex: 8
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
                property string title: "Wireless Transmission Setting"
                id: grpServer
                x: 100
                y: 50
                Text {
                    x: 0
                    y: 0
                    width: 200
                    height: 40
                    text: "Enable:"
                    color: "#ffffff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 20
                    wrapMode: Text.Wrap
                }

                QSwitch {
                    id : enable_wireless
                    x: 200
                    y: 0
                    width: 100
                    height: 35
                    checked: false
                }

                Text {
                    x: 0
                    y: 50
                    width: 200
                    height: 40
                    text: "Retransmissing:"
                    color: "#ffffff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 20
                    wrapMode: Text.Wrap
                }

                QSwitch {
                    id : enable_retransmissing_wireless
                    x: 200
                    y: 50
                    width: 100
                    height: 35
                    checked: true
                }

                Text {
                    x: 0
                    y: 100
                    width: 200
                    height: 40
                    text: "Saving power:"
                    color: "#ffffff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 20
                    wrapMode: Text.Wrap
                }

                QSwitch {
                    id : save_power
                    x: 200
                    y: 100
                    width: 100
                    height: 35
                    checked: isAutoUpdateTime
                }

                Text {
                    x: 0
                    y: 150
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
                    x: 200
                    y: 150
                }

                Text {
                    x: 350
                    y: 150
                    width: 100
                    height: 40
                    text: "minute(s)"
                    color: "#ffffff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                    wrapMode: Text.Wrap
                }

                QButton {
                    x: 100
                    y: 210
                    width: 200
                    height: 40
                    text: "Save"
                    eventID: EnumID.HMI_BUTTON_WIRELESS_TRANSMISSION_SETTING
                    eventParams: enable_wireless.textbool + " " +
                                 settings_network_server_interval.currentValue;
                }
            }

            //-------------------------------------------------------------------------
            Item {
                property string title: "Lan Transmission Setting"
                id: lan_transmiss
                x: 100
                y: 50
                Text {
                    x: 0
                    y: 0
                    width: 200
                    height: 40
                    text: "Enable:"
                    color: "#ffffff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 20
                    wrapMode: Text.Wrap
                }

                QSwitch {
                    id : enable_lan
                    x: 200
                    y: 0
                    width: 100
                    height: 35
                    checked: false
                }

                Text {
                    x: 0
                    y: 50
                    width: 200
                    height: 40
                    text: "Retransmissing:"
                    color: "#ffffff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 20
                    wrapMode: Text.Wrap
                }

                QSwitch {
                    id: enable_retransmissing_lan
                    x: 200
                    y: 50
                    width: 100
                    height: 35
                    checked: false
                }

                Text {
                    x: 0
                    y: 150
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
                    id: settings_lan_interval
                    objectName: "settings_lan_interval"
                    x: 200
                    y: 150
                }

                Text {
                    x: 350
                    y: 150
                    width: 100
                    height: 40
                    text: "minute(s)"
                    color: "#ffffff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                    wrapMode: Text.Wrap
                }

                QButton {
                    x: 100
                    y: 210
                    width: 200
                    height: 40
                    text: "Test Transmission"
                    eventID: EnumID.HMI_BUTTON_LAN_TRANSMISSION_SETTING
                    eventParams: enable_lan.textbool + ";" +
                                 enable_retransmissing_lan.textbool + ";" +
                                 settings_lan_interval.currentValue;
                }
            }
        }
    }
}
