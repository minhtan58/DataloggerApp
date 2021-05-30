import QtQuick 2.7

Item { // size controlled by height
    id: root

    // public
    property string text:    'text'
    property bool   checked: false; // onCheckedChanged: print('onCheckedChanged', checked)

    signal clicked(bool checked);   // onClicked: print('onClicked', checked) // only runs via user interaction whereas checkedChanged runs via programmatic changes to checked as well

    // private
    property real padding: 0.1    // around rectangle: percent of root.height
    property bool radio:   false  // false: check box, true: radio button

    width: 250;  height: 30  // default size
    //width: rectangle.width + 3 * padding * root.height + text.width;  height: 50 // width expands with text width
    opacity: enabled? 1: 0.3 // disabled state

    Rectangle { // check box (or circle for radio button)
        id: rectangle

        height: root.height * (1 - 2 * padding);  width: height // square
        x: padding * root.height
        anchors.verticalCenter: parent.verticalCenter
        border.width: 0.05 * root.height
        radius: (radio? 0.5: 0.2) * height

        Text { // check
            visible: checked  &&  !radio
            anchors.centerIn: parent
            text: '\u2713' // http://www.fileformat.info/info/unicode/char/2713/index.htm
//            text: "√"
            font.pixelSize: parent.height
        }

        Rectangle { // radio dot
            visible: checked  &&  radio
            color: 'black'
            width: 0.5 * parent.width;  height: width // square
            anchors.centerIn: parent
            radius: 0.5 * width // circle
        }
    }

    Text {
        id: text
        text: root.text
        anchors {left: rectangle.right;  verticalCenter: rectangle.verticalCenter;  margins: padding * root.height}
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        wrapMode: Text.Wrap
    }

    MouseArea {
        anchors.fill: parent
        onPressed:  parent.opacity = 0.5 // down state
        onReleased: parent.opacity = 1
        onCanceled: parent.opacity = 1
        onClicked: {
//            if(!radio)  checked = !checked // clients of radio button must set checked to keep them all in sync
            root.clicked(checked) // emit
        }
    }
}
