/****************************************************************************

    Copyright (C) 2018 by KingKong JSC
    File: LoginHistoryListModel.h
    Create: 09
    Author: Minh Tan

 ****************************************************************************/

#ifndef LOGINHISTORYLISTMODEL_H
#define LOGINHISTORYLISTMODEL_H

#include <QObject>
#include <QThread>
#include <QAbstractListModel>
#include "Defines.h"
#include "Enum.h"
#include "Structs.h"

class HistoryDataListElement
{
public:
    HistoryDataListElement(QString time, QString valO2, QString valCO, QString valNO, QString valNOX, QString valSO2, QString valTEMP, QString valOPP, QString valDUSTPM, QString valVEL, QString valFLOW) {
        m_time = time;
        m_valO2 = valO2;
        m_valCO = valCO;
        m_valNO = valNO;
        m_valNOX = valNOX;
        m_valSO2 = valSO2;
        m_valTEMP = valTEMP;
        m_valOPP = valOPP;
        m_valDUSTPM = valDUSTPM;
        m_valVEL = valVEL;
        m_valFLOW = valFLOW;
    }

    DECLARE_VAR(QString, time)
    DECLARE_VAR(QString, valO2)
    DECLARE_VAR(QString, valCO)
    DECLARE_VAR(QString, valNO)
    DECLARE_VAR(QString, valNOX)
    DECLARE_VAR(QString, valSO2)
    DECLARE_VAR(QString, valTEMP)
    DECLARE_VAR(QString, valOPP)
    DECLARE_VAR(QString, valDUSTPM)
    DECLARE_VAR(QString, valVEL)
    DECLARE_VAR(QString, valFLOW)
};

class HistoryDataListFeeder : public QThread
{
    Q_OBJECT
public:
    explicit HistoryDataListFeeder(QList<HistoryDataListElement*> *listModel, QObject *parent = nullptr)
        : QThread(parent)
        , m_listModel(listModel)
    {}

signals:
    void updateFetchDataStatus(int status);

protected:
    void run();

private:
    QList<HistoryDataListElement*> *m_listModel = nullptr;
};

class HistoryDataListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum LoginHistoryEnum {
        TIME = Qt::UserRole + 1,
        VAL_O2,
        VAL_CO,
        VAL_NO,
        VAL_NOX,
        VAL_SO2,
        VAL_TEMP,
        VAL_OPP,
        VAL_DUSTPM,
        VAL_VEL,
        VAL_FLOW,
    };

    explicit HistoryDataListModel(QObject *parent = nullptr);
    ~HistoryDataListModel();

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int,QByteArray> roleNames() const;
    void update();


public slots:
    void updateFetchDataStatus(int status);
    void fetchData();

signals:
    void fetchDataStarting();
    void fetchDataFinished();
    void terminateFetchData();

private:
    QList<HistoryDataListElement*> *m_listElement;
    HistoryDataListFeeder *m_feeder;
};

#endif // LOGINHISTORYLISTMODEL_H
