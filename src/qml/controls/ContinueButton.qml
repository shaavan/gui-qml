// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    font.family: "Inter"
    font.styleName: "Semi Bold"
    font.pixelSize: 18
    contentItem: Text {
        text: parent.text
        font: parent.font
        color: Theme.color.white
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        implicitHeight: 46
        implicitWidth: 300
        color: Theme.color.orange
        radius: 5
    }
}
