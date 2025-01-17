// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"

ColumnLayout {
    spacing: 20
    Setting {
        Layout.fillWidth: true
        header: qsTr("Enable listening")
        description: qsTr("Allows incoming connections")
        actionItem: OptionSwitch {}
    }
    Setting {
        Layout.fillWidth: true
        header: qsTr("Map port using UPnP")
        actionItem: OptionSwitch {}
    }
    Setting {
        Layout.fillWidth: true
        header: qsTr("Map port using NAT-PMP")
        actionItem: OptionSwitch {}
    }
    Setting {
        Layout.fillWidth: true
        header: qsTr("Enable RPC server")
        actionItem: OptionSwitch {}
    }
    Setting {
        last: true
        Layout.fillWidth: true
        header: qsTr("Proxy settings")
        actionItem: Button {
            icon.source: "image://images/caret-right"
            icon.color: Theme.color.neutral9
            icon.height: 18
            icon.width: 18
            background: null
        }
    }
}
