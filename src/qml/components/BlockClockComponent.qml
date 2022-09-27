import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"

BlockClock {
    id: blockClock
    anchors.centerIn: parent
    synced: nodeModel.verificationProgress > 0.99

    states: [
        State {
            name: "connectingClock"; when: !synced
            PropertyChanges {
                target: blockClock

                ringProgress: nodeModel.verificationProgress
                header: Math.round(ringProgress * 100) + "%"
                subText: Math.round(nodeModel.remainingSyncTime/60000) > 0 ? Math.round(nodeModel.remainingSyncTime/60000) + "mins" : Math.round(nodeModel.remainingSyncTime/1000) + "secs"
            }
        },

        State {
            name: "blockClock"; when: synced
            PropertyChanges {
                target: blockClock

                ringProgress: nodeModel.currentTime
                header: nodeModel.blockTipHeight
                subText: "Latest Block"
                blockList: nodeModel.blockTimeList
            }
        }
    ]
}