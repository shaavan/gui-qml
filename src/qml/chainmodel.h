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

public:
    explicit ChainModel(interfaces::Chain& chain);

private:
    interfaces::Chain& m_chain;
};

#endif // BITCOIN_QML_CHAIN_MODEL_H