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
      spacing: 0

      Image {
        Layout.alignment: Qt.AlignVCenter
        Layout.topMargin: 50
        source: "image://images/app"
        sourceSize.width: 100
        sourceSize.height: souceSize.width
      }

      Header {
        Layout.fillWidth: true
        implicitWidth
      }

    }
}
// Dummy Change
