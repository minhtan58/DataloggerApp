#ifndef QMLVALUES_H
#define QMLVALUES_H

#include <QObject>

#include "Defines.h"
#include "Enum.h"

class QmlValues : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int screenWidth      READ screenWidth    CONSTANT)
    Q_PROPERTY(int screenHeight     READ screenHeight   CONSTANT)
    Q_PROPERTY(int topbarHeight     READ topbarHeight   CONSTANT)
    Q_PROPERTY(int backgroundZ      READ backgroundZ    CONSTANT)
    Q_PROPERTY(int appContainerZ    READ appContainerZ  CONSTANT)
    Q_PROPERTY(int overlayZ         READ overlayZ       CONSTANT)
    Q_PROPERTY(int topbarZ          READ topbarZ       CONSTANT)
    Q_PROPERTY(int keyboardZ        READ keyboardZ      CONSTANT)
    Q_PROPERTY(int splashZ          READ keyboardZ      CONSTANT)
    Q_PROPERTY(QString currentTime  READ currentTime    WRITE setCurrentTime    NOTIFY currentTimeChanged)
    Q_PROPERTY(QString currentDate  READ currentDate    WRITE setCurrentDate    NOTIFY currentDateChanged)
    Q_PROPERTY(QString stationId    READ stationId      WRITE setStationId      NOTIFY stationIdChanged)
    Q_PROPERTY(QString stationName  READ stationName    WRITE setStationName    NOTIFY stationNameChanged)
public:
    explicit QmlValues(QObject *parent = nullptr);

    int screenWidth() const;
    int screenHeight() const;
    int topbarHeight() const;
    int backgroundZ() const;
    int appContainerZ() const;
    int overlayZ() const;
    int topbarZ() const;
    int keyboardZ() const;
    int splashZ() const;

    QString currentTime() const;
    void setCurrentTime(const QString &currentTime);

    QString currentDate() const;
    void setCurrentDate(const QString &currentDate);

    QString stationName() const;
    void setStationName(const QString &stationName);

    QString stationId() const;
    void setStationId(const QString &stationId);

signals:
    void currentTimeChanged();
    void currentDateChanged();
    void stationNameChanged();
    void stationIdChanged();

public slots:

private:
    //system time
    QString m_currentTime;
    QString m_currentDate;

    //station
    QString m_stationName;
    QString m_stationId;

    int m_screenWidth;
    int m_screenHeight;
    int m_topbarHeight;

    int m_backgroundZ;
    int m_appContainerZ;
    int m_topbarZ;
    int m_keyboardZ;
    int m_overlayZ;
    int m_splashZ;
};

#endif // QMLVALUES_H
