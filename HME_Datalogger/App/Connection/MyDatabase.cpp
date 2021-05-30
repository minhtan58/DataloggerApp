#include "MyDatabase.h"

MyDatabase* MyDatabase::m_database = nullptr;

MyDatabase::MyDatabase(QObject *parent) : QObject(parent)
{
    createDatabase();
}

MyDatabase::~MyDatabase() {
    QSqlDatabase::removeDatabase("QSQLITE");
}

MyDatabase *MyDatabase::getInstance() {
    if(m_database == nullptr) {
        qDebug() << "MyDatabase null";
        m_database = new MyDatabase();
    }
    return m_database;
}

bool MyDatabase::isDbExists()
{
    return QFile::exists("D://My_project/Test/minhtan.db");
}

//void MyDatabase::initDatabase() {
//    if(isDbExists()) {
//        QSqlDatabase database = QSqlDatabase::database();
//        if (!database.tables().contains("HistoryData")) {
//            createHistoryDataTable();
//            qDebug() << "Can't load Database - Need create data base";
//        }
//    }
//}

void MyDatabase::createDatabase() {
    if(!QSqlDatabase::drivers().contains("QSQLITE")) {
        qDebug() << "Can't load Database - Need create data base";
    }

    QSqlDatabase database = QSqlDatabase::addDatabase("QSQLITE");
    database.setDatabaseName("D://My_project/Test/minhtan2.db");
    if(database.open()) {
        qDebug() << "Have Created Database";
    } else {
        qDebug() << "Error open Database" << database.lastError();
    }

    const QString createSQL = "CREATE TABLE IF NOT EXISTS HistoryData "
                              "(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
                              "data1 VARCHAR(255) NOT NULL,"
                              "data2 INTERGER)";
    QSqlQuery m_query;
    if(m_query.exec(createSQL)) {
        qDebug() << "Tabale have crete successfully";
    } else {
        qDebug() << "Create table error";
    }
    m_query.exec("INSERT INTO HistoryData(data1,data2)VALUE('minh', 0208)");
    m_query.exec("INSERT INTO HistoryData(data1,data2)VALUE('minh2',1995)");
    m_query.exec("SELECT * FROM HistoryData");
    while(m_query.next()) {
        qDebug() << m_query.value("id").toInt();
        qDebug() << m_query.value("data1").toString();
        qDebug() << m_query.value("data2").toInt();
        qDebug() << "Minhtan database.....";
    }
    qDebug() << "Minhtan database";
}

void MyDatabase::createHistoryDataTable() {
    //QSqlDatabase database = QSqlDatabase::database();
    const QString createSQL = "CREATE TABLE IF NOT EXISTS HistoryData "
                              "(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
                              "data1 VARCHAR(255) NOT NULL,"
                              "data2 INTERGER)";
    QSqlQuery m_query;
    if(m_query.exec(createSQL)) {
        qDebug() << "Tabale have crete successfully";
    } else {
        qDebug() << "Create table error";
    }
    m_query.exec("INSERT INTO HistoryData(data1,data2)VALUE('minh', 0208)");
    m_query.exec("INSERT INTO HistoryData(data1,data2)VALUE('minh2',1995)");
    m_query.exec("SELECT * FROM HistoryData");
    while(m_query.next()) {
        qDebug() << m_query.value("id").toInt();
        qDebug() << m_query.value("data1").toString();
        qDebug() << m_query.value("data2").toInt();
        qDebug() << "Minhtan database.....";
    }
    qDebug() << "Minhtan database";
}

QList<CemsDataRow> MyDatabase::getHistoryData(QString time)
{
    QSqlDatabase database = QSqlDatabase::database();
    if (!database.tables().contains("HistoryData")) {
        qDebug() << "Select record error: HistoryData table does not exist.";
    } else {
        QSqlQuery query(database);
        QString command = QString("SELECT * FROM HistoryData "
                                  "WHERE time "
                                  "BETWEEN '%1 00:00:00' "
                                  "AND '%2 23:59:59' "
                                  "ORDER BY datetime(time);").arg(time).arg(time);
        query.prepare(command);
        if (query.exec()) {
            QList<CemsDataRow> list;
            while(query.next()) {
                CemsDataRow element;
                QSqlRecord record = query.record();
                element.time = record.value("time").toString();
                element.id = record.value("id").toString();
                element.data1 = record.value("data1").toString();
                element.data2 = record.value("data2").toString();
                element.data3 = record.value("data3").toString();
                list.append(element);
            }
            database.close();
            return list;
        } else {
            qDebug() << "Select record error: HistoryData table does not exist.";
        }
    }

    database.close();
    return QList<CemsDataRow>();
}

void MyDatabase::removeOldHistoryData(int day)
{
    QSqlDatabase database = QSqlDatabase::database();
    if (!database.tables().contains("HistoryData")) {
        qDebug() << "Create record error: Accounts table does not exist.";
    } else {
        QSqlQuery query(database);

        QString command = QString("DELETE FROM HistoryData WHERE time < datetime('now', '-%1 day');").arg(day);
        query.prepare(command);
        if (query.exec()) {
            qDebug() << "Exec delete command done";
        } else {
            qDebug() << "Exec delete command error";
        }
    }
    database.close();
}
