// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../controls"

Page {
    background: null
    clip: true
    Layout.fillWidth: true
    ColumnLayout {
        width: 600
        spacing: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        RowLayout {
            height: 50
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            // Layout.margins: 11
            Loader {
                active: true
                visible: active
                Layout.margins: 11
                // sourceComponent: TextButton {
                //     text: "i"
                //     onClicked: {
                //         introductions.incrementCurrentIndex()
                //         swipeView.inSubPage = true
                //     }
                // }
                sourceComponent: Item {
                    width: 24
                    height: 24

                    // Rectangle {
                    //     anchors.fill: parent
                    //     color: "black"
                    //     opacity: 0.2
                    //     radius: width*0.5

                    //     Image {
                    //         source: "file:///home/shaavan/Workplace/personal-fork/qml-onboarding/gui-qml/src/qml/res/icons/info.png"
                    //         anchors.fill: parent
                    //         fillMode: Image.PreserveAspectFit

                    //         MouseArea {
                    //             anchors.fill: parent
                    //             onClicked: {
                    //                 introductions.incrementCurrentIndex()
                    //                 swipeView.inSubPage = true
                    //             }
                    //         }
                    //     }
                    // }
                    Rectangle {
                        anchors.fill: parent
                        color: Theme.color.white
                        radius: width*0.5
                    }
                    Image {
                        // source: "file:///home/shaavan/Workplace/personal-fork/qml-onboarding/gui-qml/src/qml/res/icons/info.png"
                        source: "qrc:/icons/info"
                        width: parent.width
                        height: parent.height
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit
                        mipmap: true
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                introductions.incrementCurrentIndex()
                                swipeView.inSubPage = true
                            }
                        }
                    }
                }
                // sourceComponent: Item {
                //     width: 24
                //     height: 24

                //     Button {
                //         iconSource: "file://home/shaavan/Workplace/personal-fork/qml-onboarding/gui-qml/src/qml/res/icons/info.png"
                //         anchors.centerIn: parent
                        
                //         Rectangle {
                //             anchors.fill: parent
                //             color: "black"
                //             opacity: parent.hover ? 0.5: 0
                //         }

                //         onClicked: {
                //             introductions.incrementCurrentIndex()
                //             swipeView.inSubPage = true
                //         }
                //     }
                // }
            }
        }
        Image {
            Layout.alignment: Qt.AlignCenter
            source: "image://images/app"
            sourceSize.width: 100
            sourceSize.height: 100
        }
        Header {
            Layout.fillWidth: true
            implicitWidth: childrenRect.width
            bold: true
            header: qsTr("Bitcoin Core App")
            headerSize: 36
            headerMargin: 30
            description: qsTr("Be part of the Bitcoin network.")
            descriptionSize: 24
            descriptionMargin: 10
            subtext: qsTr("100% open-source & open-design")
            subtextMargin: 30
        }
        ContinueButton {
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 40
            text: "Start"
            onClicked: swipeView.incrementCurrentIndex()
        }
    }
}
