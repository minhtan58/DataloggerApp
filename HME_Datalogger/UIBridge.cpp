#include "UIBridge.h"

UIBridge *UIBridge::m_uiBridge = nullptr;

UIBridge::UIBridge(QObject *parent) : QObject(parent){
}

UIBridge::~UIBridge(){
}

UIBridge *UIBridge::getInstance(){
    if(m_uiBridge == nullptr)
        m_uiBridge = new UIBridge();
    return m_uiBridge;
}

void UIBridge::sendEvent(QString objectName, int enumID, QString param){
    emit hmiEvent(objectName, enumID, param);
}

QString UIBridge::getDPData(int dpid)
{
    return ManagerData::getInstance()->getData(dpid);
}

void UIBridge::setDPData(int dpid, QVariant value)
{
    ManagerData::getInstance()->setData(dpid, value.toString());
}

void UIBridge::log(QString msg)
{
    qDebug() << msg;
}
