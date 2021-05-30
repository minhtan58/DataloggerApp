import QtQuick 2.7
import EnumID 1.0
import "../Widget"

Item {
    objectName: "scr_history_dataview"
    width: 820
    height: 460

    QText {
        text: "Select Date: "
        width: 120
        x: 20
        y: 15
    }

    QDatePicker {
        id: dateSelected
        objectName: "dateSelected"
        x: 150
        y: 15
        width: 290
        height: 35
        z: 1
    }

    QButton {
        x: 460
        y: 15
        height: 35
        width: 150
        text: "View"
        eventID: EnumID.HMI_REQUEST_GET_HISTORY_DATA
        eventParams: dateSelected.datetime
    }

    QButton {
        x: 630
        y: 15
        height: 35
        width: 150
        eventID: EnumID.HMI_REQUEST_SHOW_EXPORT_POPUP
        text: "Export"
    }

    Image {
        x: 600
        y: 600
        width: 120
        height: 68
        source: mouseHome.containsMouse ? "qrc:/Ui/Images/backspace_normal.png" : "qrc:/Ui/Images/backspace_press.png"

        MouseArea {
            id: mouseHome
            anchors.fill: parent
            onClicked: UIBridge.hmiEvent("", EnumID.HMI_HOME_SCREEN, "")
        }
    }

    Loader {
        id: lvLoader
        asynchronous: true
    }


    Component {
        id: historyDataListview

        QListView {
            x: 20
            y: 60
            width: 760
            height: 330
            model: listHistory
            emptyText: "No Data"
            delegate: DataHistoryDelegate {}
            header: Item {
                width: parent.width
                height: 35
                z: 2
                property int secSize: 11
                QText {
                    id: txTime
                    text: "Time"
                    width: parent.width * 1/secSize
                    height: parent.height
                    anchors.leftMargin: 20
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
                QText {
                    id: txtO2
                    text: "O2"
                    x: txTime.width
                    width: parent.width * 1/secSize
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
                QText {
                    id: txtCO
                    text: "CO"
                    x: txtO2.x + txtO2.width
                    width: parent.width * 1/secSize
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
                QText {
                    id: txtNO
                    text: "NO"
                    x: txtCO.x + txtCO.width
                    width: parent.width * 1/secSize
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
                QText {
                    id: txtNOX
                    text: "NOx"
                    x: txtNO.x + txtNO.width
                    width: parent.width * 1/secSize
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
                QText {
                    id: txtSO2
                    text: "SO2"
                    x: txtNOX.x + txtNOX.width
                    width: parent.width * 1/secSize
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
                QText {
                    id: txtTEMP
                    text: "Temp"
                    x: txtSO2.x + txtSO2.width
                    width: parent.width * 1/secSize
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
                QText {
                    id: txtOPP
                    text: "Opp"
                    x: txtTEMP.x + txtTEMP.width
                    width: parent.width * 1/secSize
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
                QText {
                    id: txtDUSTPM
                    text: "DustPM"
                    x: txtOPP.x + txtOPP.width
                    width: parent.width * 1/secSize
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
                QText {
                    id: txtVEL
                    text: "Vel"
                    x: txtDUSTPM.x + txtDUSTPM.width
                    width: parent.width * 1/secSize
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
                QText {
                    id: txtFLOW
                    text: "Flow"
                    x: txtVEL.x + txtVEL.width
                    width: parent.width * 1/secSize
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    backgroundColor: "steelblue"
                    font.bold: true
                }
            }
        }
    }

    Component.onCompleted: {
        lvLoader.sourceComponent = historyDataListview
        UIBridge.hmiEvent(this.objectName,
                          EnumID.HMI_REQUEST_GET_HISTORY_DATA,
                          UIBridge.getDPData(EnumID.DP_SEARCH_TIME_HISTORY_DATA))
    }
}

