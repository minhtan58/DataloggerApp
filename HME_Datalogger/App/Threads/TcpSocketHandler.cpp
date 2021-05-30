#include "TcpSocketHandler.h"

TcpSocketHandler::TcpSocketHandler(QObject *parent) : QObject(parent) {
    m_tcpSocket = new MyTcpSocket(this);
    connect(m_tcpSocket, SIGNAL(readComplete()), this, SLOT(setData()), Qt::UniqueConnection);
    SETDPDATA(EnumID::DP_NETWORK_STATUS, "Connect");
}

//TcpSocketHandler::~TcpSocketHandler() {
//    if (m_tcpSocket && m_tcpSocket->m_socket->state() == QTcpSocket::ConnectedState) {
//        m_tcpSocket->disconnectFromHost();
//        m_tcpSocket->waitForDisconnected();
//    }
//}

void TcpSocketHandler::setData() {
    QString value = m_tcpSocket->getData();
    SETDPDATA(EnumID::DP_NETWORK, value);
}

void TcpSocketHandler::eventHandler(QString objectName, int eventId, QString param) {
    Q_UNUSED(objectName)
    switch (eventId) {
    case EnumID::HMI_TEST_CONNECTIONS_NETWORK: {
        SETDPDATA(EnumID::DP_NETWORK_STATUS, "Connecting...");
        QStringList paramList = getListParam(param);
        m_tcpSocket->doConnect(paramList.at(0), paramList.at(1).toInt());
        break;
    }
    case EnumID::HMI_SEND_DATA_NETWORK: {
        m_tcpSocket->sendData(param.toUtf8());
        break;
    }
    default:
        break;
    }
}


