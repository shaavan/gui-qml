import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    anchors.centerIn: parent
    width: size
    height: size

    property int size: 200               // The size of the circle in pixel
    property real arcBegin: 0            // start arc angle in degree
    property real arcEnd: 200            // end arc angle in degree
    property bool showBackground: true  // a full circle as a background of the arc
    property real lineWidth: 4          // width of the line
    property string colorCircle: "#f1d54a"
    property string colorBackground: "#333333"

    property alias endAnimation: animationArcEnd.enabled

    property int animationDuration: 200

    onArcBeginChanged: canvas.requestPaint()
    onArcEndChanged: canvas.requestPaint()

    Behavior on arcEnd {
       id: animationArcEnd
       enabled: true
       NumberAnimation {
           duration: root.animationDuration
           easing.type: Easing.InOutCubic
       }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: -90

        onPaint: {
            var ctx = getContext("2d")
            var x = width / 2
            var y = height / 2
            var start = Math.PI * (parent.arcBegin / 180)
            var end = Math.PI * (parent.arcEnd / 180)
            ctx.reset()

            if (root.showBackground) {
                ctx.beginPath();
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
                ctx.lineWidth = root.lineWidth
                ctx.strokeStyle = root.colorBackground
                ctx.stroke()
            }

            ctx.beginPath();
            ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, end, false)
            ctx.lineWidth = root.lineWidth
            ctx.strokeStyle = root.colorCircle
            ctx.stroke()
        }
    }
    
    ColumnLayout {
        anchors.centerIn: root
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            width: 30
            height: width
            color: "yellow"
            radius: width * 0.5
            Layout.bottomMargin: 15
        }
        Text {
            Layout.alignment: Qt.AlignCenter
            text: "343,754"
            font.family: "Inter"
            font.pixelSize: 32
        }
        Text {
            Layout.alignment: Qt.AlignCenter
            text: "BlockTime"
            font.family: "Inter"
            font.pixelSize: 18
            color: "#808080"
            Layout.bottomMargin: 20
        }
        RowLayout {
            Layout.alignment: Qt.AlignCenter
            spacing: 5
            Repeater {
                model: 5
                Rectangle {
                    width: 3
                    height: width
                    color: "#808080"
                }
            }
        } 
    }
}