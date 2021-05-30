#ifndef TIMEHANDLER_H
#define TIMEHANDLER_H

#include <QObject>
#include <QThread>
#include <QTimer>
#include <QDateTime>
#include <QProcess>

#include "ManagerData.h"
#include "UIBridge.h"

class TimeHandler : public QObject
{
    Q_OBJECT
public:
    explicit TimeHandler(QObject *parent = nullptr);

signals:

public slots:
    void updateSystemTime();
    void eventHandler(QString objectName, int eventId, QString param);
    void updateAppData(int dpid);

private:
    QProcess *m_process = nullptr;
};

class TimeHandlerThread : public QThread
{
    Q_OBJECT
public:
    explicit TimeHandlerThread(QObject *parent = nullptr) : QThread(parent){}

protected:
    void run() {
        QTimer updateSystemTime;
        TimeHandler handler;
        connect(&updateSystemTime, SIGNAL(timeout()), &handler, SLOT(updateSystemTime()));
        connect(UIBridge::getInstance(), SIGNAL(hmiEvent(QString,int,QString)), &handler, SLOT(eventHandler(QString,int,QString)));
        connect(ManagerData::getInstance(), SIGNAL(dataChanged(int)), &handler, SLOT(updateAppData(int)));
        updateSystemTime.start(1000);
        exec();
    }
};

#endif // TIMEHANDLER_H
