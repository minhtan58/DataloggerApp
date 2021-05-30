import QtQuick 2.7
import EnumID 1.0
import "../Widget"

Item {
    id: dataViewScreen
    objectName: "scr_dataview"
    anchors.fill: parent

    property int modeViewAir:  0
    property int modechanel2:  0
    property int modechanel3:  0
    property int modechanel3X: 0
    property int modeViewSO2:  0
    readonly property string unitAirPpm: "ppm"
    readonly property string unitAirSTD: "mg/Nm\u00B3"
    readonly property int viewX: 10
    readonly property int viewSpacing: 10

    QLeftTabView {
        currentIndex: 5
    }

    Item{
        x: 205

        QViewWidget {
            id: chanel1
            objectName: "chanel1"
            x: viewX
            y: 5
            textName: "O\u2082"
            textUnit: "%V"
            txtInterval: "60s"
        }

        QViewWidget {
            id: chanel2
            objectName: "chanel2"
            x: viewX
            y: chanel1.y + chanel1.height + viewSpacing
            textName: "CO"
            textUnit: !modechanel2 ? unitAirSTD : unitAirPpm
            txtInterval: "60s"
            onViewClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_DATAVIEW_SWITCH_UNIT, 1 - modechanel2)
            }
        }

        QViewWidget {
            id: chanel3
            objectName: "chanel3"
            x: viewX
            y: chanel2.y + chanel2.height + viewSpacing
            textName: "NO"
            textUnit: !modechanel3 ? unitAirSTD : unitAirPpm
            txtInterval: "60s"
            onViewClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_DATAVIEW_SWITCH_UNIT, 1 - modechanel3)
            }
        }

        QViewWidget {
            id: chanel4
            objectName: "chanel4"
            x: viewX
            y: chanel3.y + chanel3.height + viewSpacing
            textName: "NOx"
            textUnit: !modechanel3X ? unitAirSTD : unitAirPpm
            txtInterval: "60s"
            onViewClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_DATAVIEW_SWITCH_UNIT, 1 - modechanel3X)
            }
        }

        QViewWidget {
            id: chanel5
            objectName: "chanel5"
            x: viewX
            y: chanel4.y + chanel4.height + viewSpacing
            textName: "SO\u2082"
            textUnit: !modeViewSO2 ? unitAirSTD : unitAirPpm
            txtInterval: "60s"
            onViewClicked: {
                UIBridge.hmiEvent(this.objectName, EnumID.HMI_DATAVIEW_SWITCH_UNIT, 1 - modeViewSO2)
            }
        }

        QViewWidget {
            id: chanel6
            objectName: "chanel6"
            x: chanel1.x + chanel1.width + viewSpacing
            y: chanel1.y
            textName: "Temperature"
            textUnit: "\u00B0C"
            txtInterval: "60s"
        }

        QViewWidget {
            id: chanel7
            objectName: "chanel7"
            x: chanel6.x
            y: chanel2.y
            textName: "Oppacity"
            textUnit: "%"
            txtInterval: "60s"
        }

        QViewWidget {
            id: chanel8
            objectName: "chanel8"
            x: chanel6.x
            y: chanel3.y
            textName: "Dust PM"
            textUnit: "mg/Nm\u00B3"
            txtInterval: "60s"
        }

        QViewWidget {
            id: chanel9
            objectName: "chanel9"
            x: chanel6.x
            y: chanel4.y
            textName: "Velocity"
            textUnit: "m/s"
            txtInterval: "60s"
        }

        QViewWidget {
            id: chanel10
            objectName: "chanel10"
            x: chanel6.x
            y: chanel5.y
            textName: "Flow"
            textUnit: "m\u00B3/s"
            txtInterval: "60s"
        }

        QViewWidget {
            id: chanel11
            objectName: "chanel11"
            x: chanel6.x + chanel6.width + viewSpacing
            y: chanel1.y
            textName: "Temperature"
            textUnit: "\u00B0C"
            txtInterval: "60s"
        }

        QViewWidget {
            id: chanel12
            objectName: "chanel12"
            x: chanel10.x + chanel6.width + viewSpacing
            y: chanel2.y
            textName: "Oppacity"
            textUnit: "%"
            txtInterval: "60s"
        }

        QViewWidget {
            id: chanel13
            objectName: "chanel13"
            x: chanel10.x + chanel6.width + viewSpacing
            y: chanel3.y
            textName: "Dust PM"
            textUnit: "mg/Nm\u00B3"
            txtInterval: "60s"
        }

        QViewWidget {
            id: chanel14
            objectName: "chanel14"
            x: chanel10.x + chanel6.width + viewSpacing
            y: chanel4.y
            textName: "Velocity"
            textUnit: "m/s"
            txtInterval: "60s"
        }

        QViewWidget {
            id: chanel15
            objectName: "chanel15"
            x: chanel10.x + chanel6.width + viewSpacing
            y: chanel5.y
            textName: "Flow"
            textUnit: "m\u00B3/s"
            txtInterval: "60s"
        }
    }
}
