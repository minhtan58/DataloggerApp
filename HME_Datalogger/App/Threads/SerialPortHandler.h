#ifndef SERIALPORTHANDLER_H
#define SERIALPORTHANDLER_H

#include <QObject>
#include <QThread>

#include "MySerialPort.h"
#include "ManagerData.h"
#include "UIBridge.h"

class SerialPortHandler : public QObject
{
    Q_OBJECT
public:
    explicit SerialPortHandler(QObject *parent = nullptr);
    ~SerialPortHandler();

signals:

public slots:
    void eventHandler(QString objectName, int eventId, QString param);
    void setData();
    void updateSerialPortList();
    void readDConChanel(int chanel, int ampType);
    void updateAppData(int dpid);

private:
    MySerialPort *m_serialPort = nullptr;

};

class SerialPortHandlerThread : public QThread
{
    Q_OBJECT
public:
    SerialPortHandlerThread(QObject *parent = nullptr) : QThread(parent) {}

protected:
    void run() {
        qDebug() << "Start thread SerialPort";
        SerialPortHandler handler;
        connect(UIBridge::getInstance(), SIGNAL(hmiEvent(QString,int,QString)), &handler, SLOT(eventHandler(QString,int,QString)));
        exec();
    }
};

#endif // SERIALPORTHANDLER_H
