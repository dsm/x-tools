#-------------------------------------------------
#
# Project created by QtCreator 2018-07-06T22:57:33
#
#-------------------------------------------------

QT += core gui network
qtHaveModule(sql){
    QT  += sql
    DEFINES+=SAK_IMPORT_SQL_MODULE
}else{
    message("The Qt edition has no sql module, the program will not has function about sql.")
}

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

contains(CONFIG, debug, debug|release){
    TARGET = QtSwissArmyKnifed
}else{
    TARGET = QtSwissArmyKnife
}

TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, unTabPage the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG += c++11

# 子项目
#include(SAKHID.pri)
#include(SAKUSB.pri)
#include(SAKSCTP.pri)
include(SAKSetup.pri)
include(SAKTools.pri)
include(SAKCommon.pri)
include(SAKCharts.pri)
include(SAKModules.pri)
#include(SAKBluetooth.pri)
include(SAKWebSocket.pri)
include(SAKSerialPort.pri)

exists(private/SAKPrivate.pri){
    include(private/SAKPrivate.pri)
}

QSAK_APP_NAME        = "QtSwissArmyKnife"
QSAK_ORG_NAME        = "Qter"
QSAK_ORG_DOMAIN      = "IT"
QSAK_APP_DESCRIPTION = "Qt Swiss Army Knife"
QSAK_APP_COPYRIGHT   = "Copyright 2018-2020 Qter(qsaker@qq.com). All rights reserved."

win32 {
    QMAKE_TARGET_COMPANY        = "$${QSAK_ORG_NAME}"
    QMAKE_TARGET_DESCRIPTION    = "$${QSAK_APP_DESCRIPTION}"
    QMAKE_TARGET_COPYRIGHT      = "$${QSAK_APP_COPYRIGHT}"
    QMAKE_TARGET_PRODUCT        = "$${QSAK_APP_NAME}"
    QMAKE_TARGET_VERSION        = "$${SAK_VERSION}"
}

#--------------------------------------------------------------------------------------------
#编译目录配置
UI_DIR      = $$OUT_PWD/ui
MOC_DIR     = $$OUT_PWD/moc
RCC_DIR     = $$OUT_PWD/res
OBJECTS_DIR = $$OUT_PWD/obj

#--------------------------------------------------------------------------------------------
#Windows配置
win32 {
    RC_ICONS = Windows.ico
    msvc:{
        QMAKE_CXXFLAGS += -execution-charset:utf-8
    }
}

#--------------------------------------------------------------------------------------------
#国际化文件
TRANSLATIONS  += \
    translations/sak/SAK_en.ts \
    translations/sak/SAK_zh_CN.ts \
    translations/sak/SAK_zh_TW.ts

RESOURCES += \
    SAKResources.qrc

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

contains(ANDROID_TARGET_ARCH,arm64-v8a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}

INCLUDEPATH += \
    src \
    src/moreinfo \
    src/common \
    src/pages \
    src/pages/page \
    src/pages/page/common \
    src/pages/page/device \
    src/pages/page/input \
    src/pages/page/input/crcsettings \
    src/pages/page/input/datafactory \
    src/pages/page/input/datapreset \
    src/pages/page/other \
    src/pages/page/other/autoresponse \
    src/pages/page/other/highlighter \
    src/pages/page/other/generator \
    src/pages/page/other/analyzer \
    src/pages/page/other/timingsent \
    src/pages/page/other/transmission \
    src/pages/page/output \
    src/pages/page/output/save2file \
    src/pages/page/statistics \
    src/pages/tcp/client \
    src/pages/tcp/server \
    src/pages/udp \
    src/qrcode \
    src/startui \
    src/singleton \
    src/update

FORMS += \
    src/SAKMainWindow.ui \
    src/moreinfo/SAKMoreInformation.ui \
    src/pages/page/SAKDebugPage.ui \
    src/pages/page/input/crcsettings/SAKInputCrcSettingsDialog.ui \
    src/pages/page/input/datapreset/SAKInputDataPresetItem.ui \
    src/pages/page/input/datapreset/SAKInputDataPresetItemManager.ui \
    src/pages/page/other/analyzer/SAKOtherAnalyzerThreadManager.ui \
    src/pages/page/other/autoresponse/SAKOtherAutoResponseItem.ui \
    src/pages/page/other/autoresponse/SAKOtherAutoResponseItemManager.ui \
    src/pages/page/other/highlighter/SAKOtherHighlighterManager.ui \
    src/pages/page/other/timingsent/SAKOtherTimingSentItem.ui \
    src/pages/page/other/timingsent/SAKOtherTimingSentItemManager.ui \
    src/pages/page/other/transmission/SAKOtherTransmissionItemCom.ui \
    src/pages/page/other/transmission/SAKOtherTransmissionItemTcp.ui \
    src/pages/page/other/transmission/SAKOtherTransmissionItemUdp.ui \
    src/pages/page/other/transmission/SAKOtherTransmissionPage.ui \
    src/pages/page/other/transmission/SAKOtherTransmissionPageViewer.ui \
    src/pages/page/output/save2file/SAKOutputSave2FileDialog.ui \
    src/pages/tcp/client/SAKTcpClientDeviceController.ui \
    src/pages/tcp/server/SAKTcpServerDeviceController.ui \
    src/pages/udp/SAKUdpAdvanceSettingWidget.ui \
    src/pages/udp/SAKUdpDeviceController.ui \
    src/pages/udp/SAKUdpMulticastEditingDialog.ui \
    src/qrcode/SAKQRCodeDialog.ui \
    src/singleton/SAKSingletonErrorDialog.ui \
    src/update/SAKDownloadItemWidget.ui \
    src/update/SAKUpdateManager.ui

HEADERS += \
    src/SAK.hh \
    src/SAKApplication.hh \
    src/SAKGlobal.hh \
    src/SAKMainWindow.hh \
    src/SAKSettings.hh \
    src/common/SAKInterface.hh \
    src/moreinfo/SAKMoreInformation.hh \
    src/pages/page/SAKDebugPage.hh \
    src/pages/page/common/SAKDebugPageCommonDatabaseInterface.hh \
    src/pages/page/device/SAKDebugPageDevice.hh \
    src/pages/page/input/SAKDebugPageInputController.hh \
    src/pages/page/input/crcsettings/SAKInputCrcSettingsDialog.hh \
    src/pages/page/input/datafactory/SAKInputDataFactory.hh \
    src/pages/page/input/datapreset/SAKInputDataPresetItem.hh \
    src/pages/page/input/datapreset/SAKInputDataPresetItemManager.hh \
    src/pages/page/other/SAKDebugPageOtherController.hh \
    src/pages/page/other/analyzer/SAKOtherAnalyzerThread.hh \
    src/pages/page/other/analyzer/SAKOtherAnalyzerThreadManager.hh \
    src/pages/page/other/autoresponse/SAKOtherAutoResponseItem.hh \
    src/pages/page/other/autoresponse/SAKOtherAutoResponseItemManager.hh \
    src/pages/page/other/highlighter/SAKOtherHighlighter.hh \
    src/pages/page/other/highlighter/SAKOtherHighlighterManager.hh \
    src/pages/page/other/timingsent/SAKOtherTimingSentItem.hh \
    src/pages/page/other/timingsent/SAKOtherTimingSentItemManager.hh \
    src/pages/page/other/transmission/SAKOtherTransmissionItem.hh \
    src/pages/page/other/transmission/SAKOtherTransmissionItemCom.hh \
    src/pages/page/other/transmission/SAKOtherTransmissionItemTcp.hh \
    src/pages/page/other/transmission/SAKOtherTransmissionItemUdp.hh \
#    src/pages/page/other/transmission/SAKTransmissionItemDelegate.hh \
    src/pages/page/other/transmission/SAKOtherTransmissionPage.hh \
    src/pages/page/other/transmission/SAKOtherTransmissionPageViewer.hh \
    src/pages/page/output/SAKDebugPageOutputController.hh \
    src/pages/page/output/save2file/SAKOutputSave2FileDialog.hh \
    src/common/SAKCRCInterface.hh \
    src/common/SAKDataStruct.hh \
    src/pages/page/output/save2file/SAKOutputSave2FileThread.hh \
    src/pages/page/statistics/SAKDebugPageStatisticsController.hh \
    src/pages/tcp/client/SAKTcpClientDebugPage.hh \
    src/pages/tcp/client/SAKTcpClientDevice.hh \
    src/pages/tcp/client/SAKTcpClientDeviceController.hh \
    src/pages/tcp/server/SAKTcpServerDebugPage.hh \
    src/pages/tcp/server/SAKTcpServerDevice.hh \
    src/pages/tcp/server/SAKTcpServerDeviceController.hh \
    src/pages/udp/SAKUdpAdvanceSettingWidget.hh \
    src/pages/udp/SAKUdpDebugPage.hh \
    src/pages/udp/SAKUdpDevice.hh \
    src/pages/udp/SAKUdpDeviceController.hh \
    src/pages/udp/SAKUdpMulticastEditingDialog.hh \
    src/qrcode/SAKQRCodeDialog.hh \
    src/qrcode/SAKQRCodeWidget.hh \
    src/singleton/SAKSingletonController.hh \
    src/singleton/SAKSingletonErrorDialog.hh \
    src/startui/SAKSplashScreen.hh \
    src/update/SAKDownloadItemWidget.hh \
    src/update/SAKUpdateManager.hh

SOURCES += \
    src/SAK.cc \
    src/SAKApplication.cc \
    src/SAKGlobal.cc \
    src/SAKMainWindow.cc \
    src/SAKSettings.cc \
    src/common/SAKInterface.cc \
    src/moreinfo/SAKMoreInformation.cc \
    src/pages/page/SAKDebugPage.cc \
    src/pages/page/common/SAKDebugPageCommonDatabaseInterface.cc \
    src/pages/page/device/SAKDebugPageDevice.cc \
    src/pages/page/input/SAKDebugPageInputController.cc \
    src/pages/page/input/crcsettings/SAKInputCrcSettingsDialog.cc \
    src/pages/page/input/datafactory/SAKInputDataFactory.cc \
    src/pages/page/input/datapreset/SAKInputDataPresetItem.cc \
    src/pages/page/input/datapreset/SAKInputDataPresetItemManager.cc \
    src/pages/page/other/SAKDebugPageOtherController.cc \
    src/pages/page/other/analyzer/SAKOtherAnalyzerThread.cc \
    src/pages/page/other/analyzer/SAKOtherAnalyzerThreadManager.cc \
    src/pages/page/other/autoresponse/SAKOtherAutoResponseItem.cc \
    src/pages/page/other/autoresponse/SAKOtherAutoResponseItemManager.cc \
    src/pages/page/other/highlighter/SAKOtherHighlighter.cc \
    src/pages/page/other/highlighter/SAKOtherHighlighterManager.cc \
    src/pages/page/other/timingsent/SAKOtherTimingSentItem.cc \
    src/pages/page/other/timingsent/SAKOtherTimingSentItemManager.cc \
    src/pages/page/other/transmission/SAKOtherTransmissionItem.cc \
    src/pages/page/other/transmission/SAKOtherTransmissionItemCom.cc \
    src/pages/page/other/transmission/SAKOtherTransmissionItemTcp.cc \
    src/pages/page/other/transmission/SAKOtherTransmissionItemUdp.cc \
#    src/pages/page/other/transmission/SAKTransmissionItemDelegate.cc \
    src/pages/page/other/transmission/SAKOtherTransmissionPage.cc \
    src/pages/page/other/transmission/SAKOtherTransmissionPageViewer.cc \
    src/pages/page/output/SAKDebugPageOutputController.cc \
    src/pages/page/output/save2file/SAKOutputSave2FileDialog.cc \
    src/common/SAKCRCInterface.cc \
    src/common/SAKDataStruct.cc \
    src/main.cc \
    src/pages/page/output/save2file/SAKOutputSave2FileThread.cc \
    src/pages/page/statistics/SAKDebugPageStatisticsController.cc \
    src/pages/tcp/client/SAKTcpClientDebugPage.cc \
    src/pages/tcp/client/SAKTcpClientDevice.cc \
    src/pages/tcp/client/SAKTcpClientDeviceController.cc \
    src/pages/tcp/server/SAKTcpServerDebugPage.cc \
    src/pages/tcp/server/SAKTcpServerDevice.cc \
    src/pages/tcp/server/SAKTcpServerDeviceController.cc \
    src/pages/udp/SAKUdpAdvanceSettingWidget.cc \
    src/pages/udp/SAKUdpDebugPage.cc \
    src/pages/udp/SAKUdpDevice.cc \
    src/pages/udp/SAKUdpDeviceController.cc \
    src/pages/udp/SAKUdpMulticastEditingDialog.cc \
    src/qrcode/SAKQRCodeDialog.cc \
    src/qrcode/SAKQRCodeWidget.cc \
    src/singleton/SAKSingletonController.cc \
    src/singleton/SAKSingletonErrorDialog.cc \
    src/startui/SAKSplashScreen.cc \
    src/update/SAKDownloadItemWidget.cc \
    src/update/SAKUpdateManager.cc
