#ifndef DATABASEHANDLER_H
#define DATABASEHANDLER_H

#include <QObject>
#include <QTimer>
#include <QProcess>
#include <QThread>
#include <QDir>

#include "MyDatabase.h"
#include "Enum.h"
#include "UIBridge.h"

class DatabaseHandler : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseHandler(QObject *parent = nullptr);

signals:

public slots:
    void eventHandler(QString objectName, int eventId, QString param);
    void updateAppData(int dpid);

private:
    QTimer *m_timerSendDataToServer = nullptr;
    QProcess *m_process = nullptr;

    void saveToHistoryDb(QStringList dataRow);
    void saveToMissingDb(QStringList dataRow);

    void updateTime();
    void start();
    void exportDataFile();
};

class DatabaseHandlerThread : public QThread
{
    Q_OBJECT
public:
    DatabaseHandlerThread(QObject *parent = nullptr): QThread(parent)
    {}

protected:
    void run() {
        DatabaseHandler handler;
        connect(UIBridge::getInstance(), SIGNAL(hmiEvent(QString,int,QString)), &handler, SLOT(eventHandler(QString,int,QString)));
        connect(ManagerData::getInstance(), SIGNAL(dataChanged(int)), &handler, SLOT(updateAppData(int)));
        exec();
    }
};

#endif // DATABASEHANDLER_H
