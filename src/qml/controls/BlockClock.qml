import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    Layout.alignment: Qt.AlignCenter
    width: size
    height: size

    // property real ringProgress: 0
    // property int remainingTime: 0
    // property string blockClockText: "Latest Block"

    property real ringProgress: 0
    property string header
    property string subText
    property bool synced

    property int size: 200
    property real arcBegin: 0
    property real arcEnd: ringProgress * 360
    property real lineWidth: 4
    property string colorCircle: "#f1d54a"
    property string colorBackground: Theme.color.neutral2

    property variant blockList: []
    property variant colorList: ["#EC5445", "#ED6E46", "#EE8847", "#EFA148", "#F0BB49", "#F1D54A"]

    property alias beginAnimation: animationArcBegin.enabled
    property alias endAnimation: animationArcEnd.enabled

    property int animationDuration: 250

    onArcBeginChanged: canvas.requestPaint()
    onArcEndChanged: canvas.requestPaint()
    onSyncedChanged: canvas.requestPaint()
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
            // var start = Math.PI * (parent.arcBegin / 180)
            // var end = Math.PI * (parent.arcEnd / 180)
            ctx.reset()

            // Paint background
            ctx.beginPath();
            ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
            ctx.lineWidth = root.lineWidth
            ctx.strokeStyle = root.colorBackground
            ctx.stroke()

            if (!synced) {
                var start = Math.PI * (parent.arcBegin / 180)
                var end = Math.PI * (parent.arcEnd / 180)
                // Paint foreground arc
                ctx.beginPath();
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, end, false)
                ctx.lineWidth = root.lineWidth
                ctx.strokeStyle = root.colorCircle
                ctx.stroke()
            }

            // // Paint foreground arc
            // ctx.beginPath();
            // ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, end, false)
            // ctx.lineWidth = root.lineWidth
            // ctx.strokeStyle = root.colorCircle
            // ctx.stroke()

            // // Paint Block time points
            // for (var i=0; i<blockList.length; i++) {
            //     var starts = Math.PI * ((parent.blockList[i] - del) * 360 / 180)
            //     var ends = Math.PI * ((parent.blockList[i] + del) * 360 / 180)

            //     ctx.beginPath();
            //     ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, starts, ends, false)
            //     ctx.lineWidth = root.lineWidth
            //     ctx.strokeStyle = "black";
            //     ctx.stroke()
            // }
            else {
                var del = 0.0001
                // Paint Block time points
                for (var i=0; i<blockList.length - 1; i++) {
                    var starts = Math.PI * ((parent.blockList[i] + del) * 360 / 180)
                    var ends = Math.PI * ((parent.blockList[i + 1] - del) * 360 / 180)
                    var conf = blockList.length - i - 1
                    ctx.beginPath();
                    ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, starts, ends, false)
                    ctx.lineWidth = root.lineWidth
                    ctx.strokeStyle = conf > 5 ? colorList[5] : colorList[conf]
                    ctx.stroke()
                }

                // Print last segment
                var starts = Math.PI * ((parent.blockList[-1] + del) * 360 / 180)
                var ends = Math.PI * (ringProgress * 360 / 180)

                // ctx.beginPath();
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, starts, ends, false)
                ctx.lineWidth = root.lineWidth
                ctx.strokeStyle = colorList[0];
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
            // text: root.remainingTime > -1 ? Math.round(root.ringProgress * 100) + "%" : root.ringProgress
            text: root.header
            font.family: "Inter"
            font.styleName: "Semi Bold"
            color: Theme.color.neutral9
            font.pixelSize: 32
        }
        Text {
            Layout.alignment: Qt.AlignCenter
            // text: root.remainingTime > -1 ? Math.round(root.remainingTime/60000) > 0 ? Math.round(root.remainingTime/60000) + "mins" : Math.round(root.remainingTime/1000) + "secs" : root.blockClockText
            text: root.subText
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
