//#ifndef HISTORYDATA_H
//#define HISTORYDATA_H

//#include <QObject>
//#include <QThread>

//#include "ManagerData.h"
//#include "UIBridge.h"
//#include "MyHistoryData.h"

//class HistoryDataHandler : public QObject
//{
//    Q_OBJECT
//public:
//    explicit HistoryDataHandler(QObject *parent = 0);

//signals:

//public slots:
//    void eventHandler(QString objectName, int eventId, QString param);
//};

//class HistoryDataHandlerThread : public QThread
//{
//    Q_OBJECT
//public:
//    HistoryDataHandlerThread(QObject *parent = nullptr) : QThread(parent) {}

//protected:
//    void run() {
//        qDebug() << "Start Thread HistoryData";
//        HistoryDataHandler handler;
//        connect(UIBridge::getInstance(), SIGNAL(hmiEvent(QString,int,QString)), &handler, SLOT(eventHandler(QString,int,QString)));
//        exec();
//    }
//};

//#endif // HISTORYDATA_H
