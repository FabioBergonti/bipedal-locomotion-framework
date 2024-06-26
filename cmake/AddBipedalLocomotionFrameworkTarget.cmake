# Copyright (C) 2020 Istituto Italiano di Tecnologia (IIT). All rights reserved.
# This software may be modified and distributed under the terms of the
# BSD-3-Clause license.

get_property(umbrella_includes_list GLOBAL PROPERTY umbrella_includes)
get_property(target_list GLOBAL PROPERTY BipedalLocomotionFramework_INSTALLED_TARGETS)

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/cmake/Framework.h.in"
               "${CMAKE_CURRENT_BINARY_DIR}/Autogenerated/BipedalLocomotion/Framework.h" @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/Autogenerated/BipedalLocomotion/Framework.h"
        DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/BipedalLocomotion")

add_library(Framework INTERFACE)
target_compile_features(Framework INTERFACE cxx_std_17)
target_link_libraries(Framework INTERFACE ${target_list})
target_include_directories(Framework INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/Autogenerated/BipedalLocomotion/Framework.h>"
  "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${CMAKE_INSTALL_INCLUDEDIR}>")
# Specify installation targets, typology and destination folders.
install(TARGETS        Framework
  EXPORT               ${PROJECT_NAME}
  COMPONENT            runtime)

add_library(BipedalLocomotion::Framework ALIAS Framework)
set_property(GLOBAL APPEND PROPERTY BipedalLocomotionFramework_INSTALLED_TARGETS Framework)
