// Copyright (c) 2022 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <qml/chain.h>

#include <interfaces/chain.h>

ChainModel::ChainModel(interfaces::chain& chain)
    : m_chain{chain}
{
}

ChainModel::setTimeRatioList(int new_time) {
}