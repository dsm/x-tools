set(X_TOOLS_QML_PATH ${CMAKE_CURRENT_SOURCE_DIR}/Qml)

function(x_tools_deploy_qt_for_windows target)
  if(EXISTS "${X_TOOLS_QML_PATH}")
    add_custom_command(
      TARGET ${target}
      POST_BUILD
      COMMAND ${WINDEPLOYQT_EXECUTABLE} $<TARGET_FILE:${target}> --qmldir ${X_TOOLS_QML_PATH}
              --no-compiler-runtime
      COMMENT "Deploy Qt (with qml) for Windows..."
      VERBATIM)
  else()
    add_custom_command(
      TARGET ${target}
      POST_BUILD
      COMMAND ${WINDEPLOYQT_EXECUTABLE} $<TARGET_FILE:${target}> --no-compiler-runtime
      COMMENT "Deploy Qt for Windows..."
      VERBATIM)
  endif()

  if((${MSVC_VERSION} GREATER_EQUAL 1929) AND ("${CMAKE_BUILD_TYPE}" STREQUAL "Release"))
    cmake_path(GET CMAKE_CXX_COMPILER PARENT_PATH COMPILER_PATH)
    add_custom_command(
      TARGET ${target}
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy_if_different "${COMPILER_PATH}/VCRUNTIME140.dll"
              $<TARGET_FILE_DIR:${target}>
      COMMAND ${CMAKE_COMMAND} -E copy_if_different "${COMPILER_PATH}/VCRUNTIME140_1.dll"
              $<TARGET_FILE_DIR:${target}>
      COMMAND ${CMAKE_COMMAND} -E copy_if_different "${COMPILER_PATH}/MSVCP140.dll"
              $<TARGET_FILE_DIR:${target}>
      COMMAND ${CMAKE_COMMAND} -E copy_if_different "${COMPILER_PATH}/MSVCP140_1.dll"
              $<TARGET_FILE_DIR:${target}>
      COMMAND ${CMAKE_COMMAND} -E copy_if_different "${COMPILER_PATH}/MSVCP140_2.dll"
              $<TARGET_FILE_DIR:${target}>
      VERBATIM)
  endif()
endfunction()

function(x_tools_deploy_qt_for_mac target)
  if(NOT ${target} STREQUAL "xTools")
    return()
  endif()

  if(NOT APPLE)
    return()
  endif()

  if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/qml")
    add_custom_command(
      TARGET ${target}
      POST_BUILD
      COMMAND ${WINDEPLOYQT_EXECUTABLE} "${X_TOOLS_BINARY_DIR}/${target}/${target}.app"
              "-qmldir=${CMAKE_CURRENT_SOURCE_DIR}/qml -dmg"
      COMMENT "Running macdeployqt..."
      VERBATIM)
  else()
    add_custom_command(
      TARGET ${target}
      POST_BUILD
      COMMAND ${WINDEPLOYQT_EXECUTABLE} "${X_TOOLS_BINARY_DIR}/${target}/${target}.app" "-dmg"
      COMMENT "Running macdeployqt..."
      VERBATIM)
  endif()

  add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMAND sh -c "ls *.dmg > dmgs.txt"
    WORKING_DIRECTORY "${X_TOOLS_BINARY_DIR}/${target}"
    COMMENT "Scan dmg file"
    VERBATIM)

  add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMAND sh -c "rm xtools-macos-11.dmg || true"
    COMMAND sh -c "cat dmgs.txt | xargs -I {} mv {} xtools-macos-11.dmg"
    COMMAND sh -c "rm dmgs.txt || true"
    WORKING_DIRECTORY "${X_TOOLS_BINARY_DIR}/${target}"
    COMMENT "Rename old dmg file"
    VERBATIM)
endfunction()

function(x_tools_deploy_qt_for_linux target)
  option(X_TOOLS_LINUX_MAKE_${target}_APP_IMAGE "Pack target tp a app image file" OFF)
  if(NOT X_TOOLS_LINUX_MAKE_${target}_APP_IMAGE)
    return()
  endif()

  execute_process(
    COMMAND git rev-parse --short HEAD
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_SHORT_COMMIT
    OUTPUT_STRIP_TRAILING_WHITESPACE)

  set(APP_DIR ${CMAKE_BINARY_DIR}/AppImage)
  set(APP_DIR_BIN ${APP_DIR}/bin)
  set(APP_IMAGE_TEMPLATE ${CMAKE_SOURCE_DIR}/Resources/Platforms/Unix/AppImage)
  set(APP_LOGO "${CMAKE_SOURCE_DIR}/Resources/Images/256x256.png")
  set(TOOLS_PATH ${CMAKE_SOURCE_DIR}/Resources/Tools/Ubuntu20.04)
  set(appimagetool ${TOOLS_PATH}/appimagetool-x86_64.AppImage)
  set(linuxdeployqt ${TOOLS_PATH}/linuxdeployqt-continuous-x86_64.AppImage)
  set(applications_dir ${APP_DIR}/share/applications)
  set(desktop_file "${applications_dir}/${target}.desktop")
  set(app_image_file "${target}-${GIT_SHORT_COMMIT}-x86_64.AppImage")

  add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${APP_IMAGE_TEMPLATE} ${APP_DIR}
    COMMAND ${CMAKE_COMMAND} -E make_directory ${APP_DIR_BIN}
    COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:${target}> ${APP_DIR_BIN}
    COMMAND sed -i "s/AppImage/${target}/g" "${applications_dir}/AppImage.desktop"
    COMMAND ${CMAKE_COMMAND} -E rename "${applications_dir}/AppImage.desktop" ${desktop_file}
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${APP_IMAGE_TEMPLATE} ${APP_DIR}
    COMMAND chmod +x ${appimagetool}
    COMMAND chmod +x ${linuxdeployqt}
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${APP_LOGO} "${CMAKE_BINARY_DIR}/${target}.png"
    COMMAND ${linuxdeployqt} ${desktop_file} "-qmake=${QT_QMAKE_EXECUTABLE}" "-appimage"
    COMMAND ${CMAKE_COMMAND} -E rm -f ${target}-Linux-x86_64.AppImage "||" ${CMAKE_COMMAND} -E true
    COMMAND ${CMAKE_COMMAND} -E rename ${app_image_file} ${target}-Linux-x86_64.AppImage
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Creating app image file..."
    VERBATIM)
endfunction()

function(x_tools_deploy_qt target)
  if(NOT QT_VERSION_MAJOR EQUAL 6)
    return()
  endif()

  if(WIN32)
    x_tools_deploy_qt_for_windows(${target})
  elseif(UNIX AND NOT APPLE)
    x_tools_deploy_qt_for_linux(${target})
  elseif(APPLE)
    x_tools_deploy_qt_for_mac(${target})
  endif()
endfunction()
