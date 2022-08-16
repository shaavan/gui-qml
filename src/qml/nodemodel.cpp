// Copyright (c) 2021 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <qml/nodemodel.h>

#include <interfaces/node.h>
#include <validation.h>

#include <cassert>
#include <chrono>

#include <QDateTime>
#include <QTimerEvent>

NodeModel::NodeModel(interfaces::Node& node)
    : m_node{node}
{
    ConnectToBlockTipSignal();
}

void NodeModel::setBlockTipHeight(int new_height)
{
    if (new_height != m_block_tip_height) {
        m_block_tip_height = new_height;
        Q_EMIT blockTipHeightChanged();
    }
}

void NodeModel::setVerificationProgress(double new_progress)
{
    QDateTime currentDate = QDateTime::currentDateTime();

    // keep a vector of samples of verification progress at height
    m_block_process_time.push_front(qMakePair(int(currentDate.toMSecsSinceEpoch()), new_progress));

    // show progress speed if we have more than one sample
    if (m_block_process_time.size() >= 2) {
        double progressDelta = 0; //
        int timeDelta = 0; //
        int remainingMSecs = 0;
        double remainingProgress = 1.0 - new_progress; //
        for (int i = 1; i < m_block_process_time.size(); i++) {
            QPair<int, double> sample = m_block_process_time[i];

            // take first sample after 500 seconds or last available one
            if (sample.first < (currentDate.toMSecsSinceEpoch() - 500 * 1000) || i == m_block_process_time.size() - 1) {
                progressDelta = m_block_process_time[0].second - sample.second;
                timeDelta = m_block_process_time[0].first - sample.first;
                remainingMSecs = (progressDelta > 0) ? remainingProgress / progressDelta * timeDelta : -1;
                break;
            }
        }
        if(remainingMSecs > 0 && m_block_process_time.count() % 1000 == 0) {
            m_remaining_time = remainingMSecs;

            Q_EMIT remainingTimeChanged();
        }
        static const int MAX_SAMPLES = 5000;
        if (m_block_process_time.count() > MAX_SAMPLES) {
            m_block_process_time.remove(1, m_block_process_time.count() - 1);
        }
    }

    if (new_progress != m_verification_progress) {
        m_verification_progress = new_progress;
        Q_EMIT verificationProgressChanged();
    }
}

void NodeModel::setBlockTimeProgress(int new_sync_time)
{
    int ms_in_12_hours = 12 * 60 * 60 * 1000;

    QVariant part_of_12_hours_passed = (new_sync_time % ms_in_12_hours)/(double)ms_in_12_hours;

    if(!m_block_12_hour_progress.empty()) {

        if (m_block_12_hour_progress.back() != part_of_12_hours_passed) { // => the new progress (in 12 hours) is not equal to last progress, that means it might be smaller than last progress

            if (m_block_12_hour_progress.back().toDouble() > part_of_12_hours_passed.toDouble()) { // If new progress is less than the old one => 12 hours have passed.
                m_block_12_hour_progress.clear(); //Clear all elements.
            }
            m_block_12_hour_progress.push_back(part_of_12_hours_passed);
            std::cout<<"Length of arr: "<<m_block_12_hour_progress.size()<<"\n";
            Q_EMIT blockTimeProgressChanged();
        }
    }
    else {
        m_block_12_hour_progress.push_back(part_of_12_hours_passed);
        Q_EMIT blockTimeProgressChanged();
    }
}

void NodeModel::startNodeInitializionThread()
{
    Q_EMIT requestedInitialize();
}

void NodeModel::initializeResult([[maybe_unused]] bool success, interfaces::BlockAndHeaderTipInfo tip_info)
{
    // TODO: Handle the `success` parameter,
    setBlockTipHeight(tip_info.block_height);
    setVerificationProgress(tip_info.verification_progress);
    setBlockTimeProgress(tip_info.block_time);
}

void NodeModel::startShutdownPolling()
{
    m_shutdown_polling_timer_id = startTimer(200ms);
}

void NodeModel::stopShutdownPolling()
{
    killTimer(m_shutdown_polling_timer_id);
}

void NodeModel::timerEvent(QTimerEvent* event)
{
    Q_UNUSED(event)
    if (m_node.shutdownRequested()) {
        stopShutdownPolling();
        Q_EMIT requestedShutdown();
    }
}

void NodeModel::ConnectToBlockTipSignal()
{
    assert(!m_handler_notify_block_tip);

    m_handler_notify_block_tip = m_node.handleNotifyBlockTip(
        [this](SynchronizationState state, interfaces::BlockTip tip, double verification_progress) {
            setBlockTipHeight(tip.block_height);
            setVerificationProgress(verification_progress);
            setBlockTimeProgress(tip.block_time);
        });
}
