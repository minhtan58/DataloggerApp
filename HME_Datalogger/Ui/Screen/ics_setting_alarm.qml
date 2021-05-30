import QtQuick 2.7
import QtQuick.Controls 1.4
import EnumID 1.0
import "../Widget"

Item {
    objectName: "scr_settings_alarm"
    anchors.fill: parent

    property int    air_status_O2: 0
    property string air_min_O2: ""
    property string air_max_O2: ""

    property int    air_status_CO: 0
    property string air_min_CO: ""
    property string air_max_CO: ""

    property int    air_status_NO: 0
    property string air_min_NO: ""
    property string air_max_NO: ""

    property int    air_status_NOX: 0
    property string air_min_NOX: ""
    property string air_max_NOX: ""

    property int    air_status_SO2: 0
    property string air_min_SO2: ""
    property string air_max_SO2: ""

    property int    air_status_TEMP: 0
    property string air_min_TEMP: ""
    property string air_max_TEMP: ""

    property int    air_status_OPP: 0
    property string air_min_OPP: ""
    property string air_max_OPP: ""

    property int    air_status_DUST_PM: 0
    property string air_min_DUST_PM: ""
    property string air_max_DUST_PM: ""

    property int    air_status_VEL: 0
    property string air_min_VEL: ""
    property string air_max_VEL: ""

    property int    air_status_FLOW: 0
    property string air_min_FLOW: ""
    property string air_max_FLOW: ""

    function setVisiblesCursor() {
        txt_settings_alarm_set_low.cursorVisible = false
        txt_settings_alarm_set_high.cursorVisible = false
        this.cursorVisible = true
    }

    ListModel {
        id: listAlarm
    }

    QLeftTabView {
        currentIndex: 4
    }

    Item {
        x: 210
        y: 10
        width: 580
        height: 390

        Rectangle {
            anchors.fill: parent
            radius: 10
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
                text: "Alarm Settings"
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
            x: 20
            y: 20
            QComboBox {
                id: combobox_settings_alarm_air_component
                objectName: "combobox_settings_alarm_air_component"
                x: 0
                y: 50
                model: ["O\u2082", "CO", "NO", "NOx", "SO\u2082", "Temperature", "Oppacity", "Dust PM", "Velocity", "Flow"]
                onCurrentIndexChanged: {
                    loadList.item.currentIndex = currentIndex
                    txt_settings_alarm_set_low.text = listAlarm.get(currentIndex).airAlarmMin
                    txt_settings_alarm_set_high.text = listAlarm.get(currentIndex).airAlarmMax
                }
            }

            Text {
                x: 170
                y: 50
                width: 60
                height: 40
                text: "Low"
                elide: Text.ElideRight
                font.bold: true
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            QTextInput {
                id: txt_settings_alarm_set_low
                objectName: "txt_settings_alarm_set_low"
                x: 230
                y: 50
                width: 120
                height: 40
                onTextInputClicked: {
                    setVisiblesCursor()
                }
            }

            Text {
                x: 360
                y: 50
                width: 60
                height: 40
                text: "High"
                elide: Text.ElideRight
                font.bold: true
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                wrapMode: Text.Wrap
            }

            QTextInput {
                id: txt_settings_alarm_set_high
                objectName: "txt_settings_alarm_set_high"
                x: 420
                y: 50
                width: 120
                height: 40
                onTextInputClicked: {
                    setVisiblesCursor()
                }
            }

            Rectangle {
                x: 0
                y: 100
                width: 540
                height: 210
                border.width: 1
                border.color: "gray"
                color: "transparent"
            }

            Loader {
                id: loadList
                asynchronous: true
                sourceComponent: listComponent
            }

            Component{
                id: listComponent
                ListView {
                    id: lvAlarm
                    x: 5
                    y: 105
                    width: 530
                    height: 200
                    model: listAlarm
                    clip: true
                    highlight: Rectangle { color: "#000000"; radius: 2; opacity: 0.5 }
                    highlightResizeDuration: 100
                    highlightMoveDuration: 300
                    highlightFollowsCurrentItem: true
                    focus: true
                    delegate: Item {
                        x: 10
                        width: 540
                        height: 40
                        focus: true
                        Text {
                            width: 100
                            height: 40
                            text: airComponent
                            elide: Text.ElideRight
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }
                        Text {
                            x: 100
                            width: 80
                            height: 40
                            text: airAlarmMin
                            elide: Text.ElideRight
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }
                        Text {
                            x: 180
                            width: 20
                            height: 40
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                            text: '-'
                        }

                        Text {
                            x: 200
                            width: 80
                            height: 40
                            text: airAlarmMax
                            elide: Text.ElideRight
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }

                        Text {
                            x: 320
                            width: 100
                            height: 40
                            text: airUnit
                            elide: Text.ElideRight
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                        }
                        QCheckbox {
                            anchors.right: parent.right
                            y: 5
                            width: 100
                            text: airAlarmTurnOn === 1 ? "ON" : "OFF"
                            checked: airAlarmTurnOn === 1
                            onClicked: {
                                combobox_settings_alarm_air_component.currentIndex = index
                                UIBridge.hmiEvent(this.objectName, EnumID.HMI_COMBOBOX_SETTINGS_ALARM, index + "," + (1 - airAlarmTurnOn))
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            anchors.rightMargin: 100
                            onClicked: combobox_settings_alarm_air_component.currentIndex = index
                            onDoubleClicked: combobox_settings_alarm_air_component.currentIndex = index
                        }
                    }
                }
            }

            QButton {
                x: 440
                y: 320
                width: 100
                height: 40
                text: "Save"
                eventID: EnumID.HMI_BUTTON_SAVE_SETTINGS_ALARM
                eventParams: combobox_settings_alarm_air_component.currentIndex + "," +
                             txt_settings_alarm_set_low.text + "," +
                             txt_settings_alarm_set_high.text;
            }
        }
    }

    Component.onCompleted: {
        listAlarm.append({airComponent: "AI00",  airAlarmMin: air_min_O2,        airAlarmMax: air_max_O2,        airUnit:"%V",           airAlarmTurnOn: air_status_O2       })
        listAlarm.append({airComponent: "AI01",  airAlarmMin: air_min_CO,        airAlarmMax: air_max_CO,        airUnit:"mg/Nm\u00B3",  airAlarmTurnOn: air_status_CO       })
        listAlarm.append({airComponent: "AI02",  airAlarmMin: air_min_NO,        airAlarmMax: air_max_NO,        airUnit:"mg/Nm\u00B3",  airAlarmTurnOn: air_status_NO       })
        listAlarm.append({airComponent: "AI03",  airAlarmMin: air_min_NOX,       airAlarmMax: air_max_NOX,       airUnit:"mg/Nm\u00B3",  airAlarmTurnOn: air_status_NOX      })
        listAlarm.append({airComponent: "AI01",  airAlarmMin: air_min_SO2,       airAlarmMax: air_max_SO2,       airUnit:"mg/Nm\u00B3",  airAlarmTurnOn: air_status_SO2      })
        listAlarm.append({airComponent: "AI05",  airAlarmMin: air_min_TEMP,      airAlarmMax: air_max_TEMP,      airUnit:"\u00B0C",      airAlarmTurnOn: air_status_TEMP     })
        listAlarm.append({airComponent: "AI06",  airAlarmMin: air_min_OPP,       airAlarmMax: air_max_OPP,       airUnit:"%",            airAlarmTurnOn: air_status_OPP      })
        listAlarm.append({airComponent: "AI07",  airAlarmMin: air_min_DUST_PM,   airAlarmMax: air_max_DUST_PM,   airUnit:"mg/Nm\u00B3",  airAlarmTurnOn: air_status_DUST_PM  })
        listAlarm.append({airComponent: "AI08",  airAlarmMin: air_min_VEL,       airAlarmMax: air_max_VEL,       airUnit:"m/s",          airAlarmTurnOn: air_status_VEL      })
        listAlarm.append({airComponent: "AI09",  airAlarmMin: air_min_FLOW,      airAlarmMax: air_max_FLOW,      airUnit:"m\u00B3/s",    airAlarmTurnOn: air_status_FLOW     })
    }

    onAir_status_O2Changed:         listAlarm.setProperty(0, "airAlarmTurnOn",  air_status_O2)
    onAir_min_O2Changed:            listAlarm.setProperty(0, "airAlarmMin",     air_min_O2)
    onAir_max_O2Changed:            listAlarm.setProperty(0, "airAlarmMax",     air_max_O2)

    onAir_status_COChanged:         listAlarm.setProperty(1, "airAlarmTurnOn",  air_status_CO)
    onAir_min_COChanged:            listAlarm.setProperty(1, "airAlarmMin",     air_min_CO)
    onAir_max_COChanged:            listAlarm.setProperty(1, "airAlarmMax",     air_max_CO)

    onAir_status_NOChanged:         listAlarm.setProperty(2, "airAlarmTurnOn",  air_status_NO)
    onAir_min_NOChanged:            listAlarm.setProperty(2, "airAlarmMin",     air_min_NO)
    onAir_max_NOChanged:            listAlarm.setProperty(2, "airAlarmMax",     air_max_NO)

    onAir_status_NOXChanged:        listAlarm.setProperty(3, "airAlarmTurnOn",  air_status_NOX)
    onAir_min_NOXChanged:           listAlarm.setProperty(3, "airAlarmMin",     air_min_NOX)
    onAir_max_NOXChanged:           listAlarm.setProperty(3, "airAlarmMax",     air_max_NOX)

    onAir_status_SO2Changed:        listAlarm.setProperty(4, "airAlarmTurnOn",  air_status_SO2)
    onAir_min_SO2Changed:           listAlarm.setProperty(4, "airAlarmMin",     air_min_SO2)
    onAir_max_SO2Changed:           listAlarm.setProperty(4, "airAlarmMax",     air_max_SO2)

    onAir_status_TEMPChanged:       listAlarm.setProperty(5, "airAlarmTurnOn",  air_status_TEMP)
    onAir_min_TEMPChanged:          listAlarm.setProperty(5, "airAlarmMin",     air_min_TEMP)
    onAir_max_TEMPChanged:          listAlarm.setProperty(5, "airAlarmMax",     air_max_TEMP)

    onAir_status_OPPChanged:        listAlarm.setProperty(6, "airAlarmTurnOn",  air_status_OPP)
    onAir_min_OPPChanged:           listAlarm.setProperty(6, "airAlarmMin",     air_min_OPP)
    onAir_max_OPPChanged:           listAlarm.setProperty(6, "airAlarmMax",     air_max_OPP)

    onAir_status_DUST_PMChanged:    listAlarm.setProperty(7, "airAlarmTurnOn",  air_status_DUST_PM)
    onAir_min_DUST_PMChanged:       listAlarm.setProperty(7, "airAlarmMin",     air_min_DUST_PM)
    onAir_max_DUST_PMChanged:       listAlarm.setProperty(7, "airAlarmMax",     air_max_DUST_PM)

    onAir_status_VELChanged:        listAlarm.setProperty(8, "airAlarmTurnOn",  air_status_VEL)
    onAir_min_VELChanged:           listAlarm.setProperty(8, "airAlarmMin",     air_min_VEL)
    onAir_max_VELChanged:           listAlarm.setProperty(8, "airAlarmMax",     air_max_VEL)

    onAir_status_FLOWChanged:       listAlarm.setProperty(9, "airAlarmTurnOn",  air_status_FLOW)
    onAir_min_FLOWChanged:          listAlarm.setProperty(9, "airAlarmMin",     air_min_FLOW)
    onAir_max_FLOWChanged:          listAlarm.setProperty(9, "airAlarmMax",     air_max_FLOW)
}
