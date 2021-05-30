QT += quick

QT += qml quick serialport sql
CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

INCLUDEPATH += \
    $$PWD/App/Common \
    $$PWD/App/Connection \
    $$PWD/App/Threads \

SOURCES += \
        App/Common/QmlValues.cpp \
        App/Connection/MyDatabase.cpp \
        App/Connection/MyHistoryData.cpp \
        App/Connection/MySerialPort.cpp \
        App/Connection/MyTcpSocket.cpp \
        App/QmlModel/HistoryDataListModel.cpp \
        App/Threads/BaseThreads.cpp \
        App/Threads/DatabaseHandler.cpp \
        App/Threads/HistoryDataHandler.cpp \
        App/Threads/SerialPortHandler.cpp \
        App/Threads/TcpSocketHandler.cpp \
        App/Threads/TimeHandler.cpp \
        ManagerData.cpp \
        ManagerEvent.cpp \
        ScreenAdapter.cpp \
        TopBarAdapter.cpp \
        UIBridge.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    App/Common/Defines.h \
    App/Common/Enum.h \
    App/Common/QmlValues.h \
    App/Common/Structs.h \
    App/Connection/MyDatabase.h \
    App/Connection/MyHistoryData.h \
    App/Connection/MySerialPort.h \
    App/Connection/MyTcpSocket.h \
    App/QmlModel/HistoryDataListModel.h \
    App/Threads/BaseThreads.h \
    App/Threads/DatabaseHandler.h \
    App/Threads/HistoryDatahandler.h \
    App/Threads/SerialPortHandler.h \
    App/Threads/TcpSocketHandler.h \
    App/Threads/TimeHandler.h \
    ManagerData.h \
    ManagerEvent.h \
    ScreenAdapter.h \
    TopBarAdapter.h \
    UIBridge.h

DISTFILES += \
    backend.js
