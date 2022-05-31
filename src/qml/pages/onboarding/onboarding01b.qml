// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../controls"
import "../../components"

Page {
    background: null
    clip: true
    Layout.fillWidth: true
    ColumnLayout {
        width: 600
        spacing: 0
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle {
            height: 50
            color: "transparent"
        }
        Header {
            Layout.fillWidth: true
            bold: true
            header: "About"
            description: qsTr("Bitcoin Core is an open source project.\nIf you find it useful, please contribute.\n\n This is experimental software.")
            descriptionMargin: 20
        }
        AboutOptions {
            Layout.topMargin: 30
        }
        TextButton {
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 30
            text: "Done"
            textSize: 18
            textColor: "#F7931A"
            onClicked: {
                introductions.decrementCurrentIndex()
                swipeView.inSubPage = false
            }
        }
    }
}
