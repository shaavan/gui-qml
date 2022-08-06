import QtQuick 2.15
import QtQuick.Controls 2.15
import "../controls"

Rectangle {
     width: parent.width<parent.height?parent.width:parent.height
     height: width
     color: "red"
     border.color: "black"
     border.width: 1
     radius: width*0.5
     Text {
          anchors.fill: parent
          color: "red"
          text: "Boom"
     }
}