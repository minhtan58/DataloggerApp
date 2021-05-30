#ifndef HISTORYDATA_H
#define HISTORYDATA_H

#include <QObject>
#include <Defines.h>
#include <QThread>
#include <QAbstractListModel>
#include <QVariant>

#include "Enum.h"
#include "ManagerData.h"

/*****************************************Element*****************************************/
class HistoryDataElement {
public:
    HistoryDataElement(QString id, QString time, QString data1, QString data2, QString data3) {
        m_id = id;
        m_time = time;
        m_data1 = data1;
        m_data2 = data2;
        m_data2 = data3;
    }
    DECLARE_VAR(QString, id)
    DECLARE_VAR(QString, time)
    DECLARE_VAR(QString, data1)
    DECLARE_VAR(QString, data2)
    DECLARE_VAR(QString, data3)
};

/*****************************************Feeder*****************************************/
class HistoryDataFeeder : public QThread {
    Q_OBJECT
public:
    explicit HistoryDataFeeder(QList<HistoryDataElement*> *listModel, QObject *parent = nullptr)
        : QThread(parent)
        , m_listModel(listModel)
        {}
signals:
    void signalUpdateFetchDataStatus(int status);

protected:
    void run();

private:
    QList<HistoryDataElement*> *m_listModel = nullptr;
};

/*****************************************Model*******************************************/
class HistoryDataModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum LoginHistoryEnum {
        ID,
        TIME,
        DATA1,
        DATA2,
        DATA3,
    };

    explicit HistoryDataModel(QObject *parent = nullptr);
    ~HistoryDataModel();
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int,QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent) const;

    void update();

signals:
    void fetchDataStarting();
    void fetchDataFinished();
    void terminateFetchData();

public slots:
    void slotUpdateFetchDataStatus(int status);
    void fetchData();

private:
    QList<HistoryDataElement*> *m_listElement;
    HistoryDataFeeder *m_feeder;
};

#endif // HISTORYDATA_H
