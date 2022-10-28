// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOIN_QML_CHAIN_MODEL_H
#define BITCOIN_QML_CHAIN_MODEL_H

#include <QObject>

namespace interfaces {
class FoundBlock;
class Chain;
}

static const SECS_IN_12_HOURS = 43200;

class ChainModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList timeRatioList READ timeRatioList NOTIFY timeRatioListChanged)

public:
    explicit ChainModel(interfaces::Chain& chain);

    QVariantList timeRatioList() const { return m_time_ratio_list; };
    void setTimeRatioList(int new_time);

    void timestampAtMeridian();

    void setTimeRatioListInitial();

Q_SIGNALS:
    void timeRatioListChanged();

private:
    QVariantList m_time_ratio_list{0};

    interfaces::Chain& m_chain;
};

#endif // BITCOIN_QML_CHAIN_MODEL_H