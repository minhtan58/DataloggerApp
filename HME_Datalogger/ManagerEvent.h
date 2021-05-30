#ifndef MANAGEREVENT_H
#define MANAGEREVENT_H

#include <QObject>
#include <QQuickItem>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "UIBridge.h"
#include "MySerialPort.h"
#include "MyTcpSocket.h"
#include "TopBarAdapter.h"
#include "Enum.h"
#include "ScreenAdapter.h"
#include "BaseThreads.h"
#include "SerialPortHandler.h"
#include "QmlValues.h"

class ManagerEvent : public QObject
{
    Q_OBJECT
public:
    explicit ManagerEvent(QObject *parent = nullptr);
    ~ManagerEvent();
    void exec();
    UIBridge *m_uiBridge;
    QmlValues *m_qmlValue = nullptr;
private:
    QQmlApplicationEngine m_engine;

    MySerialPort *m_mySerialPort = nullptr;
    MyTcpSocket *m_myTcpSocket = nullptr;
    ScreenAdapter *m_screenAdapter = nullptr;
    BaseThreads *m_baseThreads = nullptr;
    TopBarAdapter *m_topBarAdapter = nullptr;

    void initWindow();
    void showScreen(int screenId);
    void showOverlay(int overlayId, int timeout, int layer = Z_OVERLAY, QString message = "");
    void hideOverlay();

signals:

public slots:
    void hmiHandle(QString objectName, int EnumID, QString param);
};

#endif // MANAGEREVENT_H
