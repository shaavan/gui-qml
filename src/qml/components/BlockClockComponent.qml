import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"

// StackView {
//     id: clocks
//     initialItem: connectingClock
//     anchors.fill: parent

    BlockClock {
        id: blockClock
        anchors.centerIn: parent
        synced: nodeModel.verificationProgress > 0.99
        // progress: nodeModel.verificationProgress
        // remainingTime: nodeModel.remainingSyncTime
        // blockList: nodeModel.blockTimeList
        // Timer {
        //     interval: 1000; running: true; repeat: true
        //     onTriggered: connectingClock.progress = nodeModel.currentTimeRatio()
        // }

        states: [
            State {
                name: "connectingClock"; when: !synced
                PropertyChanges {
                    target: blockClock
                    // progress: nodeModel.verificationProgress
                    // remainingTime: nodeModel.remainingSyncTime

                    ringProgress: nodeModel.verificationProgress
                    header: Math.round(ringProgress * 100) + "%"
                    subText: Math.round(nodeModel.remainingSyncTime/60000) > 0 ? Math.round(nodeModel.remainingSyncTime/60000) + "mins" : Math.round(nodeModel.remainingSyncTime/1000) + "secs" 
                }
            },

            State {
                name: "blockClock"; when: synced
                PropertyChanges {
                    target: blockClock
                    // progress: nodeModel.currentTime
                    // remainingTime: -1
                    

                    ringProgress: nodeModel.currentTime
                    header: nodeModel.blockTipHeight
                    subText: "Latest Block"
                    blockList: nodeModel.blockTimeList
                }
            }
        ]
    }

    // BlockClock {
    //     id: connectingClock
    //     anchors.centerIn: parent
    //     // progress: nodeModel.currentTime
    //     remainingTime: nodeModel.remainingSyncTime
    //     blockList: nodeModel.blockTimeList
    //     Timer {
    //         interval: 1000; running: true; repeat: true
    //         onTriggered: connectingClock.progress = nodeModel.currentTimeRatio()
    //     }
    // }
// }