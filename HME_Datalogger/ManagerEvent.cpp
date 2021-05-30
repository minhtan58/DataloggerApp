#include "ManagerEvent.h"

ManagerEvent::ManagerEvent(QObject *parent) : QObject(parent)
{
    qmlRegisterType<EnumID>("EnumID", 1, 0, "EnumID");
}

ManagerEvent::~ManagerEvent()
{}

void ManagerEvent::exec()
{
    ManagerData::getInstance();
    initWindow();
    m_baseThreads->start();
    showScreen(ICS_SETTING_OVERVIEW);
}

void ManagerEvent::initWindow()
{
    m_baseThreads = new BaseThreads(this);
    m_qmlValue = new QmlValues(this);
    m_engine.rootContext()->setContextProperty("UIBridge", UIBridge::getInstance());   //Tao cau noi giua QML va C++
    m_engine.rootContext()->setContextProperty("QmlValues", m_qmlValue);
    m_engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    m_screenAdapter = new ScreenAdapter(&m_engine, this);
    m_topBarAdapter = new TopBarAdapter(m_engine.rootObjects().at(0)->findChild<QQuickItem*>("topbarContainer"), this);

    connect(UIBridge::getInstance(), SIGNAL(hmiEvent(QString, int, QString)), this, SLOT(hmiHandle(QString, int,QString)));
    connect(ManagerData::getInstance(), SIGNAL(dataChanged(int)), m_topBarAdapter, SLOT(updateAppData(int)), Qt::UniqueConnection);
}

void ManagerEvent::showScreen(int screenId)
{
    qDebug() << "Display screen -" << screenId;
    if(m_screenAdapter && m_screenAdapter->getCurrentScreen() == screenId)
        return;

    m_screenAdapter->setScreenId(screenId);
    m_screenAdapter->createScreen();
    connect(ManagerData::getInstance(), SIGNAL(dataChanged(int)), m_screenAdapter, SLOT(updateAppdata(int)), Qt::UniqueConnection);
}

void ManagerEvent::showOverlay(int overlayId, int timeout, int layer, QString message)
{
    Q_UNUSED(message)
    qDebug() << "Display overlay - " << overlayId;
    QQuickItem *overlayScreen = m_engine.rootObjects().at(0)->findChild<QQuickItem*>("overlayContainer");
    if(!overlayScreen){
        qDebug() << "OverlayScreen null";
        return;
    }

    if(layer > Z_BACKGROUND)
        overlayScreen->setProperty("z", QVariant::fromValue(layer));

    overlayScreen->setProperty("source", QVariant::fromValue(mapScreen.value(overlayId)));
    QObject *overlay = qvariant_cast<QObject*>(overlayScreen->property("item"));
    overlay->setProperty("timeout", QVariant::fromValue(timeout));
    if(!message.isEmpty())
        overlay->setProperty("message", QVariant::fromValue(message));
}

void ManagerEvent::hideOverlay()
{
    QQuickItem *overlayScreen = m_engine.rootObjects().at(0)->findChild<QQuickItem*>("overlayContainer");
    if(!overlayScreen) {
        qDebug() << "OverlayScreen null";
        return;
    }

    overlayScreen->setProperty("source", "");
}

void ManagerEvent::hmiHandle(QString objectName, int EnumID, QString param)
{
    Q_UNUSED(objectName)
    Q_UNUSED(param)
    switch (EnumID) {
        case EnumID::HMI_HOME_SCREEN:
        {
            showScreen(ICS_HOME);
        }
        break;
        case EnumID::HMI_CONNECTION_PORTCOM_SCREEN:
        {
            showScreen(ICS_CONNECTION_PORTCOM);
        }
        break;
        case EnumID::HMI_CONNECTION_NETWORK_SCREEN:
        {
            showScreen(ICS_CONNECTION_NETWORK);
        }
        break;
        case EnumID::HMI_TAB_SELECT:
        {
            if(param == "overview" || param.isEmpty()) {
                showScreen(ICS_SETTING_OVERVIEW);
            } else if(param == "general") {
                showScreen(ICS_SETTING_SERIALPORT);
            } else if(param == "network") {
                showScreen(ICS_SETTING_SERIALPORT);
            } else if(param == "serialport") {
                showScreen(ICS_SETTING_SERIALPORT);
            } else if(param == "aircoefficient") {
                showScreen(ICS_SETTING_SERIALPORT);
            } else if(param == "data") {
                showScreen(ICS_SENSOR_STATUS);
            } else if(param == "development") {
                showScreen(ICS_SETTING_SERIALPORT);
            }else if(param == "iosetting"){
                showScreen(ICS_SETTING_IO_SETTING);
            }else if(param == "systemsetting"){
                showScreen(ICS_SETTING_SYSTEM_SETTING);
            }else if(param == "transmisssetting"){
                showScreen(ICS_SETTING_TRANSMISSION_SETTING);
            }else if(param == "alarm"){
                showScreen(ICS_SETTING_ALARM_SETTING);
            }
            break;
        }

        case EnumID::HMI_SENSOR_STATUS_SCREEN:
        {
            showScreen(ICS_SENSOR_STATUS);
        }
        break;
        case EnumID::HMI_SETTINGS:
        {
            showScreen(ICS_SETTINGS);
        }
        break;
        case EnumID::HMI_VIEW_DATA_HISTORY_SCREEN:
        {
            showScreen(ICS_HISTORY_DATAVIEW);
        }
        break;
        case EnumID::HMI_SETTING_OVERVIEW_SCREEN:
        {
            showScreen(ICS_SETTING_OVERVIEW);
        }
        break;
        case EnumID::HMI_SETTING_ALARM_SCREEN:
        {
            showScreen(ICS_SETTING_ALARM_SETTING);
        }
        break;
        case EnumID::HMI_HIDE_POPUP:
        {
            hideOverlay();
        }
        break;
        case EnumID::HMI_LOGIN_FORM:
        {
            showScreen(ICS_LOGIN_FORM);
        }
        break;
        case EnumID::HMI_CONNECTED_POPUP:
        {
            showOverlay(ICP_CONNECT_POPUP, 3000);
        }
        break;
        case EnumID::HMI_DISCONNECTED_POPUP:
        {
            showOverlay(ICP_DISCONNECT_POPUP, 3000);
        }
        break;
        case EnumID::HMI_SHOW_DATA:
        {
            qDebug() << "==HMI_SHOW_DATA==";
            //SETDPDATA(EnumID::DP_AIR_O2, param);
        }
        break;
        default:
        break;
    }
}
