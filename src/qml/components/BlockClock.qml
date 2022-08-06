import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    anchors.centerIn: parent
    width: 200
    height: width
    border.color: "#333333"
    border.width: 4
    radius: width*0.5
    
    ColumnLayout {
        anchors.centerIn: parent
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