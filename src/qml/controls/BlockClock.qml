import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    Layout.alignment: Qt.AlignCenter
    width: size
    height: size

    property real progress: 0
    property int remainingTime: 0

    property int size: 200
    property real arcBegin: 0
    property real arcEnd: progress * 360
    property real lineWidth: 4
    property string colorCircle: "#f1d54a"
    property string colorBackground: Theme.color.neutral2

    property variant blockList

    property alias beginAnimation: animationArcBegin.enabled
    property alias endAnimation: animationArcEnd.enabled

    property int animationDuration: 250

    onArcBeginChanged: canvas.requestPaint()
    onArcEndChanged: canvas.requestPaint()
    onBlockListChanged: canvas.requestPaint()

    Behavior on arcBegin {
       id: animationArcBegin
       enabled: true
       NumberAnimation {
           duration: root.animationDuration
           easing.type: Easing.InOutCubic
       }
    }
    
    Behavior on arcEnd {
       id: animationArcEnd
       enabled: true
       NumberAnimation {
            easing.type: Easing.Bezier
            easing.bezierCurve: [0.5, 0.0, 0.2, 1, 1, 1]
            duration: root.animationDuration
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

            // Paint background
            ctx.beginPath();
            ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
            ctx.lineWidth = root.lineWidth
            ctx.strokeStyle = root.colorBackground
            ctx.stroke()

            // Paint foreground arc
            ctx.beginPath();
            ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, end, false)
            ctx.lineWidth = root.lineWidth
            ctx.strokeStyle = root.colorCircle
            ctx.stroke()

            // Paint Block time points
            for(var i=0; i<blockList.length; i++) {
                var starts = Math.PI * ((parent.blockList[i] - 0.005) * 360 / 180)
                var ends = Math.PI * ((parent.blockList[i] + 0.005) * 360 / 180)

                ctx.beginPath();
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, starts, ends, false)
                ctx.lineWidth = root.lineWidth
                ctx.strokeStyle = "black";
                ctx.stroke()
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: root
        Image {
            Layout.alignment: Qt.AlignCenter
            source: "image://images/app"
            sourceSize.width: 30
            sourceSize.height: 30
            Layout.bottomMargin: 15
        }
        Text {
            Layout.alignment: Qt.AlignCenter
            text: Math.round(root.progress * 100) + "%"
            font.family: "Inter"
            font.styleName: "Semi Bold"
            color: Theme.color.neutral9
            font.pixelSize: 32
        }
        Text {
            Layout.alignment: Qt.AlignCenter
            text: Math.round(root.remainingTime/60000) > 0 ? Math.round(root.remainingTime/60000) + "mins" : Math.round(root.remainingTime/1000) + "secs"
            font.family: "Inter"
            font.styleName: "Semi Bold"
            font.pixelSize: 18
            color: Theme.color.neutral4
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
                    color: Theme.color.neutral9
                }
            }
        }
    }
}
