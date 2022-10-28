// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <qml/chain.h>

#include <interfaces/chain.h>

#include <QDateTime>
#include <QTime>

ChainModel::ChainModel(interfaces::Chain& chain)
    : m_chain{chain}
{
}

void ChainModel::setTimeRatioList(int new_time)
{
}

int ChainModel::timestampAtMerdian()
{
    int secsSinceMeridian = (QTime::msecsSinceStartOfDay() / 1000) % SECS_IN_12_HOURS;
    int currentTimestamp = QDateTime::currentSecsSinceEpoch();

    return timeAtMeridian = currenTimestamp - secsSinceMeridian;
}

void setTimeRatioListInitial()
{
    timeAtMeridian = timestampAtMeridian()
    interfaces::FoundBlock block;
    bool success = m_chain.findFirstBlockWithTimeAndHeight(/*min_time=*/timeAtMeridian, /*min_height=*/0, block);

    if(!success) {
        return;
    }

    m_time_ratio_list.clear();
    m_time_ratio_list.push_back((QDateTime::currentSecsSinceEpoch() - timeAtMeridian) / (double)SECS_IN_12_HOURS);

    while (block.m_next_block != nullptr) {
        m_time_ratio_list.push_back((block.m_time - timeAtMeridian) / (double)SECS_IN_12_HOURS);
        block = block.m_next_block;
    }

    Q_EMIT timeRatioListChanged();
}