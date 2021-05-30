#include "SerialPortHandler.h"

SerialPortHandler::SerialPortHandler(QObject *parent) : QObject(parent) {
    m_serialPort = new MySerialPort();
    connect(m_serialPort, SIGNAL(readComplete()), this, SLOT(setData()), Qt::UniqueConnection);
    SETDPDATA(EnumID::DP_SERIALPORT_STATUS, "Connect");
}

SerialPortHandler::~SerialPortHandler() {
}

void SerialPortHandler::setData() {
    QStringList value = m_serialPort->getListData();
    //SETDPDATA(EnumID::DP_PORTCOM, value);
    qDebug() << "value[0] = " << value[0];
    switch (value[0].toInt())
    {
        case 0x8024:
        {
            switch (value[1].toInt())
            {
                case E_CHANEL_1:
                {
                    qDebug() << "E_CHANEL_1 : "  << value[2];
                    SETDPDATA(EnumID::DP_CHANEL_1, value[2]);
                }break;
                case E_CHANEL_2:
                {
                    qDebug() << "E_CHANEL_2 : "  << value[2];
                    SETDPDATA(EnumID::DP_CHANEL_2, value[2]);
                }break;

                case E_CHANEL_3:
                {
                    qDebug() << "E_CHANEL_3 : "  << value[2];
                    SETDPDATA(EnumID::DP_CHANEL_3, value[2]);
                }break;
                case E_CHANEL_4:
                {
                    qDebug() << "E_CHANEL_2 : "  << value[2];
                    SETDPDATA(EnumID::DP_CHANEL_4, value[2]);
                }break;
                case E_CHANEL_5:
                {
                    qDebug() << "E_CHANEL_2 : "  << value[2];
                    SETDPDATA(EnumID::DP_CHANEL_5, value[2]);
                }break;
                case E_CHANEL_6:
                {

                }break;
                case E_CHANEL_7:
                {

                }break;
                case E_CHANEL_8:
                {

                }break;
                case E_CHANEL_9:
                {

                }break;
                default:
                    break;
            }
        }break;

        case 0x8102:
        {
            qDebug() << "===Type = 0x8102====" << value[1] << value[2];;
        }break;

        default:
        {
            qDebug() << "Type = " << value[0].toInt();
        }break;
    }
}

void SerialPortHandler::updateAppData(int dpid)
{
    switch (dpid) {
//        case EnumID::DP_GENERAL_RADIUS: {
//            double valueVel = GETDPDATA(EnumID::DP_VEL).toDouble();
//            double radius = GETDPDATA(EnumID::DP_GENERAL_RADIUS).toDouble();
//            if(radius > 0 && valueVel > 0) {
//                double valueFlow = valueVel * 3.14 * radius * radius;
//                SETDPDATA(CEMSEnum::DP_FLOW, MCR_DPDATA_DOUBLE_STD(valueFlow, 2));
//            } else {
//                SETDPDATA(CEMSEnum::DP_FLOW, EMPTY_STR);
//            }
//            break;
//        }
        case EnumID::DP_SETTINGS_SERIALPORT_PORTNAME:
        case EnumID::DP_SETTINGS_SERIALPORT_BAUDRATE:
            qDebug() << "Request connect serial port";
            //emit requestConnectSerialPort();
            break;
        default:
            break;
    }
}

void SerialPortHandler::eventHandler(QString objectName, int eventId, QString param) {
    Q_UNUSED(objectName)
    switch (eventId) {
    case EnumID::HMI_CONNECTIONS_SERIALPORT:
    {
        QStringList paramList = getListParam(param);
        QString sPortName = paramList.at(0);
        QString sBaudrate = paramList.at(1);
        qDebug() << "EnumID::HMI_CONNECTIONS_SERIALPORT" << sPortName << sBaudrate;
        m_serialPort->openSerialPort(sPortName,sBaudrate);
        break;
    }

    case EnumID::HMI_TEST_CONNECTIONS_SERIALPORT:
    {
        break;
    }

    case EnumID::HMI_SEND_DATA_SERIALPORT:
    {
        //m_serialPort->writeData(param.toUtf8());
        QString buffer = "Hello\r";
        m_serialPort->writeData(buffer.toStdString().c_str());
        break;
    }

    case EnumID::HMI_REQUEST_START_NETWORK:
    {
        qDebug() << "HMI_REQUEST_START_NETWORK...";
        m_serialPort->startNetwork();
        break;
    }

    case EnumID::HMI_BUTTON_WIRELESS_TRANSMISSION_SETTING:
    {
        qDebug() << "HMI_BUTTON_WIRELESS_TRANSMISSION_SETTING..." << param;
        break;
    }

    case EnumID::HMI_BUTTON_LAN_TRANSMISSION_SETTING:
    {
        qDebug() << "HMI_BUTTON_LAN_TRANSMISSION_SETTING..." << param;
        break;
    }

    case EnumID::HMI_REQUEST_PERMIT_JOIN:
    {
        qDebug() << "HMI_REQUEST_PERMIT_JOIN...";
        m_serialPort->sendClusterOnOff(3,0x0110,9,8,7);
        break;
    }
    case EnumID::HMI_REQUEST_PERMIT_JOIN_STATE:
    {
        qDebug() << "HMI_REQUEST_PERMIT_JOIN_STATE...";
        //m_serialPort->vSendPermitRejoinStateRequest();
        m_serialPort->writeStringData(param);
        break;
    }

    case EnumID::HMI_BUTTON_SUBMIT_SYSTEM_SETTING:
    {
        qDebug() << "HMI_BUTTON_SUBMIT_SYSTEM_SETTING...";
        qDebug() << param;
        m_serialPort->writeStringData(param);
        break;
    }

    case EnumID::HMI_BUTTON_RESET_SYS_SETTING:
    {
        qDebug() << "HMI_REQUEST_PERMIT_JOIN_STATE...";
        m_serialPort->writeStringData(param);
        break;
    }

    default:
        break;
    }
}

void SerialPortHandler::updateSerialPortList()
{
    QStringList list;
    foreach (const QSerialPortInfo &serialInfo, QSerialPortInfo::availablePorts()) {
        if(!serialInfo.isBusy())
            list.append(serialInfo.portName());
    }
    if(GETDPDATA(EnumID::DP_SETTINGS_SERIALPORT_STATUS) == "1")
        list.append(GETDPDATA(EnumID::DP_SETTINGS_SERIALPORT_PORTNAME));

    qSort(list.begin(), list.end());

    QString listString = "";
    foreach (QString element, list) {
        listString += element + ",";
    }
    listString.remove(listString.length() - 1, 1);

    //qDebug()("List SerialPort: %s", listString.toStdString().data());

    SETDPDATA(EnumID::DP_SETTINGS_SERIALPORT_LIST_AVAIABLE_PORTNAME, listString);
}

void SerialPortHandler::readDConChanel(int chanel, int ampType)
{
    qDebug() << "Display screen -" << chanel << ampType;
//    QString chanelValue = m_dcon->getChanelValue(chanel);
//    bool isNumber = false;
//    double chanelNumber = chanelValue.toDouble(&isNumber);
//    if(!isNumber) {
//        DLOG("Read Chanel %f fail, value: %s", chanel, chanelValue.toStdString().data());
//        return;
//    }

//    //update ampere
//    SETDPDATA(ampType, chanelValue);

//    switch (ampType) {
//    case CEMSEnum::DP_AMP_AIR_O2: {
//        if(chanelNumber > AMP_MIN) {
//            double deltaO2 = 4.001;
//            double valueO2 = deltaO2 * HS_O2;
//            SETDPDATA(CEMSEnum::DP_AIR_O2, MCR_DPDATA_DOUBLE_STD(valueO2, 2));
//        } else {
//            SETDPDATA(CEMSEnum::DP_AIR_O2, EMPTY_STR);
//        }
//        break;
//    }

//    default:
//        break;
//    }
}
