import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Switch {
  id: control

  property bool enabled: true
  signal clicked
  checked: false

  indicator: Rectangle {
    implicitHeight: 18
    implicitWidth: 48

    border.color: control.enabled
      ? (
        control.checked
          ? '#000000'
          : '#000000'
      ) : '#000000'

    color: control.enabled
      ? (
        control.checked
          ? '#000000'
          : '#000000'
      ) : '#000000'

    radius: 10
    x: control.leftPadding
    y: parent.height / 2 - height / 2

    Rectangle {
      id: sphere

      height: 22
      width: 22

      anchors.verticalCenter: parent.verticalCenter

      border.color: control.enabled
        ?
          (
          control.checked
            ? (
              control.down
                ? '#000000'
                : '#000000'
            ) : '#000000'
        ) : '#000000'

      color: control.enabled
        ?
          (
          control.down
            ? '#000000'
            : '#000000'
        ) : '#000000'

      radius: width / 2

      // -----------------------------------------------------------------------

      states: State {
        when: control.checked

        PropertyChanges {
          target: sphere
          x: parent.width - width
        }
      }

      transitions: Transition {
        NumberAnimation {
          properties: 'x'

          duration: 200
          easing.type: Easing.InOutQuad
        }
      }
    }
  }

  // ---------------------------------------------------------------------------

  MouseArea {
    anchors.fill: parent

    onClicked: control.enabled && control.clicked()
    onPressed: control.enabled && control.forceActiveFocus()
  }
}
