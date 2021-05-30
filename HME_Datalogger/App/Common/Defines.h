#ifndef DEFINES_H
#define DEFINES_H

#include <QStringList>

inline QStringList getListParam(QString params)
{
    return params.split(",");
}

#define DECLARE_VAR(TYPE, NAME) \
    private: \
        TYPE m_##NAME;\
    public: TYPE NAME() const \
    { \
        return m_##NAME; \
    } \
    void set##NAME(const TYPE &value) \
    { \
        m_##NAME = value; \
    }

/**************************Time*****************************/

#define DEFAULT_SERVER_PORT             11111
#define DEFAULT_SERVER_READ_INTERVAL    10000
#define DEFAULT_SEND_TO_SERVER_INTERVAL 300000

/*********************Define foder**************************/

#ifdef __WIN32
#define CEMS_SETTINGS_FOLDERPATH    "D://CEMS/"
#define CEMS_SETTINGS_FILENAME      "D://CEMS/cems.ini"
#define PH_DB                       "D://CEMS/dbCems.db"
#define PH_EXPORT_FOLDER            "D://CEMS/ExportData"
#elif __linux__
#define CEMS_SETTINGS_FOLDERPATH    "/user/CEMS/"
#define CEMS_SETTINGS_FILENAME      "/user/CEMS/cems.ini"
#define PH_DB                       "/user/CEMS/dbCems.db"
#define PH_EXPORT_FOLDER            "/user/CEMS/ExportData"
#endif

/********************Define value QML***********************/

#define SCREEN_WIDTH    1500
#define SCREEN_HEIGHT   1000
#define TOPBAR_HEIGHT   100

#define COMMAND_BUF_SIZE   50
/***********************************************************/

#define SENDEVENT(OBJECT, EVENTID, PARAM)   UIBridge::getInstance()->sendEvent(OBJECT, EVENTID, PARAM)

#define SETDPDATA(DPID, VALUE)  ManagerData::getInstance()->setData(DPID, VALUE)

#define GETDPDATA(DPID)         ManagerData::getInstance()->getData(DPID)

#define SETPROPERTY(OBJECT, PROPERTY, VALUE)    { \
                                                    if((!strcmp(OBJECT, ""))||(!m_screenView->objectName().compare(OBJECT))) {\
                                                        m_screenView->setProperty(PROPERTY, VALUE); \
                                                    } \
                                                    else { \
                                                        QList<QObject*> _uiObjects = m_screenView->findChildren<QObject*>(OBJECT); \
                                                        if (m_screenView->objectName() == OBJECT) \
                                                            m_screenView->setProperty(PROPERTY, VALUE); \
                                                        foreach (QObject* _uiObject, _uiObjects) {\
                                                            if (_uiObject) _uiObject->setProperty(PROPERTY, VALUE); \
                                                        } \
                                                    } \
                                                }

#define DECLARE_VAR(TYPE, NAME) \
    private: \
        TYPE m_##NAME;\
    public: TYPE NAME() const \
    { \
        return m_##NAME; \
    } \
    void set##NAME(const TYPE &value) \
    { \
        m_##NAME = value; \
    }

#endif // DEFINES_H
