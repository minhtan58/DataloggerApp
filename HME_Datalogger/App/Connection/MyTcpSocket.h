#ifndef MYTCPSOCKET_H
#define MYTCPSOCKET_H

#include <QObject>
#include <QTcpSocket>
#include <QAbstractSocket>
#include <QDebug>

#include "ManagerData.h"
#include "Defines.h"

class MyTcpSocket : public QObject
{
    Q_OBJECT
public:
    explicit MyTcpSocket(QObject *parent = nullptr);
    void doConnect(QString ipAdress,int port);
    QString getData() const;

signals:
    void readComplete();

public slots:
    void disconnected();
    void readData();
    void sendData(const QByteArray &data);

private:
    QString m_dataChange;
    QTcpSocket *m_socket = nullptr;
};

#endif // MYTCPSOCKET_H
