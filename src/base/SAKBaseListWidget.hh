﻿/****************************************************************************************
 * Copyright 2021 Qter(qsaker@qq.com). All rights reserved.
 *
 * The file is encoded using "utf8 with bom", it is a part
 * of QtSwissArmyKnife project.
 *
 * QtSwissArmyKnife is licensed according to the terms in
 * the file LICENCE in the root of the source code directory.
 ***************************************************************************************/
#ifndef SAKBASELISTWIDGET_HH
#define SAKBASELISTWIDGET_HH
#include <QTimer>
#include <QWidget>
#include <QSettings>
#include <QSqlQuery>
#include <QJsonObject>
#include <QSqlDatabase>
#include <QListWidgetItem>

namespace Ui {
    class SAKBaseListWidget;
}

class SAKBaseListWidget : public QWidget
{
    Q_OBJECT
public:
    SAKBaseListWidget(QSqlDatabase *sqlDatabase,
                      QSettings *settings,
                      QString settingsGroup,
                      QString tableNameSuffix,
                      QWidget *parent = Q_NULLPTR);
    ~SAKBaseListWidget();


protected:
    QSqlDatabase *mSqlDatabase;
    QSettings *mSettings;
    QString mSettingsGroup;
    QString mTableNameSuffix;

    QString mTableName;
    QSqlQuery mSqlQuery;
    QTimer mClearMessageInfoTimer;
    QListWidget *mListWidget;


protected:
    virtual void insertRecord(const QString &tableName, QWidget *itemWidget) = 0;
    virtual QWidget *createItemFromParameters(const QJsonObject &jsonObj) = 0;
    virtual QJsonObject toJsonObject(QWidget *itemWidget) = 0;
    virtual QJsonObject toJsonObject(const QSqlQuery &sqlQuery) = 0;
    virtual quint64 itemId(QWidget *itemWidget) = 0;
    virtual void connectSignalsToSlots(QWidget *itemWidget) = 0;
    virtual void createDatabaseTable(QString tableName) = 0;

    void updateRecord(quint64 id, QString columnName, QVariant value);
    void outputMessage(QString msg, bool isError);
    // It must be called in the subcalss.
    void initialize();


private:
    void clearItems();
    void importItems();
    void exportItems();
    void deleteItem(QListWidgetItem *item);
    void addItem();
    void readinRecords();
    bool setupItemWidget(QListWidgetItem *item, QWidget *itemWidget);


private:
    Ui::SAKBaseListWidget *mUi;
};

#endif // SAKBASELISTWIDGET_HH
