/******************************************************************************
 * Copyright 2023 Qsaker(wuuhaii@outlook.com). All rights reserved.
 *
 * The file is encoded using "utf8 with bom", it is a part
 * of QtSwissArmyKnife project.
 *
 * QtSwissArmyKnife is licensed according to the terms in
 * the file LICENCE in the root of the source code directory.
 *****************************************************************************/
#ifndef SAKTABELMODELTOOL_HH
#define SAKTABELMODELTOOL_HH

#include "SAKBaseTool.hh"
#include "SAKTableModel.hh"

class SAKTabelModelTool : public SAKBaseTool
{
    Q_OBJECT
    Q_PROPERTY(QVariant tableModel READ tableModel CONSTANT)
    Q_PROPERTY(QStringList headers READ headers CONSTANT)
public:
    explicit SAKTabelModelTool(const char *logCategory,
                               QObject *parent = nullptr);
    QVariant tableModel();
    QStringList headers() const;

    Q_INVOKABLE virtual void addItem(const QString &jsonCtx, int index = -1) = 0;
    Q_INVOKABLE virtual QVariant itemContext(int index) = 0;
    Q_INVOKABLE virtual QVariant itemsContext() = 0;

protected:
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const = 0;
    virtual int columnCount(const QModelIndex &parent
                            = QModelIndex()) const = 0;
    virtual QVariant data(const QModelIndex &index,
                          int role = Qt::DisplayRole) const = 0;
    virtual bool setData(const QModelIndex &index,
                         const QVariant &value,
                         int role = Qt::EditRole) = 0;
    virtual bool insertRows(int row,
                            int count,
                            const QModelIndex &parent = QModelIndex()) = 0;
    virtual bool removeRows(int row,
                            int count,
                            const QModelIndex &parent = QModelIndex()) = 0;
    virtual QVariant headerData(int section,
                                Qt::Orientation orientation,
                                int role = Qt::DisplayRole) const = 0;

protected:
    SAKTableModel *mTableModel;

private:
    void onInvokeGetRowCount(int &count);
    void onInvokeGetColumnCount(int &count);
    void onInvokeGetData(QVariant &data,
                         const QModelIndex &index,
                         int role = Qt::DisplayRole);
    void onInvokeSetData(bool &result,
                         const QModelIndex &index,
                         const QVariant &value,
                         int role = Qt::EditRole);
    void onInvokeInsertRows(bool &result,
                            int row,
                            int count,
                            const QModelIndex &parent = QModelIndex());
    void onInvokeRemoveRows(bool &result,
                            int row,
                            int count,
                            const QModelIndex &parent = QModelIndex());
    void onInvokeGetHeaderData(QVariant &data,
                               int section,
                               Qt::Orientation orientation,
                               int role = Qt::DisplayRole);
};

#endif // SAKTABELMODELTOOL_HH
