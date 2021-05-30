/****************************************************************************

    Copyright (C) 2018 by KingKong JSC
    File: LoginHistoryListModel.cpp
    Create: 09
    Author: Minh Tan

 ****************************************************************************/

#include "HistoryDataListModel.h"

HistoryDataListModel::HistoryDataListModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_listElement = new QList<HistoryDataListElement*>();
    m_feeder  = new HistoryDataListFeeder(m_listElement, this);
    connect(m_feeder, SIGNAL(updateFetchDataStatus(int)), this, SLOT(updateFetchDataStatus(int)));
    connect(this, SIGNAL(terminateFetchData()), m_feeder, SLOT(quit()));
    fetchData();
}

HistoryDataListModel::~HistoryDataListModel()
{
    qDebug("~LoginHistoryListModel");
    if(m_listElement) {
        qDeleteAll(*m_listElement);
        m_listElement->clear();
        delete m_listElement;
        m_listElement = nullptr;
    }
}

int HistoryDataListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_listElement->size();
}

QVariant HistoryDataListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 ||
            index.row() >= m_listElement->size()){
        return QVariant();
    }
    const HistoryDataListElement *dobj = m_listElement->at(index.row());

    switch (role) {
    case TIME:
        return QVariant::fromValue(dobj->time());
    case VAL_O2:
        return QVariant::fromValue(dobj->valO2());
    case VAL_CO:
        return QVariant::fromValue(dobj->valCO());
    case VAL_NO:
        return QVariant::fromValue(dobj->valNO());
    case VAL_NOX:
        return QVariant::fromValue(dobj->valNOX());
    case VAL_SO2:
        return QVariant::fromValue(dobj->valSO2());
    case VAL_TEMP:
        return QVariant::fromValue(dobj->valTEMP());
    case VAL_OPP:
        return QVariant::fromValue(dobj->valOPP());
    case VAL_DUSTPM:
        return QVariant::fromValue(dobj->valDUSTPM());
    case VAL_VEL:
        return QVariant::fromValue(dobj->valVEL());
    case VAL_FLOW:
        return QVariant::fromValue(dobj->valFLOW());
    default:
        return QVariant();
    }
}
QHash<int, QByteArray> HistoryDataListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TIME] = "time";
    roles[VAL_O2] = "valO2";
    roles[VAL_CO] = "valCO";
    roles[VAL_NO] = "valNO";
    roles[VAL_NOX] = "valNOX";
    roles[VAL_SO2] = "valSO2";
    roles[VAL_TEMP] = "valTEMP";
    roles[VAL_OPP] = "valOPP";
    roles[VAL_DUSTPM] = "valDUSTPM";
    roles[VAL_VEL] = "valVEL";
    roles[VAL_FLOW] = "valFLOW";
    return roles;
}

void HistoryDataListModel::update()
{
    beginResetModel();
    endResetModel();
}

void HistoryDataListModel::fetchData()
{
    m_feeder->start();
}

void HistoryDataListModel::updateFetchDataStatus(int status)
{
    switch (status) {
    case FETCH_IDLE:
    case FETCH_STARTING:
        qDebug("Fetch Starting");
        emit fetchDataStarting();
        break;
    case FETCH_FINISHED:
        qDebug("Fetch Finished, list size: %d", m_listElement->size());
        update();
        emit fetchDataFinished();
        break;
    default:
        break;
    }
}

void HistoryDataListFeeder::run() {
    emit updateFetchDataStatus(FETCH_STARTING);

    if(m_listModel && m_listModel->size()) {
        qDeleteAll(*m_listModel);
        m_listModel->clear();
    }

    QList<CemsDataRow> list;
    CemsDataRow element;

    for(int i=0;i<10;i++){
        element.time = i;
        element.valO2 = i;
        element.valCO = i;
        element.valNO = i;
        element.valNOX = i;
        element.valSO2 = i;
        element.valTEMP = i;
        element.valOPP = i;
        element.valDUSTPM = i;
        element.valVEL = i;
        element.valFLOW = i;
        list.append(element);
    }

    for(int i = 0; i < list.size(); ++i) {
        QString time = list.at(i).time.mid(11);
        m_listModel->append(new HistoryDataListElement(
                                time,
                                list.at(i).valO2,
                                list.at(i).valCO,
                                list.at(i).valNO,
                                list.at(i).valNOX,
                                list.at(i).valSO2,
                                list.at(i).valTEMP,
                                list.at(i).valOPP,
                                list.at(i).valDUSTPM,
                                list.at(i).valVEL,
                                list.at(i).valFLOW));
    }
    emit updateFetchDataStatus(FETCH_FINISHED);
}
