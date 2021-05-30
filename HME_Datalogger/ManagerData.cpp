#include "ManagerData.h"

#define INITDATA(param) \
    m_datapool.insert(int(param), QString("")); \
    m_dpName.insert(int(param), (QString(#param)).mid(10))

ManagerData* ManagerData::m_managerData = nullptr;

ManagerData::ManagerData(QObject *parent) : QObject(parent)
{
    initData();
    //DbManager::getInstance();
}

ManagerData *ManagerData::getInstance()
{
    if(m_managerData == nullptr) {
        m_managerData = new ManagerData();
    }
    return m_managerData;
}

QString ManagerData::getData(int dpId)
{
    if(m_datapool.contains(dpId)) {
        return m_datapool.value(dpId);
    }
    return "";
}

void ManagerData::setData(int dpid, QString value)
{
    if(m_datapool.contains(dpid)) {
        if (getData(dpid) != value) {
            mutex.lock();
            m_datapool[dpid] = value;
            mutex.unlock();
            emit dataChanged(dpid);
            return;
        }
    } else {
        qDebug() << "DPID:" << dpid << "Incorrect";
    }
}

QString ManagerData::getDataName(int dpId)
{
    if(m_dpName.contains(dpId)) {
        return m_dpName.value(dpId);
    }
    return "";
}

/********************HistoryData**************************/

void ManagerData::setHistoryDataList(const QList<CemsDataRow> &historyDataList)
{
    m_historyDataList = historyDataList;
}

QList<CemsDataRow> ManagerData::getHistoryDataList() const
{
    return m_historyDataList;
}

/********************HistoryData**************************/

void ManagerData::initData()
{
    INITDATA(EnumID::DP_TIME);
    INITDATA(EnumID::DP_DATE);
    INITDATA(EnumID::DP_HOUR);
    INITDATA(EnumID::DP_MINUTES);
    INITDATA(EnumID::DP_DAY);
    INITDATA(EnumID::DP_MONTH);
    INITDATA(EnumID::DP_YEAR);
    INITDATA(EnumID::DP_PORTCOM);
    INITDATA(EnumID::DP_NETWORK);
    INITDATA(EnumID::DP_SERIALPORT_STATUS);
    INITDATA(EnumID::DP_NETWORK_STATUS);
    INITDATA(EnumID::DP_SEARCH_TIME_HISTORY_DATA);
    INITDATA(EnumID::DP_SYS_DATE_DAY);
    INITDATA(EnumID::DP_SYS_SETTINGS_TIME_AUTOMATIC_UPDATE);
    INITDATA(EnumID::DP_GENERAL_STATION_ID);
    INITDATA(EnumID::DP_GENERAL_STATION_NAME);
    INITDATA(EnumID::DP_GENERAL_RADIUS);
    INITDATA(EnumID::DP_SETTINGS_NETWORK_SERVER_INTERVAL);

    INITDATA(EnumID::DP_CHANEL_1);
    INITDATA(EnumID::DP_CHANEL_2);
    INITDATA(EnumID::DP_CHANEL_3);
    INITDATA(EnumID::DP_CHANEL_4);
    INITDATA(EnumID::DP_CHANEL_5);
    INITDATA(EnumID::DP_CHANEL_6);
    INITDATA(EnumID::DP_CHANEL_7);
    INITDATA(EnumID::DP_CHANEL_8);
    INITDATA(EnumID::DP_CHANEL_9);
    INITDATA(EnumID::DP_CHANEL_10);
    INITDATA(EnumID::DP_CHANEL_11);
    INITDATA(EnumID::DP_CHANEL_12);
    INITDATA(EnumID::DP_CHANEL_13);
    INITDATA(EnumID::DP_CHANEL_14);
    INITDATA(EnumID::DP_CHANEL_15);
    INITDATA(EnumID::DP_CHANEL_16);
    INITDATA(EnumID::DP_CHANEL_17);
    INITDATA(EnumID::DP_CHANEL_18);
    INITDATA(EnumID::DP_CHANEL_19);
}
