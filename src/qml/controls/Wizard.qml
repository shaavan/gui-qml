// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: root
    property var views
    property alias finished: swipeView.finished
    background: null
    header: RowLayout {
        height: swipeView.currentIndex > 0 ? 50 : 0
        Layout.leftMargin: 10
        Loader {
            active: swipeView.currentIndex > 0 && swipeView.inSubPage === false ? true : false
            visible: active
            // sourceComponent: TextButton {
            //     text: "‹ Back"
            //     onClicked: swipeView.currentIndex -= 1
            // }
            sourceComponent: Item {
                width: 73
                height: 46

                RowLayout {
                    // anchors.centerIn: parent
                    // Layout.maximumWidth: parent.width
                    // Layout.maximumHeight: parent.height
                    // Layout.alignment: Qt.AlignVCenter
                    // Layout.topMargin: 100
                    // Layout.bottomMargin: 10
                    anchors.fill: parent
                    // anchors.centerIn: parent
                    spacing: 0
                    Image {
                        // source: "file:///home/shaavan/Workplace/personal-fork/qml-onboarding/gui-qml/src/qml/res/icons/caret-left.png"
                        source: "qrc:/icons/caret-left"
                        mipmap: true
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        Layout.alignment: Qt.AlignVCenter
                        fillMode: Image.PreserveAspectFit
                        // Rectangle {
                        //     anchors.fill: parent
                        //     color: "blue"
                        //     opacity: 0.5
                        // }
                    }
                    Text {
                        // Layout.fillHeight: true
                        // Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        // Layout.topMargin: 14
                        text: "Back"
                        color: Theme.color.neutral9
                        font.family: "Inter"
                        font.styleName: "Semi Bold"
                        font.pointSize: 18
                    }
                    // Rectangle {
                    //     anchors.fill: parent
                    //     color: "brown"
                    //     opacity: 0.2
                    // }
                }
                // Rectangle {
                //     anchors.fill: parent
                //     color: "black"
                //     opacity: 0.2
                // }
                MouseArea {
                    anchors.fill: parent
                    onClicked: swipeView.currentIndex -= 1
                }
            }
        }
    }
    SwipeView {
        id: swipeView
        property bool inSubPage: false
        property bool finished: false
        anchors.fill: parent
        interactive: false
        Repeater {
            model: views.length
            Loader {
                source: "../pages/" + views[index]
            }
        }
    }
}
