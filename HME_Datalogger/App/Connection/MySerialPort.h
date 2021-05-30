#ifndef MYSERIALPORT_H
#define MYSERIALPORT_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QTimer>

#include "ManagerData.h"
#include "Defines.h"
#include "Structs.h"

class MySerialPort : public QObject
{
    Q_OBJECT
public:
    explicit MySerialPort(QObject *parent = nullptr);
    QString getData() const;
    QStringList getListData();

    //Send data
    void transmitCommand(int iCommand, int iLength, char data[]);
    void startNetwork();
    void setPermitJoin(uint16_t u16ShortAddr, uint8_t u8Interval, uint8_t u8TCsignificance);
    void vSendPermitRejoinStateRequest();
    void vGetVersion();
    void sendClusterOnOff(uint8_t u8AddrMode, uint16_t u16ShortAddr, uint8_t u8SrcEndPoint, uint8_t u8DstEndPoint, uint8_t u8CommandID);
    void vProcessRxChar(uint8_t u8Char);
    void vProcessCommand(void);

    //Recive data
    void serialPort_DataReceivedHandler(QByteArray data);
    void displayRawCommandData(uint16_t u16Type, uint16_t u16Length, char u8Checksum, char au8Data[]);
    void displayDecodedCommand(uint16_t u16Type, uint16_t u16Length, uint8_t au8Data[]);

signals:
    void readComplete();

public slots:
    void readData();
    void handleError(QSerialPort::SerialPortError error);
    void openSerialPort(QString sportName, QString sBaudrate);
    void closeSerialPort();
    void writeData(const QByteArray &data);
    void writeStringData(QString data);

private:

    tsCommand sCommand;
    QString m_databuf;
    QStringList elements;
    bool check;
    QString m_dataChange;
    QSerialPort *m_serial = nullptr;

    uint8_t rxMessageData[1024];
    char rxMessageChecksum      = 0;
    uint16_t rxMessageLength    = 0;
    int rxMessageState          = 0;
    uint16_t rxMessageType      = 0;
    int rxMessageCount          = 0;
    bool rxMessageInEscape      = false;
};

#endif // MYSERIALPORT_H

