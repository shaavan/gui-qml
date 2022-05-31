// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../controls"

Page {
    background: null
    Layout.fillWidth: true
    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 80
        anchors.rightMargin: anchors.leftMargin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        spacing: 0

        // header: RowLayout {
        //     height: 50
        //     Layout.alignment: Qt.AlignRight
        //     Layout.rightMargin: 10
        //     Loader {
        //         active: true
        //         visible: active
        //         sourceComponent: TextButton {
        //             text: "i"
        //             // onClicked: //To Be Figured out
        //         }
        //     }
        // }

        Image {
            id: btc_icon
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 50
            source: "image://images/app"
            sourceSize.width: 100
            sourceSize.height: 100
        }

        Header {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
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
            Layout.alignment: Qt.AlignVCenter
            Layout.topMargin: 76
            text: qsTr("Start")
            onClicked: swipeView.incrementCurrentIndex()
        }

    }
}
