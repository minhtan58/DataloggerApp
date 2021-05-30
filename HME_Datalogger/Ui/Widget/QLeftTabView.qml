import QtQuick 2.7
import EnumID 1.0
import "../Widget"

Item {
    id: tabHeader
    width: 205
    height: 800

    property int currentIndex: 0

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.3
        z: -1
    }

    QTabDelegate {
        id: tabOverview
        parentIndex: currentIndex
        y: 0
        tabIndex: 0
        tabContentText: "Overview"
        onTabCliked: {
            currentIndex = tabIndex
            UIBridge.hmiEvent("", EnumID.HMI_TAB_SELECT, "overview")
        }
    }

    QTabDelegate {
        id: tabGeneral
        parentIndex: currentIndex
        y: 50
        tabIndex: 1
        tabContentText: "General"
        onTabCliked: {
            currentIndex = tabIndex
            UIBridge.hmiEvent("", EnumID.HMI_TAB_SELECT, "general")
        }
    }


    QTabDelegate {
        parentIndex: currentIndex
        y: 100
        tabIndex: 2
        tabContentText: "Network"
        onTabCliked: {
            currentIndex = tabIndex
            UIBridge.hmiEvent("", EnumID.HMI_TAB_SELECT, "network")
        }
    }

    QTabDelegate {
        parentIndex: currentIndex
        y: 150
        tabIndex: 3
        tabContentText: "Serial"
        onTabCliked: {
            currentIndex = tabIndex
            UIBridge.hmiEvent("", EnumID.HMI_TAB_SELECT, "serialport")
        }
    }

    QTabDelegate {
        parentIndex: currentIndex
        y: 200
        tabIndex: 4
        tabContentText: "Serial Seting"
        onTabCliked: {
            currentIndex = tabIndex
            UIBridge.hmiEvent("", EnumID.HMI_TAB_SELECT, "alarm")
        }
    }

    QTabDelegate {
        parentIndex: currentIndex
        y: 250
        tabIndex: 5
        tabContentText: "Sensor Status"
        onTabCliked: {
            currentIndex = tabIndex
            UIBridge.hmiEvent("", EnumID.HMI_TAB_SELECT, "data")
        }
    }

    QTabDelegate {
        parentIndex: currentIndex
        y: 300
        tabIndex: 6
        tabContentText: "Syetem Setting"
        onTabCliked: {
            currentIndex = tabIndex
            UIBridge.hmiEvent("", EnumID.HMI_TAB_SELECT, "systemsetting")
        }
    }

    QTabDelegate {
        parentIndex: currentIndex
        y: 350
        tabIndex: 7
        tabContentText: "IO Setting"
        onTabCliked: {
            currentIndex = tabIndex
            UIBridge.hmiEvent("", EnumID.HMI_TAB_SELECT, "iosetting")
        }
    }

    QTabDelegate {
        parentIndex: currentIndex
        y: 400
        tabIndex: 8
        tabContentText: "Transmission"
        onTabCliked: {
            currentIndex = tabIndex
            UIBridge.hmiEvent("", EnumID.HMI_TAB_SELECT, "transmisssetting")
        }
    }
}
