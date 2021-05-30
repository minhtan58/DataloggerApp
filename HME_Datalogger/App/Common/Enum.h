#ifndef ENUM_H
#define ENUM_H

#include <QObject>
#include <QHash>
#include "Defines.h"

class EnumID: public QObject
{
    Q_OBJECT
    Q_ENUMS(_DatapoolID)
    Q_ENUMS(_HMIEvent)

public:
    typedef enum _DatapoolID{
        DP_TIME = 0x0000,
        DP_DATE,
        DP_HOUR,
        DP_MINUTES,
        DP_DAY,
        DP_MONTH,
        DP_YEAR,
        DP_STATUS_ALARM_ON_COUNT,

        DP_DATE_DAY,
        DP_DATE_MONTH,
        DP_DATE_YEAR,

        DP_SYS_SETTINGS_TIME_AUTOMATIC_UPDATE,
        DP_GENERAL_STATION_ID,
        DP_GENERAL_STATION_NAME,
        DP_GENERAL_RADIUS,

        /* SerialPort */
        DP_PORTCOM,
        DP_SERIALPORT_STATUS,
        DP_SETTINGS_SERIALPORT_PORTNAME,
        DP_SETTINGS_SERIALPORT_BAUDRATE,
        DP_SETTINGS_SERIALPORT_INTERVAL,
        DP_SETTINGS_SERIALPORT_STATUS,
        DP_SETTINGS_SERIALPORT_TEST_CONNECTION,
        DP_SETTINGS_SERIALPORT_LIST_AVAIABLE_PORTNAME,

        DP_NETWORK,
        DP_NETWORK_STATUS,

        DP_SYS_DATE_DAY,
        DP_SEARCH_TIME_HISTORY_DATA,

        DP_SETTINGS_NETWORK_SERVER_INTERVAL,

        //-----------------CHANEL-----------------//

        DP_CHANEL_1,
        DP_CHANEL_2,
        DP_CHANEL_3,
        DP_CHANEL_4,
        DP_CHANEL_5,
        DP_CHANEL_6,
        DP_CHANEL_7,
        DP_CHANEL_8,
        DP_CHANEL_9,
        DP_CHANEL_10,
        DP_CHANEL_11,
        DP_CHANEL_12,
        DP_CHANEL_13,
        DP_CHANEL_14,
        DP_CHANEL_15,
        DP_CHANEL_16,
        DP_CHANEL_17,
        DP_CHANEL_18,
        DP_CHANEL_19
   }DatapoolID;

     typedef enum _HMIEvent{
        /* Show screen */
        HMI_HOME_SCREEN,
        HMI_CONNECTION_PORTCOM_SCREEN,
        HMI_CONNECTION_NETWORK_SCREEN,
        HMI_VIEW_DATA_HISTORY_SCREEN,
        HMI_SETTING_OVERVIEW_SCREEN,
        HMI_SETTING_ALARM_SCREEN,
        HMI_SENSOR_STATUS_SCREEN,
        HMI_SETTINGS,
        HMI_TAB_SELECT,
        HMI_LOGIN_FORM,

        /* Show popup */
        HMI_COMMON_POPUP,
        HMI_HIDE_POPUP,
        HMI_CONNECTED_POPUP,
        HMI_DISCONNECTED_POPUP,
        HMI_REQUEST_SHOW_EXPORT_POPUP,

        /* Connection */
        HMI_CONNECTIONS_SERIALPORT,
        HMI_TEST_CONNECTIONS_SERIALPORT,
        HMI_SEND_DATA_SERIALPORT,
        HMI_TEST_CONNECTIONS_NETWORK,
        HMI_SEND_DATA_NETWORK,

        /* Setting Time */
        HMI_UPDATE_TIME_AUTOMATIC,
        HMI_SET_DATE_TIME,

        /* Database */
        HMI_UPDATE_DATABASE,
        HMI_REMOVE_DATABASE,
        HMI_REQUEST_GET_HISTORY_DATA,
        HMI_RESPONSE_GET_HISTORY_DATA_FINISHED,
        HMI_REQUEST_ADD_MISSING_DATA_ROW,
        HMI_REQUEST_REMOVE_MISSING_DATA_ROW,
        HMI_BUTTON_REQ_EXPORT,

        /* Coordinator Request */
        HMI_REQUEST_START_NETWORK,
        HMI_REQUEST_PERMIT_JOIN,
        HMI_REQUEST_PERMIT_JOIN_STATE,

        HMI_SHOW_DATA,

        HMI_BUTTON_SUBMIT_SYSTEM_SETTING,
        HMI_BUTTON_RESET_SYS_SETTING,
        HMI_BUTTON_WIRELESS_TRANSMISSION_SETTING,
        HMI_BUTTON_LAN_TRANSMISSION_SETTING

    }HMIEvent;
};

//***********************************************************************************************//

enum  ScreenID{
    ICS_HOME = 0x0000,
    ICS_CONNECTION_PORTCOM,
    ICS_CONNECTION_NETWORK,
    ICS_DATA_VIEW,
    ICS_SENSOR_STATUS,
    ICS_HISTORY_DATAVIEW,
    ICS_SETTING_OVERVIEW,
    ICS_SETTING_SERIALPORT,
    ICS_SETTING_SYSTEM_SETTING,
    ICS_SETTING_IO_SETTING,
    ICS_SETTING_TRANSMISSION_SETTING,
    ICS_SETTING_ALARM_SETTING,
    ICS_LOGIN_FORM,
    ICS_SETTINGS,

    ICP_COMMON_POPUP = 0xA000,
    ICP_CONNECT_POPUP,
    ICP_DISCONNECT_POPUP,
};

const QHash<int, QString> mapScreen = {
    {ICS_HOME,                             "qrc:/Ui/Screen/ics_home.qml"                     },
    {ICS_CONNECTION_PORTCOM,               "qrc:/Ui/Screen/ics_connection_portcom.qml"       },
    {ICS_CONNECTION_NETWORK,               "qrc:/Ui/Screen/ics_connection_network.qml"       },
    {ICS_SENSOR_STATUS,                    "qrc:/Ui/Screen/ics_sensor_status.qml"            },
    {ICS_HISTORY_DATAVIEW,                 "qrc:/Ui/Screen/ics_view_data_history.qml"        },
    {ICS_SETTING_OVERVIEW,                 "qrc:/Ui/Screen/ics_settings_overview.qml"        },
    {ICS_SETTING_SERIALPORT,               "qrc:/Ui/Screen/ics_settings_serialport.qml"      },
    {ICS_SETTING_SYSTEM_SETTING,           "qrc:/Ui/Screen/ics_settings_system.qml"          },
    {ICS_SETTING_TRANSMISSION_SETTING,     "qrc:/Ui/Screen/ics_settings_transmission.qml"    },
    {ICS_SETTING_IO_SETTING,               "qrc:/Ui/Screen/ics_settings_io.qml"              },
    {ICS_SETTING_ALARM_SETTING,            "qrc:/Ui/Screen/ics_setting_alarm.qml"           },
    {ICS_LOGIN_FORM,                       "qrc:/Ui/Screen/ics_login_form.qml"               },
    {ICS_SETTINGS,                         "qrc:/Ui/Screen/ics_settings.qml"                 },

    {ICP_CONNECT_POPUP,                    "qrc:/Ui/Screen/icp_connect_popup.qml"            },
    {ICP_DISCONNECT_POPUP,                 "qrc:/Ui/Screen/icp_disconnect_popup.qml"         },
    {ICP_COMMON_POPUP,                     "qrc:/Ui/Screen/icp_common_popup.qml"             },
};

//***********************************************************************************************//

enum OverlayZ{
    Z_BACKGROUND = -1,
    Z_SCREENCONTAINER,
    Z_TOPBAR,
    Z_KEYBOARD,
    Z_OVERLAY,
    Z_SPLASH
};

enum TestConnection {
    IS_CONNECT_FAIL,
    IS_CHECKING,
    IS_CONNECTED,
    IS_DISCONNECTED,
};

enum FetchDataStatus {
    FETCH_IDLE,
    FETCH_STARTING,
    FETCH_FINISHED
};

enum eChanel {
    E_CHANEL_1 = 0x01,
    E_CHANEL_2,
    E_CHANEL_3,
    E_CHANEL_4,
    E_CHANEL_5,
    E_CHANEL_6,
    E_CHANEL_7,
    E_CHANEL_8,
    E_CHANEL_9,
    E_CHANEL_10,
    E_CHANEL_11,
    E_CHANEL_12,
    E_CHANEL_13,
    E_CHANEL_14,
    E_CHANEL_15,
    E_CHANEL_16,
    E_CHANEL_17,
    E_CHANEL_18,
    E_CHANEL_19
};

typedef enum
{
    /* Common id */
    E_SL_MSG_SENSOR_STATUS_RESPONSE                            =   0x8000,
    E_SL_MSG_LOG                                               =   0x8001,

    E_SL_MSG_NETWORK_STATE_REQ                                 =   0x0009,
    E_SL_MSG_NETWORK_STATE_RSP                                 =   0x8009,
} teSL_MsgType;

#endif // ENUM_H
