﻿/*
 * The file is encoding with utf-8 (with BOM)
 *
 * I write the comment with English, it's not because that I'm good at English,
 * but for "installing B".
 *
 * Copyright (C) 2018-2018 wuhai persionnal. All rights reserved.
 */
#ifndef SAKGLOBAL_HH
#define SAKGLOBAL_HH

#include <QObject>

class SAKGlobal:public QObject
{
    Q_OBJECT
public:
    /**
     * @brief The SAKEnumIODeviceType enum  -- io的设备类型
     */
    enum SAKEnumDebugPageType {
#ifdef SAK_IMPORT_COM_MODULE
        SAKEnumDebugPageTypeCOM,
#endif
#ifdef SAK_IMPORT_HID_MODULE
        SAKEnumDebugPageTypeHID,
#endif
        SAKEnumDebugPageTypeUDP,
#ifdef SAK_IMPORT_USB_MODULE
        SAKEnumDebugPageTypeUSB,
#endif
        SAKEnumDebugPageTypeTCPClient,
        SAKEnumDebugPageTypeTCPServer
    };
    Q_ENUM(SAKEnumDebugPageType)

    /**
     * @brief SAKGlobal -- 构造函数
     * @param parent    -- 父控件
     */
    SAKGlobal(QObject* parent = nullptr);

    /**
     * @brief logFile   -- 获取日志文件（全路径）
     * @return          -- 日志文件全路径
     */
    static QString logFile();

    static QString dataPath();

    /**
     * @brief mkMutiDir -- 递归创建指定的目录路径
     * @param path      -- 目录路径
     * @return          -- 已创建的路径
     */
    static QString mkMutiDir(const QString path);

    /**
     * @brief getIODeviceTypeName   -- 获取设备类型的名称
     * @param type                  -- 设备类型
     * @return                      -- 设备类型名称
     */
    static QString getIODeviceTypeName(int type);
};

#endif
