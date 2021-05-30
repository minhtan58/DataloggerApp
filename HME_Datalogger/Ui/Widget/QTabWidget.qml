import QtQuick 2.7

Item {
    id: tabWidget
    objectName:  "tabWidget"

    default property alias content: stack.children

    property int current: 0

    onCurrentChanged: setVisibles()
    Component.onCompleted: setVisibles()

    function setVisibles() {
        for (var i = 0; i < stack.children.length; ++i) {
            stack.children[i].visible = (i === current)
        }
    }

    Row {
        id: header

        Repeater {
            model: stack.children.length
            delegate: Item {
                id: tabDelegate
                width: tabWidget.width / stack.children.length
                height: 50
                clip: true

                Rectangle {
                    anchors.fill: parent
                    anchors.bottomMargin: 1
//                    color: index == current ? "steelblue" : "black"
                    opacity: 0.8
                    clip: true
                    border.color: "steelblue"
                    border.width: index == current ? 2 : 0
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: index == current ? "#6a9bc3" : "black" }
                        GradientStop { position: 0.4; color: "#1c3448" }
                        GradientStop { position: 0.6; color: "#1c3448" }
                        GradientStop { position: 1.0; color: index == current ? "#6a9bc3" : "black" }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 1
                    color: "gray"
                    opacity: 1
                }

                Text {
                    anchors.fill: parent
                    text: stack.children[index].title
                    elide: Text.ElideRight
                    font.bold: tabWidget.current == index
                    color: "#ffffff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                    wrapMode: Text.Wrap
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: tabWidget.current = index
                }
            }
        }
    }

    Item {
        id: stack
        width: tabWidget.width
        anchors.top: header.bottom
        anchors.bottom: tabWidget.bottom
    }
}
