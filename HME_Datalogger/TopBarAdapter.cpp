#include "TopBarAdapter.h"

TopBarAdapter::TopBarAdapter(QQuickItem *container, QObject *parent)
    : QObject(parent)
{
    m_topbarContainer = container;
    m_TopBarView = qvariant_cast<QObject*>(m_topbarContainer->property("item"));
}

void TopBarAdapter::initAppData()
{
    m_TopBarView->setProperty("stationId",      QVariant::fromValue(GETDPDATA(EnumID::DP_GENERAL_STATION_ID)));
    m_TopBarView->setProperty("stationName",    QVariant::fromValue(GETDPDATA(EnumID::DP_GENERAL_STATION_NAME)));
    m_TopBarView->setProperty("systemDate",     QVariant::fromValue(GETDPDATA(EnumID::DP_DATE)));
    m_TopBarView->setProperty("systemTime",     QVariant::fromValue(GETDPDATA(EnumID::DP_TIME)));
}

void TopBarAdapter::updateAppData(int dpid)
{
    QString data = GETDPDATA(dpid);
    switch (dpid) {
    case EnumID::DP_DATE: {
        qDebug() << "EnumID::DP_DATE";
        m_TopBarView->setProperty("systemDate", QVariant::fromValue(data));
        break;
    }
    case EnumID::DP_TIME:{
        m_TopBarView->setProperty("systemTime", QVariant::fromValue(data));
        break;
    }
    case EnumID::DP_GENERAL_STATION_NAME: {
        m_TopBarView->setProperty("stationName", QVariant::fromValue(data));
        break;
    }
    case EnumID::DP_STATUS_ALARM_ON_COUNT: {
        m_TopBarView->setProperty("alarmCount", QVariant::fromValue(data));
        break;
    }
    default:
        break;
    }
}
