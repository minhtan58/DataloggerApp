#include "MySerialPort.h"

MySerialPort::MySerialPort(QObject *parent) : QObject(parent)
{
    m_serial = new QSerialPort(this);

    connect(m_serial, SIGNAL(error(QSerialPort::SerialPortError)), this, SLOT(handleError(QSerialPort::SerialPortError)));
}

void MySerialPort::openSerialPort(QString portName, QString baudrate)
{
    if(m_serial->isOpen())
    {
        closeSerialPort();
        return;
    }

    m_serial->setPortName(portName);
    m_serial->setBaudRate(baudrate.toUInt());
    m_serial->setDataBits(QSerialPort::Data8);
    m_serial->setParity(QSerialPort::NoParity);
    m_serial->setStopBits(QSerialPort::OneStop);
    m_serial->setFlowControl(QSerialPort::NoFlowControl);

    if (m_serial->open(QIODevice::ReadWrite)) {
        SETDPDATA(EnumID::DP_SERIALPORT_STATUS, "Disconnect");
        connect(m_serial, SIGNAL(readyRead()), this, SLOT(readData()));
    } else {
        SETDPDATA(EnumID::DP_SERIALPORT_STATUS, "Connect");
    }
}

void MySerialPort::closeSerialPort()
{
    if (m_serial->isOpen())
        m_serial->close();
    SETDPDATA(EnumID::DP_SERIALPORT_STATUS, "Connect");
}

void MySerialPort::readData()
{
   m_serial->waitForReadyRead(200);
   QByteArray data = m_serial->readAll();

   //m_dataChange = QString::fromUtf8(data);
   //serialPort_DataReceivedHandler(data);

   QString msg = QString::fromStdString(data.toStdString());
   //qDebug() << "Rev: " << msg << data.length();
   if(msg.contains("\r")){
       check = true;
   }

   if(check)
   {
       m_databuf = m_databuf + msg;
       if(msg.contains("\n")){
           check = false;
           //qDebug() << "REV: " << m_databuf.remove(m_databuf.length()-1, m_databuf.length()).remove(0, 1);
           elements = m_databuf.remove(m_databuf.length()-1, m_databuf.length()).remove(0, 1).split('+', QString::SkipEmptyParts);
           emit readComplete();
           m_databuf = "";
       }
   }
}

void MySerialPort::writeData(const QByteArray &data)
{
    m_serial->write(data);
}

void MySerialPort::writeStringData(QString data)
{
    //QString command = "0x1111 tran minh tan\n\r";

    m_serial->write(data.toStdString().c_str());
    //m_serial->write(command.toUtf8());
}

QString MySerialPort::getData() const
{
    return m_dataChange;
}

QStringList MySerialPort::getListData()
{
    return elements;
}

void MySerialPort::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        closeSerialPort();
        sCommand.u8Pos = 5;
    }
}

void MySerialPort::vProcessCommand(void)
{
    uint8_t Delimiters[] = " ";
    uint8_t *token = NULL;

    token = (uint8_t *)strtok((char *)sCommand.au8Buffer, (char *)Delimiters);

    if (0 == stricmp((char*)token, "toggle"))
    {
        qDebug() << "Short Address: toggle";
    }

    if (0 == stricmp((char*)token, "hello"))
    {
        qDebug() << "Short Address: hello";
    }

    memset(sCommand.au8Buffer, 0, COMMAND_BUF_SIZE);
    sCommand.u8Pos = 0;
}

void MySerialPort::vProcessRxChar(uint8_t u8Char)
{

    if ((u8Char >= 'a' && u8Char <= 'z'))
    {
        u8Char -= ('a' - 'A');
    }
    if ((sCommand.u8Pos < COMMAND_BUF_SIZE)  && (u8Char != 0x0d))
    {
        sCommand.au8Buffer[sCommand.u8Pos++] = u8Char;
    }
    else if (sCommand.u8Pos >= COMMAND_BUF_SIZE)
    {
        memset(sCommand.au8Buffer, 0, COMMAND_BUF_SIZE);
        sCommand.u8Pos = 0;
    }

    if (u8Char == 0x0d)
    {
        vProcessCommand();
    }
}

// Sendata
void MySerialPort::startNetwork()
{
//    unsigned char Diff[] = {0x01, 0x02, 0x10, 0x24, 0x02, 0x10, 0x02, 0x10, 0x24, 0x03};
//    const char *cDiff = (const char*)Diff;
//    int diffSize = std::extent<decltype(Diff)>::value;
//    QByteArray ba = QByteArray(cDiff,diffSize);
//    writeData(ba);
    transmitCommand(0x0024, 0, nullptr);
}

void MySerialPort::sendClusterOnOff(uint8_t u8AddrMode, uint16_t u16ShortAddr, uint8_t u8SrcEndPoint, uint8_t u8DstEndPoint, uint8_t u8CommandID)
{
    char commandData[6];

    // Build command payload
    commandData[0] = u8AddrMode;
    commandData[1] = (char)(u16ShortAddr >> 8);
    commandData[2] = (char)u16ShortAddr;
    commandData[3] = u8SrcEndPoint;
    commandData[4] = u8DstEndPoint;
    commandData[5] = u8CommandID;

    // Transmit command
    transmitCommand(0x0092, 6, commandData);

}

void MySerialPort::vGetVersion()
{
    // Transmit command
    transmitCommand(0x0010, 0, nullptr);
}

void MySerialPort::vSendPermitRejoinStateRequest()
{
    // Transmit command
    transmitCommand(0x0014, 0, nullptr);
}

/* Make frame request*/
void MySerialPort::transmitCommand(int iCommand, int iLength, char data[])
{
    int i;
    QByteArray specialCharacter;
    specialCharacter.resize(1);
    QByteArray message;
    message.resize(256);

    // Build message payload, starting with the type field
    message[0] = (char)(iCommand >> 8);
    message[1] = (char)iCommand;

    // Add message length
    message[2] = (char)(iLength >> 8);
    message[3] = (char)iLength;

    // Calculate checksum of header
    char csum = 0;
    csum ^= message[0];
    csum ^= message[1];
    csum ^= message[2];
    csum ^= message[3];

    // Add message data and update checksum
    if (data != nullptr)
    {
        for (i = 0; i < iLength; i++)
        {
            message[5 + i] = data[i];
            csum ^= data[i];
        }
    }

    // Add checksum
    message[4] = csum;

    // Display data byte in terminal window
    // Transmit the message, send start character first
    specialCharacter[0] = 1;
    if (iCommand == 0x502){
        writeData(specialCharacter);
    }
    else{
        writeData(specialCharacter);
    }

    // Transmit message payload with byte stuffing as required
    for (i = 0; i < iLength + 5; i++)
    {
        //qDebug() << "rev: " << (uint8_t)message[i];
        // Check if stuffing is required
        if ((uint8_t)message[i] < 0x10)
        {
            // First send escape character then message byte XOR'd with 0x10
            specialCharacter[0] = 2;
            //writeData(specialCharacter);
            if (iCommand == 0x502)
            {
                writeData(specialCharacter);
            }
            else
            {
                writeData(specialCharacter);
            }

            int msg = message[i];
            msg = msg ^ 0x10;
            message[i] = (char)msg;

            if (iCommand == 0x502)
            {
                QByteArray ba;
                ba.resize(1);
                ba[0] = message[i];

                //buffer[i] = message[i];
                writeData(ba);
                //m_serial->write(buffer);
            }
            else
            {
                //buffer[i] = message[i];
                QByteArray ba;
                ba.resize(1);
                ba[0] = message[i];

                //buffer[i] = message[i];
                writeData(ba);
            }
        }
        else
        {
            // Send the character with no modification
            if (iCommand == 0x502)
            {
                //buffer[i] = message[i];
                QByteArray ba;
                ba.resize(1);
                ba[0] = message[i];

                //buffer[i] = message[i];
                writeData(ba);
            }
            else
            {
                QByteArray ba;
                ba.resize(1);
                ba[0] = message[i];

                //buffer[i] = message[i];
                writeData(ba);
                //buffer[i] = message[i];
            }
        }
    }
    // Send end character
    specialCharacter[0] = 3;
    if (iCommand == 0x502)
    {
        writeData(specialCharacter);
    }
    else
    {
        writeData(specialCharacter);
    }
}

//* Recive Data */
void MySerialPort::displayDecodedCommand(uint16_t u16Type, uint16_t u16Length, uint8_t au8Data[])
{
    switch (u16Type)
    {
        case 0x8024:
        {
            qDebug() << "Type = 0x8024";
            uint16_t u16ShortAddr = 0;
            uint64_t u64ExtAddr = 0;

            u16ShortAddr   = au8Data[1];
            u16ShortAddr <<= 8;
            u16ShortAddr  |= au8Data[2];

            for(int i = 0; i < 8; i++)
            {
                u64ExtAddr <<= 8;
                u64ExtAddr  |= au8Data[3 + i];
            }
            qDebug() << "Short Address: = " << u16ShortAddr;
        }break;

        case 0x8011:
        {
            qDebug() << "Type = 0x8011";
            qDebug() <<au8Data[0] << "||"<< au8Data[1] << "||" << au8Data[2] <<"||" << au8Data[3]<< "||" << au8Data[4] <<"||" << au8Data[5];
        }break;

        case 0x8010:
        {
            qDebug() << "Type = 0x8010";
            uint16_t u16Major = 0;
            uint16_t u16Installer = 0;

            u16Major   = au8Data[0];
            u16Major <<= 8;
            u16Major  |= au8Data[1];

            u16Installer = au8Data[2];
            u16Installer <<= 8;
            u16Installer |= au8Data[3];

            qDebug() << "u16Length: = " << u16Length;
            qDebug() << "u16Major: = " << u16Major;
            qDebug() << "u16Installer: = " << u16Installer;
        }break;

        case 0x8101:
        {
            qDebug() << "Type = 0x8101";
        }break;

        case 0x8000:
        {
            qDebug() << "Type = 0x8000";
        }break;

        case 0x8102:
        {
            qDebug() << "Type = 0x8102";
            uint16_t u16SrcAddr = 0;
            uint16_t u16ClusterId = 0;
            uint16_t u16AttribId = 0;
            uint16_t u16AttributeSize = 0;

            u16SrcAddr = au8Data[1];
            u16SrcAddr <<= 8;
            u16SrcAddr |= au8Data[2];

            u16ClusterId = au8Data[4];
            u16ClusterId <<= 8;
            u16ClusterId |= au8Data[5];

            u16AttribId = au8Data[6];
            u16AttribId <<= 8;
            u16AttribId |= au8Data[7];

            u16AttributeSize = au8Data[10];
            u16AttributeSize <<= 8;
            u16AttributeSize |= au8Data[11];
            qDebug() << "\nSQN: 0x" <<au8Data[0] << "||Src Addr: 0x"<< u16SrcAddr << "||Src Ep: 0x" << au8Data[3] <<"||ClusterID:" << u16ClusterId;
        }break;

        default:
        {
            qDebug() << "Type = " << u16Type;
        }break;
    }
}

void MySerialPort::serialPort_DataReceivedHandler(QByteArray data)
{
    qDebug() << "\n~~~data~~~~" << data.size();
    for(int i=0; i<data.size(); i++){
//        while ((uint8_t)data[i] > 0)
//        {
            if ((uint8_t)data[i] == 0x01)
            {
                // Start character received
                rxMessageChecksum = 0;
                rxMessageLength   = 0;
                rxMessageType     = 0;
                rxMessageState    = 0;
                rxMessageCount    = 0;
                rxMessageInEscape = false;
            }
            else if ((uint8_t)data[i] == 0x02)
            {
                rxMessageInEscape = true;
            }
            else if ((uint8_t)data[i] == 0x03)
            {
                displayDecodedCommand(rxMessageType, rxMessageLength, rxMessageData);
            }
            else
            {
                if (rxMessageInEscape == true)
                {
                    char csum = data[i];
                    csum ^= 0x10;
                    data[i] = csum;
                    rxMessageInEscape = false;
                }

                // Parse character
                switch (rxMessageState)
                {
                    case 0:
                    {
                        rxMessageType = (uint8_t)data[i];
                        rxMessageType <<= 8;
                        rxMessageState++;
                    }
                    break;

                    case 1:
                    {
                        rxMessageType |= (uint8_t)data[i];
                        rxMessageState++;
                    }
                    break;

                    case 2:
                    {
                        rxMessageLength = (uint8_t)data[i];
                        rxMessageLength <<= 8;
                        rxMessageState++;
                    }
                    break;

                    case 3:
                    {
                        rxMessageLength |= (uint8_t)data[i];
                        rxMessageState++;
                    }
                    break;

                    case 4:
                    {
                        rxMessageChecksum = (uint8_t)data[i];
                        rxMessageState++;
                    }
                    break;

                    default:
                    {
                        rxMessageData[rxMessageCount++] = (uint8_t)data[i];
                    }
                    break;
                }
            }
        //}
    }
}
