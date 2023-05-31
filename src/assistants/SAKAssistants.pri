include($$PWD/crcassistant/SAKToolCRCAssistant.pri)
include($$PWD/asciiassistant/SAKToolAsciiAssistant.pri)
include($$PWD/floatassistant/SAKToolFloatAssistant.pri)
include($$PWD/stringassistant/SAKToolStringAssistant.pri)
include($$PWD/filecheckassistant/SAKToolFileCheckAssistant.pri)
include($$PWD/broadcastassistant/SAKToolBroadcastAssistant.pri)

HEADERS += \
    $$PWD/SAKAssistantsFactory.hh \
    $$PWD/SAKBaseAssistant.hh

SOURCES += \
    $$PWD/SAKAssistantsFactory.cc \
    $$PWD/SAKBaseAssistant.cc

INCLUDEPATH += \
    $$PWD
