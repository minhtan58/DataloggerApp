#include "QmlValues.h"

QmlValues::QmlValues(QObject *parent) : QObject(parent)
  , m_currentTime("")
  , m_currentDate("")
  , m_screenWidth(SCREEN_WIDTH)
  , m_screenHeight(SCREEN_HEIGHT)
  , m_topbarHeight(TOPBAR_HEIGHT)
  , m_backgroundZ(Z_BACKGROUND)
  , m_appContainerZ(Z_SCREENCONTAINER)
  , m_topbarZ(Z_TOPBAR)
  , m_keyboardZ(Z_KEYBOARD)
  , m_overlayZ(Z_OVERLAY)
  , m_splashZ(Z_SPLASH)
{}

int QmlValues::screenWidth() const
{
    return m_screenWidth;
}

int QmlValues::screenHeight() const
{
    return m_screenHeight;
}

int QmlValues::topbarHeight() const
{
    return m_topbarHeight;
}

int QmlValues::backgroundZ() const
{
    return m_backgroundZ;
}

int QmlValues::appContainerZ() const
{
    return m_appContainerZ;
}

int QmlValues::overlayZ() const
{
    return m_overlayZ;
}

QString QmlValues::currentTime() const
{
    return m_currentTime;
}

void QmlValues::setCurrentTime(const QString &currentTime)
{
    if(m_currentTime != currentTime) {
        m_currentTime = currentTime;
        emit currentTimeChanged();
    }
}

QString QmlValues::currentDate() const
{
    return m_currentDate;
}

void QmlValues::setCurrentDate(const QString &currentDate)
{
    if(m_currentDate != currentDate) {
        m_currentDate = currentDate;
        emit currentDateChanged();
    }
}

QString QmlValues::stationName() const
{
    return m_stationName;
}

void QmlValues::setStationName(const QString &stationName)
{
    if(m_stationName != stationName) {
        m_stationName = stationName;
        emit stationNameChanged();
    }
}

QString QmlValues::stationId() const
{
    return m_stationId;
}

void QmlValues::setStationId(const QString &stationId)
{
    if(m_stationId != stationId) {
        m_stationId = stationId;
        emit stationIdChanged();
    }
}

int QmlValues::splashZ() const
{
    return m_splashZ;
}

int QmlValues::topbarZ() const
{
    return m_topbarZ;
}

int QmlValues::keyboardZ() const
{
    return m_keyboardZ;
}
