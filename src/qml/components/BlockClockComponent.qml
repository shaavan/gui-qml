import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"

StackView {
    id: clocks
    initialItem: blockClock
    anchors.fill: parent

    // BlockClock {
    //     id: connectingClock
    //     anchors.centerIn: parent
    //     progress: nodeModel.verificationProgress
    //     varList: [0, nodeModel.verificationProgress]
    //     // varList: nodeModel.blockTimeProgress
    //     remainingTime: nodeModel.remainingSyncTime

    //     onSyncChanged: clocks.push(blockClock)
    // }

    BlockClock {
        id: blockClock
        anchors.centerIn: parent
        progress: nodeModel.verificationProgress
        // varList: [0, 0.5, nodeModel.verificationProgress]
        varList: progress > 0.95 ? nodeModel.blockTimeProgress : 0
        remainingTime: nodeModel.remainingSyncTime
    }
    
}