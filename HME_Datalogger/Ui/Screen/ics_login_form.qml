import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import EnumID 1.0
import "../Widget/"
import "backend.js" as Backend

Item {
    id: loginPage

    property color backGroundColor : "#394454"
    property color mainAppColor: "#6fda9c"
    property color mainTextCOlor: "#f0f0f0"
    property color popupBackGroundColor: "#b44"
    property color popupTextCOlor: "#ffffff"

    Rectangle {
        anchors.fill: parent
        //color: backGroundColor
        color: "#315b7d"
        opacity: 0.6
    }

    Text {
        x: 680
        y: 100
        id: icontext
        text: qsTr("\uf169")
        font.pointSize: 112
        font.family: "fontawesome"
        color: mainAppColor
    }

    TextField {
        id: loginUsername
        x: 570
        y: 300
        placeholderText: qsTr("User name")
        color: mainTextCOlor
        font.pointSize: 14
        font.family: "fontawesome"
        leftPadding: 30
        background: Rectangle {
            implicitWidth: 350
            implicitHeight: 50
            radius: implicitHeight / 2
            color: "transparent"

            Text {
                text: "\uf007"
                font.pointSize: 14
                font.family: "fontawesome"
                color: mainAppColor
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 10
            }

            Rectangle {
                width: parent.width - 10
                height: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                color: mainAppColor
            }
        }
    }

    TextField {
        id: loginPassword
        x: 570
        y: 365
        placeholderText: qsTr("Password")
        color: mainTextCOlor
        font.pointSize: 14
        font.family: "fontawesome"
        leftPadding: 30
        echoMode: TextField.PasswordEchoOnEdit
        background: Rectangle {
            implicitWidth: 350
            implicitHeight: 50
            radius: implicitHeight / 2
            color: "transparent"
            Text {
                text: "\uf023"
                font.pointSize: 14
                font.family: "fontawesome"
                color: mainAppColor
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 10
            }

            Rectangle {
                width: parent.width - 10
                height: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                color: mainAppColor
            }
        }
    }

    CButton{
        x: 570
        y: 450
        width: 350
        height: 50
        name: "Log In"
        baseColor: mainAppColor
        borderColor: mainAppColor
        onClicked: {
            loginUser(loginUsername.text, loginPassword.text)
        }
    }

    CButton{
        x: 570
        y: 515
        width: 350
        height: 50
        name: "Sign Up"
        baseColor: "transparent"
        borderColor: mainAppColor
        onClicked: stackView.push("qrc:/RegisterScreen.qml", {"uname": "arun", "pword": "some"}) //registerClicked()
    }

    Text {
        id: name
        x: 675
        y: 580
        width: 350
        height: 50
        text: '<html><style type="text/css"></style><a href="http://google.com">Forgot password?</a></html>' //qsTr("Forgot password?")
        linkColor: mainTextCOlor
        Layout.alignment: Qt.AlignHCenter
        font.pointSize: 14
        color: mainTextCOlor
        Layout.margins: 10
        onLinkActivated: UIBridge.hmiEvent("", EnumID.HMI_HOME_SCREEN, "")
    }
}
