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
        // progress: nodeModel.verificationProgress
        // remainingTime: nodeModel.remainingSyncTime
        // blockList: nodeModel.blockTimeList
        // Timer {
        //     interval: 1000; running: true; repeat: true
        //     onTriggered: connectingClock.progress = nodeModel.currentTime()
        // }

        states: [
            State {
                name: "connectingClock"; when: nodeModel.verificationProgress < 0.99
                PropertyChanges {
                    target: blockClock
                    progress: nodeModel.verificationProgress
                    remainingTime: nodeModel.remainingSyncTime
                    blockList: []
                }
            },

            State {
                name: "blockClock"; when: nodeModel.verificationProgress >= 0.99
                PropertyChanges {
                    target: blockClock
                    progress: nodeModel.blockTipHeight
                    remainingTime: -1
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
    //         onTriggered: connectingClock.progress = nodeModel.currentTime()
    //     }
    // }
// }