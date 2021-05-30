#ifndef UIBRIDGE_H
#define UIBRIDGE_H

#include <QObject>

#include "ManagerData.h"

class UIBridge : public QObject
{
    Q_OBJECT
public:
    explicit UIBridge(QObject *parent = nullptr);
    static UIBridge *getInstance();
    ~UIBridge();

    void sendEvent(QString objectName, int EnumID, QString param);
    Q_INVOKABLE QString getDPData(int dpid);
    Q_INVOKABLE void setDPData(int dpid, QVariant value);
    Q_INVOKABLE void log(QString msg);

private:
    static UIBridge *m_uiBridge;

signals:
    void hmiEvent(QString objectName, int EnumID, QString param);

public slots:
};

#endif // UIBRIDGE_H
