// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <qml/chainmodel.h>

#include <QDateTime>
#include <QTime>

ChainModel::ChainModel(interfaces::Chain& chain)
    : m_chain{chain}
{
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