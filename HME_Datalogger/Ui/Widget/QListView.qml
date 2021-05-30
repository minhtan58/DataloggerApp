import QtQuick 2.7

ListView {
    id: listView
    anchors.margins: 5
    highlight: Rectangle {color: "steelblue"; radius: 5; opacity: 0.5 }
    highlightResizeDuration: 100
    highlightMoveDuration: 300
    highlightFollowsCurrentItem: true
    clip: true
    headerPositioning: ListView.OverlayHeader
    property string loadingText: "Loading..."
    property string emptyText: ""

    Connections {
        target: listView.model
        onFetchDataStarting: {
            txtEmpty.text = loadingText
        }
        onFetchDataFinished: {
            txtEmpty.text = emptyText
            if(listView.count)
                currentIndex = 0
        }
    }

    Rectangle {
        anchors.fill: parent
        border.width: 1
        border.color: "green"
        color: "#000000"
        opacity: 0.5
        z: -1
    }

    QText {
        id: txtEmpty
        anchors.centerIn: parent
        text: emptyText
        visible: !listView.count
    }

    Item {
        id: flickScroll
        width: 6
        height: listView.height
        x: listView.x + listView.width - flickScroll.width
        y: listView.y

        Rectangle {
            radius: 5
            color: "#000000"
            opacity: 0.3
            border.color: "#FFFFFF"
            border.width: 2
            x: 0
            y: {
                var scrollY = listView.visibleArea.yPosition * flickScroll.height
                if(scrollY < 0)
                    scrollY = 0
                else if (scrollY > listView.height - height)
                    scrollY = listView.height - height
                return scrollY
            }
            width: parent.width
            height: Math.round(flickScroll.height * listView.visibleArea.heightRatio)
            visible: height < flickScroll.height
        }
    }
}
