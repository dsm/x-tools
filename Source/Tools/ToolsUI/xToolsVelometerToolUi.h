/***************************************************************************************************
 * Copyright 2023 x-tools-author(x-tools@outlook.com). All rights reserved.
 *
 * The file is encoded using "utf8 with bom", it is a part of xTools project.
 *
 * xTools is licensed according to the terms in the file LICENCE(GPL V3) in the root of the source
 * code directory.
 **************************************************************************************************/
#pragma once

#include "sakbasetoolui.h"
#include <QLoggingCategory>

namespace Ui {
class xToolsVelometerToolUi;
}

class xToolsVelometerToolUi : public SAKBaseToolUi
{
    Q_OBJECT
public:
    xToolsVelometerToolUi(QWidget *parent = nullptr);
    ~xToolsVelometerToolUi();

protected:
    virtual void onBaseToolUiInitialized(xToolsBaseTool *tool, const QString &settingsGroup) final;

private:
    const QLoggingCategory mLoggingCategory{"sak.velometertoolui"};
    Ui::xToolsVelometerToolUi *ui;
};
