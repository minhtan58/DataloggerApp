import QtQuick 2.7
import QtQuick.Window 2.2
import EnumID 1.0

Window {
    visible: true
    width: QmlValues.screenWidth
    height: QmlValues.screenHeight
    maximumWidth: 1500
    minimumWidth: 1500
    minimumHeight: 900
    maximumHeight: 900

    readonly property int buttonMargin: 10
    property bool isScreenShotEnable: false

    FontLoader {
        id: fontAwesome
        name: "fontawesome"
        source: "qrc:/fontawesome-webfont.ttf"
    }

    Image {
        id: name
        anchors.fill: parent
        source: "qrc:/Ui/Images/background.png"
        z: QmlValues.backgroundZ
    }

    Loader {
        id: topBar
        objectName: "topbarContainer"
        x: 0
        y: 0
        z: QmlValues.topbarZ
        width: parent.screenWidth
        height: parent.topbarHeight
        source: "qrc:/Ui/Screen/ics_topbar.qml"
    }

    Loader {
        id: screenContainer
        //anchors.fill: parent
        x: 0
        y: QmlValues.topbarHeight
        z: QmlValues.appContainerZ
        objectName: "screenContainer"
        width: QmlValues.screenWidth
        height: QmlValues.screenHeight
    }

    Loader {
        id: overlayContainer
        objectName: "overlayContainer"
        x: 0
        y: 0
        z: QmlValues.overlayZ
        anchors.fill: parent
        width: QmlValues.screenWidth
        height: QmlValues.screenHeight
    }
}
