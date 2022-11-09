// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <qml/chainmodel.h>

#include <QDateTime>
#include <QTime>
#include <QThread>

ChainModel::ChainModel(interfaces::Chain& chain)
    : m_chain{chain}
{
    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &ChainModel::setCurrentTimeRatio);
    timer->start(1000);

    QThread *timer_thread = new QThread;
    timer->moveToThread(timer_thread);
    timer_thread->start();
}

void ChainModel::setTimeRatioList(int new_time)
{
    int timeAtMeridian = timestampAtMeridian();

    m_time_ratio_list.push_back(double(new_time - timeAtMeridian) / SECS_IN_12_HOURS);
}

int ChainModel::timestampAtMeridian()
{
    int secsSinceMeridian = (QTime::currentTime().msecsSinceStartOfDay() / 1000) % SECS_IN_12_HOURS;
    int currentTimestamp = QDateTime::currentSecsSinceEpoch();

    return currentTimestamp - secsSinceMeridian;
}

void ChainModel::setTimeRatioListInitial()
{
    int timeAtMeridian = timestampAtMeridian();
    interfaces::FoundBlock block;
    bool success = m_chain.findFirstBlockWithTimeAndHeight(/*min_time=*/timeAtMeridian, /*min_height=*/0, block);

    if(!success) {
        return;
    }

    m_time_ratio_list.clear();
    m_time_ratio_list.push_back(double(QDateTime::currentSecsSinceEpoch() - timeAtMeridian) / SECS_IN_12_HOURS);

    while (block.m_next_block != nullptr) {
        m_time_ratio_list.push_back(double(*block.m_time - timeAtMeridian) / SECS_IN_12_HOURS);
        block = *block.m_next_block;
    }

    Q_EMIT timeRatioListChanged();
}

void ChainModel::setCurrentTimeRatio()
{
    int secsSinceMeridian = (QTime::currentTime().msecsSinceStartOfDay() / 1000) % SECS_IN_12_HOURS;
    int currentTimeRatio = double(secsSinceMeridian) / SECS_IN_12_HOURS;

    if (currentTimeRatio < m_time_ratio_list[0].toDouble()) { //That means time has crossed a meridian
        m_time_ratio_list.erase(m_time_ratio_list.begin() + 1, m_time_ratio_list.end());
    }
    m_time_ratio_list[0] = currentTimeRatio;
}

void ChainModel::initializeResult([[maybe_unused]] bool success, [[maybe_unused]]interfaces::BlockAndHeaderTipInfo tip_info)
{
    setTimeRatioListInitial();
}

void ChainModel::ConnectToBlockTipSignal()
{
    assert(!m_handler_notify_block_tip);

    m_handler_notify_block_tip = m_node.handleNotifyBlockTip(
        [this](SynchronizationState state, interfaces::BlockTip tip, double verification_progress) {
            QMetaObject::invokeMethod(this, [=] {
                setTimeRatioList(tip.block_time);
            });
        });
}