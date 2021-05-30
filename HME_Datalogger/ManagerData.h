#ifndef MANAGERDATA_H
#define MANAGERDATA_H

#include <QObject>
#include <QQuickItem>
#include <QMap>
#include <QHash>
#include <QList>
#include <QMutex>

#include "Enum.h"
#include "Structs.h"
#include "Defines.h"
#include "UIBridge.h"

class ManagerData : public QObject
{
    Q_OBJECT
public:
    explicit ManagerData(QObject *parent = nullptr);
    static ManagerData* getInstance();

    QString getData(int dpId);
    void setData(int dpid, QString value);
    QString getDataName(int dpId);

    void setHistoryDataList(const QList<CemsDataRow> &historyDataList);
    QList<CemsDataRow> getHistoryDataList() const;

private:
    static ManagerData *m_managerData;
    QHash<int, QString> m_datapool;
    QHash<int, QString> m_dpName;
    QMutex mutex;

    QList<CemsDataRow> m_historyDataList;
    void initData();

signals:
    void dataChanged(int dpid);

public slots:
};

#endif // MANAGERDATA_H
