#ifndef STRUCTS_H
#define STRUCTS_H

#include <QString>
#include  "Enum.h"

typedef struct {
    uint8_t  au8Buffer[COMMAND_BUF_SIZE];
    uint8_t  u8Pos;
}tsCommand;

typedef struct {
    QString valO2;
    QString valCO;
    QString valNO;
    QString valNOX;
    QString valSO2;
    QString valTEMP;
    QString valOPP;
    QString valDUSTPM;
    QString valVEL;
    QString valFLOW;
    QString id;
    QString time;
    QString data1;
    QString data2;
    QString data3;
} CemsDataRow;

#endif // STRUCTS_H
