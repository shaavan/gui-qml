import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"

StackView {
    id: clocks
    initialItem: connectingClock
    anchors.fill: parent

    BlockClock {
        id: connectingClock
        anchors.centerIn: parent
        progress: nodeModel.verificationProgress
        varList: [0, nodeModel.verificationProgress]
        remainingTime: nodeModel.remainingSyncTime
    }
}