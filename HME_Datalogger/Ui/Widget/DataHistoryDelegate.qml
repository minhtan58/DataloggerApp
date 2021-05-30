import QtQuick 2.7
import "../Widget"

Item {
    id: delegate
    width: delegate.ListView.view.width
    height: 35
    property int secSize: 11
    QText {
        id: txTime
        text: time
        width: parent.width * 1/secSize
        height: parent.height
        anchors.leftMargin: 20
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    QText {
        id: txtO2
        text: valO2
        x: txTime.width
        width: parent.width * 1/secSize
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    QText {
        id: txtCO
        text: valCO
        x: txtO2.x + txtO2.width
        width: parent.width * 1/secSize
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    QText {
        id: txtNO
        text: valNO
        x: txtCO.x + txtCO.width
        width: parent.width * 1/secSize
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    QText {
        id: txtNOX
        text: valNOX
        x: txtNO.x + txtNO.width
        width: parent.width * 1/secSize
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    QText {
        id: txtSO2
        text: valSO2
        x: txtNOX.x + txtNOX.width
        width: parent.width * 1/secSize
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    QText {
        id: txtTEMP
        text: valTEMP
        x: txtSO2.x + txtSO2.width
        width: parent.width * 1/secSize
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    QText {
        id: txtOPP
        text: valOPP
        x: txtTEMP.x + txtTEMP.width
        width: parent.width * 1/secSize
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    QText {
        id: txtDUSTPM
        text: valDUSTPM
        x: txtOPP.x + txtOPP.width
        width: parent.width * 1/secSize
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    QText {
        id: txtVEL
        text: valVEL
        x: txtDUSTPM.x + txtDUSTPM.width
        width: parent.width * 1/secSize
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    QText {
        id: txtFLOW
        text: valFLOW
        x: txtVEL.x + txtVEL.width
        width: parent.width * 1/secSize
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
    }
    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        onClicked: {
            delegate.ListView.view.currentIndex = index
        }
    }
}
