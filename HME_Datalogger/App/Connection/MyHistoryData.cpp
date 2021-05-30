#include "MyHistoryData.h"

/*****************************************Model*******************************************/
HistoryDataModel::HistoryDataModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_listElement = new QList<HistoryDataElement*>();
    m_feeder  = new HistoryDataFeeder(m_listElement, this);
    connect(m_feeder, SIGNAL(signalUpdateFetchDataStatus(int)), this, SLOT(slotUpdateFetchDataStatus(int)));
    connect(this, SIGNAL(terminateFetchData()), m_feeder, SLOT(quit()));
    fetchData();
}

HistoryDataModel::~HistoryDataModel()
{
    if(m_listElement) {
        qDeleteAll(*m_listElement);
        m_listElement->clear();
        delete m_listElement;
        m_listElement = nullptr;
    }
}

void HistoryDataModel::update()
{
    beginResetModel();
    endResetModel();
}

void HistoryDataModel::slotUpdateFetchDataStatus(int status)
{
    switch (status) {
    case FETCH_IDLE:
    case FETCH_STARTING:
        qDebug() << "Fetch Starting";
        emit fetchDataStarting();
        break;
    case FETCH_FINISHED:
        qDebug() << "Fetch Finished, list size: " << m_listElement->size();
        update();
        emit fetchDataFinished();
        break;
    default:
        break;
    }
}

int HistoryDataModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_listElement->size();
}

QVariant HistoryDataModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 ||
            index.row() >= m_listElement->size()){
        return QVariant();
    }
    const HistoryDataElement *dobj = m_listElement->at(index.row());

    switch (role) {
    case ID:
        return QVariant::fromValue(dobj->id());
    case TIME:
        return QVariant::fromValue(dobj->time());
    case DATA1:
        return QVariant::fromValue(dobj->data1());
    case DATA2:
        return QVariant::fromValue(dobj->data2());
    case DATA3:
        return QVariant::fromValue(dobj->data3());
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> HistoryDataModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ID] = "id";
    roles[TIME] = "time";
    roles[DATA1] = "data1";
    roles[DATA2] = "data2";
    roles[DATA3] = "data3";
    return roles;
}

void HistoryDataModel::fetchData()
{
    m_feeder->start();
}

void HistoryDataFeeder::run() {
    qDebug() << "Fetch data for HistoryDataListModel";
    emit signalUpdateFetchDataStatus(FETCH_STARTING);

    QString searchTime = GETDPDATA(EnumID::DP_SEARCH_TIME_HISTORY_DATA);
    qDebug() << searchTime;
    if(searchTime.isEmpty())
        return;

    if(m_listModel && m_listModel->size()) {
        qDeleteAll(*m_listModel);
        m_listModel->clear();
    }

    QList<CemsDataRow> list = ManagerData::getInstance()->getHistoryDataList();
    for(int i = 0; i < list.size(); ++i) {
        QString time = list.at(i).time.mid(11);
        m_listModel->append(new HistoryDataElement(
                                time,
                                list.at(i).id,
                                list.at(i).data1,
                                list.at(i).data2,
                                list.at(i).data3));
    }
    emit signalUpdateFetchDataStatus(FETCH_FINISHED);
}
