// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <qml/chainmodel.h>

#include <interfaces/chain.h>
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

    if(new_time < timeAtMeridian) {
        return;
    }

    m_time_ratio_list.push_back(double(new_time - timeAtMeridian) / SECS_IN_12_HOURS);

    // for(int i=0; i < m_time_ratio_list.size(); i++) {
    //     std::cout<<m_time_ratio_list[i].toDouble()<<" ";
    // }
    // std::cout<<"\n\n";

    Q_EMIT timeRatioListChanged();
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
    // // int64_t time1;
    // uint256 hash1;
    // uint256 hash2;
    // hash2.SetHex("00000008819873e925422c1ff0f99f7cc9bbb232af63a077a480a3633bee1ef6");
    // // interfaces::FoundBlock block1;
    // interfaces::FoundBlock block = interfaces::FoundBlock().hash(hash1);
    // interfaces::FoundBlock block2 = block;
    bool success = m_chain.findFirstBlockWithTimeAndHeight(/*min_time=*/0, /*min_height=*/0, block);

    // bool success2 = m_chain.findBlock(hash2, block2);

    // if(!success2) {
    //     std::cout<<"There was a failure\n";
    // }

    // if(block2.m_time == nullptr) {
    //     std::cout<<"The problem persists\n";
    // }

    // std::cout<<*block2.m_time<<"\n";

    if(!success) {
        return;
    }

    m_time_ratio_list.clear();
    m_time_ratio_list.push_back(double(QDateTime::currentSecsSinceEpoch() - timeAtMeridian) / SECS_IN_12_HOURS);

    auto height = m_chain.getHeight();

    std::cout<<"Current Chain Height: "<<height.value()<<"\n";
    // std::cout<<"Block Time is: "<<*block.m_time<<"\n";
    std::cout<<"Block Hash is: "<<hash1.ToString()<<"\n";

    // std::cout<<"Current Secs since epoch "<<QDateTime::currentSecsSinceEpoch()<<"\n"; // Working correctly
    // std::cout<<"Time at meridian "<<timeAtMeridian<<"\n"; // Working correctly

    if(block.m_next_block == nullptr) {
        std::cout<<"Next Block is null \n";
    }

    // std::cout<<"Block hash "<<block.m_hash<<"\n";

    while (block.m_next_block != nullptr) {
        m_time_ratio_list.push_back(double(*block.m_time - timeAtMeridian) / SECS_IN_12_HOURS);
        block = *block.m_next_block;
    }

    // for(int i=0; i < m_time_ratio_list.size(); i++) {
    //     std::cout<<m_time_ratio_list[i].toDouble()<<" ";
    // }
    // std::cout<<"\n";

    Q_EMIT timeRatioListChanged();
}

void ChainModel::setCurrentTimeRatio()
{
    int secsSinceMeridian = (QTime::currentTime().msecsSinceStartOfDay() / 1000) % SECS_IN_12_HOURS;
    double currentTimeRatio = double(secsSinceMeridian) / SECS_IN_12_HOURS;

    if (currentTimeRatio < m_time_ratio_list[0].toDouble()) { //That means time has crossed a meridian
        m_time_ratio_list.erase(m_time_ratio_list.begin() + 1, m_time_ratio_list.end());
    }
    m_time_ratio_list[0] = currentTimeRatio;

    // for(int i=0; i < m_time_ratio_list.size(); i++) {
    //     std::cout<<m_time_ratio_list[i].toDouble()<<" ";
    // }
    // std::cout<<"\n\n";
}