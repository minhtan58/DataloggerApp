#ifndef TCPSOCKETHANDLER_H
#define TCPSOCKETHANDLER_H

#include <QObject>
#include <QThread>

#include "ManagerData.h"
#include "Defines.h"
#include "MyTcpSocket.h"
#include "UIBridge.h"
#include "Enum.h"

class TcpSocketHandler : public QObject
{
    Q_OBJECT
public:
    explicit TcpSocketHandler(QObject *parent = nullptr);
//    ~TcpSocketHandler();

signals:

public slots:
    void eventHandler(QString objectName, int eventId, QString param);
    void setData();

private:
    MyTcpSocket *m_tcpSocket = nullptr;
};

class TcpSocketHandlerThread : public QThread
{
    Q_OBJECT
public:
    TcpSocketHandlerThread(QObject *parent = nullptr) : QThread(parent) {}

protected:
    void run() {
        qDebug() << "Start";
        TcpSocketHandler handler;
        connect(UIBridge::getInstance(), SIGNAL(hmiEvent(QString,int,QString)), &handler, SLOT(eventHandler(QString,int,QString)));
        exec();
    }
};

#endif // TCPSOCKETHANDLER_H
