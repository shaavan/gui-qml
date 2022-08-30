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
        // progress: nodeModel.currentTime
        remainingTime: nodeModel.remainingSyncTime
        blockList: nodeModel.blockTimeList
    }
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: connectingClock.progress = nodeModel.currentTime()
    }
}