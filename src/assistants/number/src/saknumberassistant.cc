﻿/***************************************************************************************************
 * Copyright 2020-2024 Qsaker(qsaker@foxmail.com). All rights reserved.
 *
 * The file is encoded using "utf8 with bom", it is a part of QtSwissArmyKnife project.
 *
 * QtSwissArmyKnife is licensed according to the terms in the file LICENCE in the root of the source
 * code directory.
 **************************************************************************************************/
#include "saknumberassistant.h"
#include "ui_saknumberassistant.h"

#include "sakdatastructure.h"
#include "sakinterface.h"

SAKNumberAssistant::SAKNumberAssistant(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::SAKNumberAssistant)
{
    ui->setupUi(this);
    m_interface = new SAKInterface(this);
    m_interface->setLineEditValidator(ui->lineEditRawData, SAKInterface::ValidatorHex);
    m_interface->setLineEditValidator(ui->lineEditCookedDec, SAKInterface::ValidatorDec);

    ui->comboBoxCookedDataType->addItem("int8_t", CookedDataTypeInt8);
    ui->comboBoxCookedDataType->addItem("uint8_t", CookedDataTypeUint8);
    ui->comboBoxCookedDataType->addItem("int16_t", CookedDataTypeInt16);
    ui->comboBoxCookedDataType->addItem("uint16_t", CookedDataTypeUint16);
    ui->comboBoxCookedDataType->addItem("int32_t", CookedDataTypeInt32);
    ui->comboBoxCookedDataType->addItem("uint32_t", CookedDataTypeUint32);
    ui->comboBoxCookedDataType->addItem("int64_t", CookedDataTypeInt64);
    ui->comboBoxCookedDataType->addItem("uint64_t", CookedDataTypeUint64);
    if (sizeof(float) == 4) {
        ui->comboBoxCookedDataType->addItem("float(4bytes)", CookedDataTypeFloat);
    }
    if (sizeof(double) == 8) {
        ui->comboBoxCookedDataType->addItem("double(8bytes)", CookedDataTypeDouble);
    }

    connect(ui->lineEditCookedDec, &QLineEdit::textEdited, this, &SAKNumberAssistant::updateRawData);
    connect(ui->lineEditRawData,
            &QLineEdit::textEdited,
            this,
            &SAKNumberAssistant::updateCookedData);
    connect(ui->comboBoxCookedDataType,
            QOverload<int>::of(&QComboBox::currentIndexChanged),
            this,
            &SAKNumberAssistant::onCookedDataTypeChanged);

    onCookedDataTypeChanged();
}

SAKNumberAssistant::~SAKNumberAssistant()
{
    delete ui;
}

void SAKNumberAssistant::updateCookedData()
{
    int type = ui->comboBoxCookedDataType->currentData().toInt();
    QString text = ui->lineEditRawData->text();
    text.remove(" ");
    QByteArray ba = QByteArray::fromHex(text.toLatin1());
    int bytes = bytesOfType(type);
    while (ba.length() < bytes) {
        ba.append('\0');
    }

    QByteArray tmpBa = ba;
    std::reverse(tmpBa.begin(), tmpBa.end());

    QString binStr = m_interface->arrayToString(tmpBa, SAKDataStructure::TextFormatBin);
    QString hexStr = m_interface->arrayToString(tmpBa, SAKDataStructure::TextFormatHex);
    ui->lineEditCookedBin->setText(binStr);
    ui->lineEditCookedHex->setText(hexStr);

    if (type == CookedDataTypeInt8) {
        int8_t *ptr = reinterpret_cast<int8_t *>(ba.data());
        ui->lineEditCookedDec->setText(QString::number(*ptr));
    } else if (type == CookedDataTypeUint8) {
        uint8_t *ptr = reinterpret_cast<uint8_t *>(ba.data());
        ui->lineEditCookedDec->setText(QString::number(*ptr));
    } else if (type == CookedDataTypeInt16) {
        int16_t *ptr = reinterpret_cast<int16_t *>(ba.data());
        ui->lineEditCookedDec->setText(QString::number(*ptr));
    } else if (type == CookedDataTypeUint16) {
        uint16_t *ptr = reinterpret_cast<uint16_t *>(ba.data());
        ui->lineEditCookedDec->setText(QString::number(*ptr));
    } else if (type == CookedDataTypeInt32) {
        int32_t *ptr = reinterpret_cast<int32_t *>(ba.data());
        ui->lineEditCookedDec->setText(QString::number(*ptr));
    } else if (type == CookedDataTypeUint32) {
        uint32_t *ptr = reinterpret_cast<uint32_t *>(ba.data());
        ui->lineEditCookedDec->setText(QString::number(*ptr));
    } else if (type == CookedDataTypeInt64) {
        int64_t *ptr = reinterpret_cast<int64_t *>(ba.data());
        ui->lineEditCookedDec->setText(QString::number(*ptr));
    } else if (type == CookedDataTypeUint64) {
        uint64_t *ptr = reinterpret_cast<uint64_t *>(ba.data());
        ui->lineEditCookedDec->setText(QString::number(*ptr));
    } else if (type == CookedDataTypeFloat) {
        float *ptr = reinterpret_cast<float *>(ba.data());
        ui->lineEditCookedDec->setText(QString::number(*ptr));
    } else if (type == CookedDataTypeDouble) {
        double *ptr = reinterpret_cast<double *>(ba.data());
        ui->lineEditCookedDec->setText(QString::number(*ptr));
    } else {
        Q_ASSERT_X(false, __FUNCTION__, "Oh, No!");
    }
}

template<typename T>
void updateRawData(QLineEdit *le, T value)
{
    T *ptr = &value;
    QByteArray tmp = QByteArray::fromRawData(reinterpret_cast<char *>(ptr), sizeof(T));
    le->setText(tmp.toHex(' '));
}

void SAKNumberAssistant::updateRawData()
{
    int type = ui->comboBoxCookedDataType->currentData().toInt();
    if (type == CookedDataTypeInt8) {
        ::updateRawData<int8_t>(ui->lineEditRawData, ui->lineEditCookedDec->text().toInt());
    } else if (type == CookedDataTypeUint8) {
        ::updateRawData<uint8_t>(ui->lineEditRawData, ui->lineEditCookedDec->text().toUInt());
    } else if (type == CookedDataTypeInt16) {
        ::updateRawData<int16_t>(ui->lineEditRawData, ui->lineEditCookedDec->text().toInt());
    } else if (type == CookedDataTypeUint16) {
        ::updateRawData<uint16_t>(ui->lineEditRawData, ui->lineEditCookedDec->text().toUInt());
    } else if (type == CookedDataTypeInt32) {
        ::updateRawData<int32_t>(ui->lineEditRawData, ui->lineEditCookedDec->text().toInt());
    } else if (type == CookedDataTypeUint32) {
        ::updateRawData<uint32_t>(ui->lineEditRawData, ui->lineEditCookedDec->text().toUInt());
    } else if (type == CookedDataTypeInt64) {
        ::updateRawData<int64_t>(ui->lineEditRawData, ui->lineEditCookedDec->text().toLongLong());
    } else if (type == CookedDataTypeUint64) {
        ::updateRawData<uint64_t>(ui->lineEditRawData, ui->lineEditCookedDec->text().toULongLong());
    } else if (type == CookedDataTypeFloat) {
        ::updateRawData<float>(ui->lineEditRawData, ui->lineEditCookedDec->text().toFloat());
    } else if (type == CookedDataTypeDouble) {
        ::updateRawData<double>(ui->lineEditRawData, ui->lineEditCookedDec->text().toDouble());
    } else {
        Q_ASSERT_X(false, __FUNCTION__, "Oh, No!");
    }

    updateCookedData();
}

int SAKNumberAssistant::bytesOfType(int type)
{
    switch (type) {
    case CookedDataTypeInt8:
    case CookedDataTypeUint8:
        return 1;
    case CookedDataTypeInt16:
    case CookedDataTypeUint16:
        return 2;
    case CookedDataTypeInt32:
    case CookedDataTypeUint32:
        return 4;
    case CookedDataTypeInt64:
    case CookedDataTypeUint64:
        return 8;
    case CookedDataTypeFloat:
        return 4;
    case CookedDataTypeDouble:
        return 8;
    default:
        return 0;
    }
}

void SAKNumberAssistant::onCookedDataTypeChanged()
{
    int bytes = bytesOfType(ui->comboBoxCookedDataType->currentData().toInt());
    ui->lineEditRawData->setMaxLength(bytes * 3 - 1);

    updateCookedData();
}