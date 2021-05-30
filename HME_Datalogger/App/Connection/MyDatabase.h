#ifndef MYDATABASE_H
#define MYDATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlResult>
#include <QSqlError>
#include <QFile>
#include <QDebug>

#include "ManagerData.h"
typedef struct {
    QString time;
    QString data1;
    QString data2;
} DataRow;

class MyDatabase : public QObject
{
    Q_OBJECT
public:
    explicit MyDatabase(QObject *parent = nullptr);
    ~MyDatabase();
    static MyDatabase *getInstance();

    void createDatabase();
    bool isDbExists();
    //void initDatabase();
    void createHistoryDataTable();
    void createMissingDataTable();
    void addHistoryDataRow(QString time, QString data1, QString data2);
    void removeOldHistoryData(int day);
    QList<CemsDataRow> getHistoryData(QString time);

signals:

public slots:

private:
    static MyDatabase *m_database;
};

#endif // MYDATABASE_H
