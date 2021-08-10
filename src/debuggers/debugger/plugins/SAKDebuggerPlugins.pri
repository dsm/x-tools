include($$PWD/plugin/SAKDebuggerPlugin.pri)

include($$PWD/3d/SAKPlugin3d.pri)
include($$PWD/charts/SAKPluginCharts.pri)
include($$PWD/transponder/SAKPluginDataForwarding.pri)
include($$PWD/autoresponse/SAKDebuggerPluginAutoResponse.pri)
include($$PWD/regularlysending/SAKDebuggerPluginRegularlySending.pri)

HEADERS += \
    $$PWD/SAKDebuggerPlugins.hh

SOURCES += \
    $$PWD/SAKDebuggerPlugins.cc

INCLUDEPATH += \
    $$PWD
