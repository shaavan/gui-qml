// Copyright (c) 2021 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOIN_QML_NODEMODEL_H
#define BITCOIN_QML_NODEMODEL_H

#include <chain.h>

#include <interfaces/handler.h>
#include <interfaces/node.h>
#include <node/context.h>

#include <memory>

#include <QObject>
#include <QVariant>

QT_BEGIN_NAMESPACE
class QTimerEvent;
QT_END_NAMESPACE

namespace interfaces {
class Node;
}

/** Model for Bitcoin network client. */
class NodeModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int blockTipHeight READ blockTipHeight NOTIFY blockTipHeightChanged)
    Q_PROPERTY(int remainingSyncTime READ remainingSyncTime NOTIFY remainingTimeChanged)
    Q_PROPERTY(double verificationProgress READ verificationProgress NOTIFY verificationProgressChanged)
    Q_PROPERTY(QVariantList blockTimeList READ blockTimeList NOTIFY blockTimeListChanged)
    Q_PROPERTY(double currentTime READ currentTime NOTIFY currentTimeChanged)

public:
    explicit NodeModel(interfaces::Node& node);

    int blockTipHeight() const { return m_block_tip_height; }
    void setBlockTipHeight(int new_height);
    int remainingSyncTime() const { return m_remaining_time; }
    double verificationProgress() const { return m_verification_progress; }
    void setVerificationProgress(double new_progress);
    QVariantList blockTimeList() const { return m_block_time_list; }
    void setBlockTimeList(int new_block_time);
    void setBlockTimeListInitial(const CBlockIndex* pblockindex);
    double currentTime() const { return m_current_time; }
    void setCurrentTime();

    // Q_INVOKABLE double currentTime();

    Q_INVOKABLE void startNodeInitializionThread();

    void startShutdownPolling();
    void stopShutdownPolling();

public Q_SLOTS:
    void initializeResult(bool success, interfaces::BlockAndHeaderTipInfo tip_info);

Q_SIGNALS:
    void blockTipHeightChanged();
    void remainingTimeChanged();
    void requestedInitialize();
    void requestedShutdown();
    void verificationProgressChanged();
    void blockTimeListChanged();
    void currentTimeChanged();

protected:
    void timerEvent(QTimerEvent* event) override;

private:
    // Properties that are exposed to QML.
    int m_block_tip_height{0};
    int m_remaining_time{0};
    double m_verification_progress{0.0};
    QVariantList m_block_time_list{0};
    double m_current_time{0.0};

    int m_shutdown_polling_timer_id{0};

    QVector<QPair<int, double>> m_block_process_time;

    interfaces::Node& m_node;
    std::unique_ptr<interfaces::Handler> m_handler_notify_block_tip;

    void ConnectToBlockTipSignal();
};

#endif // BITCOIN_QML_NODEMODEL_H
