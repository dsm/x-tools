/******************************************************************************
 * Copyright 2023 Qsaker(wuuhaii@outlook.com). All rights reserved.
 *
 * The file is encoded using "utf8 with bom", it is a part
 * of QtSwissArmyKnife project.
 *
 * QtSwissArmyKnife is licensed according to the terms in
 * the file LICENCE in the root of the source code directory.
 *****************************************************************************/
#include <QLineEdit>
#include "SAKComboBox.hh"
#include "SAKSettings.hh"

SAKComboBox::SAKComboBox(QWidget *parent)
    : QComboBox(parent)
{
    connect(this, &SAKComboBox::currentTextChanged,
            this, &SAKComboBox::writeToSettingsFile);
//    connect(this, &SAKComboBox::editTextChanged,
//            this, &SAKComboBox::writeToSettingsFile);
}

void SAKComboBox::setCurrentIndexFromData(const QVariant &data)
{
    int ret = findData(data);
    if (ret != -1) {
        setCurrentIndex(ret);
    }
}

void SAKComboBox::setGroupKey(const QString &group,
                              const QString &key,
                              bool isIndex)
{
    mKey = group + "/" + key;
    mIsIndex = isIndex;

    readFromSettingsFile();
}


void SAKComboBox::readFromSettingsFile()
{
    if (mKey.isEmpty()) {
        return;
    }

    blockSignals(true);
    QVariant var = SAKSettings::instance()->value(mKey);
    if (mIsIndex) {
        int index = var.toInt();
        if (index >= 0 && index < count()) {
            setCurrentIndex(index);
        }
    } else {
        int index = findData(var);
        if (index >= 0 && index < count()) {
            setCurrentIndex(index);
        } else {
            if (isEditable()) {
                setCurrentText(var.toString());
            }
        }
    }
    blockSignals(false);
}

void SAKComboBox::writeToSettingsFile()
{
    if (mKey.isEmpty()) {
        return;
    }

    if (mIsIndex) {
        SAKSettings::instance()->setValue(mKey, currentIndex());
    } else {
        if (isEditable()) {
            SAKSettings::instance()->setValue(mKey, currentText());
        } else {
            SAKSettings::instance()->setValue(mKey, currentData());
        }
    }
}