#ifndef BASETHREADS_H
#define BASETHREADS_H

#include <QObject>

#include "SerialPortHandler.h"
#include "TcpSocketHandler.h"
#include "DatabaseHandler.h"
#include "TimeHandler.h"

class BaseThreads : public QObject
{
    Q_OBJECT
public:
    explicit BaseThreads(QObject *parent = nullptr);
    ~BaseThreads();
    void start();

private:
    SerialPortHandlerThread *m_serialPortHandler = nullptr;
    TcpSocketHandlerThread *m_tcpSocketHandler = nullptr;
    DatabaseHandlerThread *m_databaseHandler = nullptr;
    TimeHandlerThread *m_timeHandler = nullptr;

signals:

public slots:

};

#endif // BASETHREADS_H
