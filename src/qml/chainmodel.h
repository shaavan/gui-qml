// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOIN_QML_CHAIN_MODEL_H
#define BITCOIN_QML_CHAIN_MODEL_H

#include <interfaces/chain.h>

#include <QObject>
#include <QTimer>
#include <QVariant>

namespace interfaces {
class FoundBlock;
class Chain;
}

static const int SECS_IN_12_HOURS = 43200;

class ChainModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList timeRatioList READ timeRatioList NOTIFY timeRatioListChanged)

public:
    explicit ChainModel(interfaces::Chain& chain);

    QVariantList timeRatioList() const { return m_time_ratio_list; };
    void setTimeRatioList(int new_time);

    int timestampAtMeridian();
    void setTimeRatioListInitial();

    void setCurrentTimeRatio();

Q_SIGNALS:
    void timeRatioListChanged();

private:
    QVariantList m_time_ratio_list{0.0};

    QTimer *timer;

    interfaces::Chain& m_chain;
    std::unique_ptr<interfaces::Handler> m_handler_notify_block_tip;

    void ConnectToBlockTipSignal();
};

#endif // BITCOIN_QML_CHAIN_MODEL_H