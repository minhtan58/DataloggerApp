#include "MyTcpSocket.h"

MyTcpSocket::MyTcpSocket(QObject *parent) : QObject(parent)
{
    m_socket = new QTcpSocket(this);
}

void MyTcpSocket::doConnect(QString ipAdress,int port) {
    if(m_socket->state() == QTcpSocket::ConnectedState) {
        disconnected();
        return;
    }

    qDebug() << "Connecting...";
    if (m_socket->state() != QTcpSocket::ConnectedState) {
        m_socket->connectToHost(ipAdress, quint16(port));
        m_socket->waitForConnected(1000);
        qDebug() << "Connected";
        SETDPDATA(EnumID::DP_NETWORK_STATUS, "Disconnected");
        connect(m_socket, SIGNAL(readyRead()), this, SLOT(readData()));
    } else {
        SETDPDATA(EnumID::DP_NETWORK_STATUS, "Connect");
    }
}

void MyTcpSocket::disconnected() {
    qDebug() << "Disconnected";
    m_socket->disconnectFromHost();
    SETDPDATA(EnumID::DP_NETWORK_STATUS, "Connect");
}

QString MyTcpSocket::getData() const {
    return m_dataChange;
}

void MyTcpSocket::sendData(const QByteArray &data) {
    m_socket->write(data);
    qDebug() << "Data :" << data;
}

void MyTcpSocket::readData() {
    QByteArray data = m_socket->readAll();
    m_dataChange = QString::fromUtf8(data);
    qDebug() << "Data :" << data;
    emit readComplete();
}
