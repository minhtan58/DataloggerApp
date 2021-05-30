#include "DatabaseHandler.h"

DatabaseHandler::DatabaseHandler(QObject *parent) : QObject(parent)
{
    MyDatabase::getInstance();
}

void DatabaseHandler::eventHandler(QString objectName, int eventId, QString param)
{
    Q_UNUSED(objectName)
    switch (eventId) {
    case EnumID::HMI_REQUEST_GET_HISTORY_DATA: {
        qDebug() << "DatabaseHandler::eventHandler HMI_REQUEST_GET_HISTORY_DATA";
        QList<CemsDataRow> list;
        list = MyDatabase::getInstance()->getHistoryData(param);
        ManagerData::getInstance()->setHistoryDataList(list);
        SENDEVENT("" , EnumID::HMI_RESPONSE_GET_HISTORY_DATA_FINISHED, "");
        break;
    }
    case EnumID::HMI_BUTTON_REQ_EXPORT: {
        SENDEVENT("" , EnumID::HMI_COMMON_POPUP, "3000,Export successful!");
        exportDataFile();
        break;
    }
    default:
        break;
    }
}

void DatabaseHandler::updateAppData(int dpid)
{
    switch (dpid) {
    case EnumID::DP_SETTINGS_NETWORK_SERVER_INTERVAL: {
        if(m_timerSendDataToServer != nullptr && m_timerSendDataToServer->isActive()) {
            m_timerSendDataToServer->stop();
        }

        int interval = GETDPDATA(dpid).toInt();
        m_timerSendDataToServer->setInterval(interval > 0 ? interval : DEFAULT_SERVER_READ_INTERVAL);
        m_timerSendDataToServer->start();
        qDebug() << "NetworkMainServerHandler run with timer : read value" + m_timerSendDataToServer->interval() + interval;
        break;
    }
    default:
        break;
    }
}

void DatabaseHandler::updateTime()
{
    m_process->start("/usr/CEMSDatalogger/scripts/updatetime.sh");
    m_process->waitForFinished();
}

void DatabaseHandler::start()
{
    qDebug() << "Start Send Data To Server";
    if(m_timerSendDataToServer != nullptr && !m_timerSendDataToServer->isActive()) {
        m_timerSendDataToServer->start();
        qDebug() << "NetworkMainServerHandler run with timer" + m_timerSendDataToServer->interval();
    }
}

void DatabaseHandler::exportDataFile()
{
    if(!QDir().exists(PH_EXPORT_FOLDER)) {
        if(!QDir().mkpath(QFileInfo(PH_EXPORT_FOLDER).absolutePath())) {
            //qDebug() << "Can't create storage folder %s" + PH_EXPORT_FOLDER;
            return;
        }
    }

    QString selectedTime = GETDPDATA(EnumID::DP_SEARCH_TIME_HISTORY_DATA);
    QList<CemsDataRow> list = MyDatabase::getInstance()->getHistoryData(selectedTime);
    if(list.size() < 1) {
        qDebug() << "Export List empty";
        return;
    }

    QString stationId = GETDPDATA(EnumID::DP_GENERAL_STATION_ID);
    QString stationName = GETDPDATA(EnumID::DP_GENERAL_STATION_NAME);
    if(stationName.isEmpty()) {
        stationName = "ExportData";
    }

    QString filename, data;
    data = QString("Station ID: %1\nStation Name: %2\nDate: %3\n\n").arg(stationId).arg(stationName).arg(selectedTime);
    if(stationId.isEmpty()) {
        filename = PH_EXPORT_FOLDER + QString("/%1_%2.txt").arg(stationName).arg(selectedTime.replace('-','_'));
    } else {
        filename = PH_EXPORT_FOLDER + QString("/%1_%2_%3.txt").arg(stationId).arg(stationName).arg(selectedTime.replace('-','_'));
    }

    data += QString("%1%2%3%4%5\n")
            .arg("Time", -25)
            .arg("ID", -10)
            .arg("DATA1", -10)
            .arg("DATA2", -10)
            .arg("DATA3", -10);

    for(int i = 0; i < list.size(); i++) {
        data += QString("%1%2%3%4%5\n")
                .arg(list.at(i).time, -25)
                .arg(list.at(i).id, -10)
                .arg(list.at(i).data1, -10)
                .arg(list.at(i).data2, -10)
                .arg(list.at(i).data3, -10);
    }

    QFile fileWrite;
    QTextStream writeStream;
    fileWrite.setFileName(filename);
    if(fileWrite.open(QIODevice::WriteOnly | QIODevice::Text)) {
        writeStream.setDevice(&fileWrite);
        writeStream << data;
        fileWrite.close();
        qDebug() << "Write Successful to ";
        return;
    }
    qDebug() << "Can't Open";
}
