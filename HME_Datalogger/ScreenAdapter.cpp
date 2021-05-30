#include "ScreenAdapter.h"

ScreenAdapter::ScreenAdapter(QQmlApplicationEngine *qmlAppEngine, QObject *parent)
    : QObject(parent)
    , m_qmlAppEngine(qmlAppEngine)
    , m_screenId(-1)
{
    m_qmlAppEngine->rootContext()->setContextProperty("listHistory", nullptr);
    m_screenContainer = m_qmlAppEngine->rootObjects().at(0)->findChild<QQuickItem*>("screenContainer");
    connect(UIBridge::getInstance(), SIGNAL(hmiEvent(QString,int,QString)), this, SLOT(eventHandler(QString,int,QString)));
}

ScreenAdapter::~ScreenAdapter()
{}

void ScreenAdapter::createScreen() {
    qDebug() << "Load screen starting...";
    m_screenContainer->setProperty("source", mapScreen.value(m_screenId));
    m_screenView = qvariant_cast<QObject*>(m_screenContainer->property("item"));
    initAppData();
    qDebug() << "Load screen " << m_screenId << "done";
}

int ScreenAdapter::getCurrentScreen() {
    return m_screenId;
}

void ScreenAdapter::setScreenId(int screenId) {
    m_screenId = screenId;
}

void ScreenAdapter::initAppData() {
    switch (m_screenId) {
    case ICS_DATA_VIEW: {
        qDebug() << "Minhtan";
        SETPROPERTY("chanel1", "textValue",  GETDPDATA(EnumID::DP_CHANEL_1));
        SETPROPERTY("chanel2", "textValue",  GETDPDATA(EnumID::DP_CHANEL_2));
        SETPROPERTY("chanel3", "textValue",  GETDPDATA(EnumID::DP_CHANEL_3));
        SETPROPERTY("chanel4", "textValue",  GETDPDATA(EnumID::DP_CHANEL_4));
        SETPROPERTY("chanel5", "textValue",  GETDPDATA(EnumID::DP_CHANEL_5));
        break;
    }
    case ICS_CONNECTION_PORTCOM: {
        SETPROPERTY("connection_status", "text", GETDPDATA(EnumID::DP_SERIALPORT_STATUS));
        SETPROPERTY("viewData_portcom", "text", GETDPDATA(EnumID::DP_PORTCOM));
        break;
    }
    case ICS_SETTING_SERIALPORT: {
        SETPROPERTY("connection_status", "text", GETDPDATA(EnumID::DP_SERIALPORT_STATUS));
        break;
    }
    case ICS_CONNECTION_NETWORK: {
        SETPROPERTY("connection_status", "text", GETDPDATA(EnumID::DP_NETWORK_STATUS));
        SETPROPERTY("viewData_network", "text", GETDPDATA(EnumID::DP_NETWORK));
        break;
    }
    case ICS_HOME: {
        SETPROPERTY("viewO2", "textValue", GETDPDATA(EnumID::DP_DATE));
        break;
    }
    case ICS_HISTORY_DATAVIEW: {
        SETPROPERTY("dateSelected", "datetime", GETDPDATA(EnumID::DP_SEARCH_TIME_HISTORY_DATA));
        break;
    }
    default:
        break;
    }
}

void ScreenAdapter::updateAppdata(int dpid) {
    QString data = GETDPDATA(dpid);
    switch (dpid) {
        case EnumID::DP_PORTCOM:
        {
            if(m_screenId == ICS_DATA_VIEW) {
                SETPROPERTY("data_portcom", "text", data);
            } else if (m_screenId == ICS_CONNECTION_PORTCOM) {
                SETPROPERTY("viewData_portcom", "text", data);
            }
            break;
        }
        case EnumID::DP_SERIALPORT_STATUS:
        {
            if(m_screenId == ICS_CONNECTION_PORTCOM ) {
                SETPROPERTY("connection_status", "text", data);
            }
            if(m_screenId == ICS_SETTING_SERIALPORT ) {
                SETPROPERTY("connection_status", "text", data);
            }
            break;
        }
        case EnumID::DP_NETWORK:
        {
            if(m_screenId == ICS_DATA_VIEW) {
                SETPROPERTY("data_network", "text", data);
            } else if (m_screenId == ICS_CONNECTION_NETWORK) {
                SETPROPERTY("viewData_network", "text", data);
            }
            break;
        }
        case EnumID::DP_NETWORK_STATUS:
        {
            if(m_screenId == ICS_CONNECTION_NETWORK ) {
                SETPROPERTY("connection_status", "text", data);
            }
            break;
        }
        case EnumID::DP_SEARCH_TIME_HISTORY_DATA:
        {
            SETPROPERTY("dateSelected", "datetime", GETDPDATA(EnumID::DP_SEARCH_TIME_HISTORY_DATA));
            break;
        }
        case EnumID::DP_SYS_DATE_DAY:
        {
            SETDPDATA(EnumID::DP_SEARCH_TIME_HISTORY_DATA,
                      QString("%1-%2-%3")
                      .arg(GETDPDATA(EnumID::DP_DATE_YEAR))
                      .arg(GETDPDATA(EnumID::DP_DATE_MONTH))
                      .arg(GETDPDATA(EnumID::DP_SYS_DATE_DAY)));
            break;
        }
        case EnumID::DP_CHANEL_1:
        {
            SETPROPERTY("chanel1", "textValue", data);
            break;
        }
        case EnumID::DP_CHANEL_2:
        {
            SETPROPERTY("chanel2", "textValue", data);
            break;
        }
        case EnumID::DP_CHANEL_3:
        {
            SETPROPERTY("chanel3", "textValue", data);
            break;
        }
        case EnumID::DP_CHANEL_4:
        {
            SETPROPERTY("chanel4", "textValue", data);
            break;
        }
        case EnumID::DP_CHANEL_5:
        {
            SETPROPERTY("chanel5", "textValue", data);
            break;
        }
        default:
            break;
    }
}

void ScreenAdapter::eventHandler(QString objectName, int eventId, QString param)
{
    Q_UNUSED(objectName)
    switch (eventId) {
    case EnumID::HMI_REQUEST_GET_HISTORY_DATA: {
        qDebug() << "ScreenAdapter::eventHandler HMI_REQUEST_GET_HISTORY_DATA";
        //SETDPDATA(EnumID::DP_SEARCH_TIME_HISTORY_DATA, param);
        if(m_listHistory) {
            m_listHistory->~HistoryDataModel();
            m_qmlAppEngine->rootContext()->setContextProperty("listHistory", nullptr);
        }
        break;
    }
    case EnumID::HMI_RESPONSE_GET_HISTORY_DATA_FINISHED: {
        qDebug() << "ScreenAdapter::eventHandler HMI_RESPONSE_GET_HISTORY_DATA_FINISHED";
        m_listHistory = new HistoryDataModel(this);
        m_listHistory->fetchData();
        m_qmlAppEngine->rootContext()->setContextProperty("listHistory", m_listHistory);
        emit m_listHistory->slotUpdateFetchDataStatus(FETCH_FINISHED);
        break;
    }
    default:
        break;
    }
}
