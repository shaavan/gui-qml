// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"

ColumnLayout {
    spacing: 20
    Information {
        Layout.fillWidth: true
        header:  qsTr("Website")
        description: qsTr("bitcoincore.org >")
        link: "https://bitcoincore.org"
    }
    Information {
        Layout.fillWidth: true
        header:  qsTr("Source code")
        description: qsTr("github.com/bitcoin/bitcoin >")
        link: "https://github.com/bitcoin/bitcoin"
    }
    Information {
        Layout.fillWidth: true
        header:  qsTr("License")
        description: qsTr("MIT >")
        link: "https://opensource.org/licenses/MIT"
    }
    Information {
        last: true
        Layout.fillWidth: true
        header:  qsTr("Version")
        description: qsTr("v22.99.0-1e7564eca8a6 >")
        link: "https://bitcoin.org/en/download"
    }
}
