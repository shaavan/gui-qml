// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Control {
    id: root
    property bool last: parent && root === parent.children[parent.children.length - 1]
    required property string header
    property string subtext
    property int subtextMargin: 3
    property string description
    property int descriptionMargin: 10
    property int descriptionSize: 18
    property bool isReadonly: true
    property bool hasIcon: false
    property string iconSource
    property int iconWidth: 30
    property string link
    contentItem: ColumnLayout {
        spacing: 20
        width: parent.width
        RowLayout {
            Header {
                Layout.fillWidth: true
                center: false
                header: root.header
                headerSize: 18
                description: root.subtext
                descriptionSize: 15
                descriptionMargin: root.subtextMargin
                wrap: false
            }
            Loader {
                Layout.fillWidth: true
                Layout.preferredWidth: 0
                Layout.rightMargin: 12
                active: root.description.length > 0
                visible: active
                sourceComponent: TextEdit {
                    topPadding: root.descriptionMargin
                    font.family: "Inter"
                    font.styleName: "Regular"
                    font.pointSize: root.descriptionSize
                    color: Theme.color.neutral8
                    textFormat: Text.RichText
                    text: "<style>a:link { color: " + Theme.color.neutral8 + "; text-decoration: none;}</style>" + "<a href=\"" + link + "\">" + root.description + "</a>"
                    readOnly: isReadonly
                    onLinkActivated: Qt.openUrlExternally(link)
                    horizontalAlignment: Text.AlignRight
                    wrapMode: Text.WordWrap
                }
            }
            Loader {
                Layout.preferredWidth: root.iconWidth
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 12
                active: root.hasIcon
                visible: active
                sourceComponent: Image {
                    horizontalAlignment: Image.AlignRight
                    fillMode: Image.PreserveAspectFit
                    // topPadding: root.descriptionMargin
                    // font.family: "Inter"
                    // font.styleName: "Regular"
                    // font.pointSize: root.descriptionSize
                    // color: Theme.color.neutral8
                    // textFormat: Text.RichText
                    source: root.iconSource
                    mipmap: true
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Qt.openUrlExternally(link)
                        }
                    }
                    // width: root.iconWidth
                    // height: root.iconHeight
                    // text: "<style>a:link { color: " + Theme.color.neutral8 + "; text-decoration: none;}</style>" + "<a href=\"" + link + "\">" + "<img src=\"" + root.iconSource + "\" width=\"" + root.iconWidth + "\" height=\"" + root.iconHeight + "\">" + "</a>"
                    // readOnly: isReadonly
                    // onLinkActivated: Qt.openUrlExternally(link)
                    // wrapMode: Text.WordWrap
                }
            }
        }
        Loader {
            Layout.fillWidth:true
            Layout.columnSpan: 2
            active: !last
            visible: active
            sourceComponent: Rectangle {
                height: 1
                color: Theme.color.neutral5
            }
        }
    }
}
