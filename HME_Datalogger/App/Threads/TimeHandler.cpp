#include "TimeHandler.h"

TimeHandler::TimeHandler(QObject *parent) : QObject(parent)
{
    m_process = new QProcess(this);
}

void TimeHandler::updateSystemTime() {
    //qDebug() << "updateSystemTime" <<  QDateTime::currentDateTime().toString("hh:mm");
    SETDPDATA(EnumID::DP_TIME, QDateTime::currentDateTime().toString("hh:mm"));
    //SETDPDATA(EnumID::DP_DATE, QDateTime::currentDateTime().toString("dd/MM/yyyy"));
    //SETDPDATA(EnumID::DP_HOUR, QDateTime::currentDateTime().toString("HH"));
    //SETDPDATA(EnumID::DP_MINUTES, QDateTime::currentDateTime().toString("mm"));
    //SETDPDATA(EnumID::DP_YEAR, QDateTime::currentDateTime().toString("yyyy"));
    //SETDPDATA(EnumID::DP_MONTH, QDateTime::currentDateTime().toString("MM"));
    //SETDPDATA(EnumID::DP_DAY, QDateTime::currentDateTime().toString("dd"));
    //SETDPDATA(EnumID::DP_CHANEL_1, "111");
    //SETDPDATA(EnumID::DP_CHANEL_2, "222");
    //SETDPDATA(EnumID::DP_CHANEL_3, "333");
    //SETDPDATA(EnumID::DP_CHANEL_4, "444");
    //SETDPDATA(EnumID::DP_CHANEL_5, "555");
}

void TimeHandler::eventHandler(QString objectName, int eventId, QString param) {
    Q_UNUSED(objectName)
    QStringList params = getListParam(param);
    switch (eventId) {
    case EnumID::HMI_UPDATE_TIME_AUTOMATIC: {

    }
    case EnumID::HMI_SET_DATE_TIME: {

    }
        break;
    default:
        break;
    }
}

void TimeHandler::updateAppData(int dpid)
{
    switch (dpid) {
    case EnumID::DP_SYS_SETTINGS_TIME_AUTOMATIC_UPDATE: {

        break;
    }
    default:
        break;
    }
}
