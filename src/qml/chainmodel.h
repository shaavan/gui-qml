// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOIN_QML_CHAIN_MODEL_H
#define BITCOIN_QML_CHAIN_MODEL_H

#include <QObject>

namespace interfaces {
class Chain;
}

class ChainModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList timeList READ timeList NOTIFY timeListChanged)

public:
    explicit ChainModel(interfaces::Chain& chain);

    QVariantList timeList() const { return m_time_list; }
    void setTimeList(int new_time)

Q_SIGNALS:
    void timeListChanged();

private:
    QVariantList m_block_time_list{0};

    interfaces::Chain& m_chain;
};

#endif // BITCOIN_QML_CHAIN_MODEL_H