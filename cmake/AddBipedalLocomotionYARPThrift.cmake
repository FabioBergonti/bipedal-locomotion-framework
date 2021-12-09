# Copyright (C) 2021 Istituto Italiano di Tecnologia (IIT). All rights reserved.
# This software may be modified and distributed under the terms of the
# GNU Lesser General Public License v2.1 or any later version.

function(add_bipedal_locomotion_yarp_thrift)

  set(options )
  set(oneValueArgs NAME INSTALLATION_FOLDER THRIFT)
  set(multiValueArgs )

  set(prefix "bipedal_component")

  cmake_parse_arguments(${prefix}
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN})

  set(name ${${prefix}_NAME})
  set(installation_folder ${${prefix}_INSTALLATION_FOLDER})
  set(thrift ${${prefix}_THRIFT})

  if(NOT installation_folder)
    set(installation_folder ${name})
  endif()

  yarp_idl_to_dir(INPUT_FILES ${thrift}
    OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/autogenerated
    SOURCES_VAR AUTOGENERATE_SRC
    HEADERS_VAR AUTOGENERATE_HDR
    INCLUDE_DIRS_VAR AUTOGENERATE_INCLUDE_DIRS
    VERBOSE)

  add_library(${name} ${AUTOGENERATE_SRC} ${AUTOGENERATE_HDR})

  target_link_libraries(${name} PUBLIC YARP::YARP_OS)

  add_library(BipedalLocomotion::${name} ALIAS ${name})

  set_target_properties(${name} PROPERTIES
      OUTPUT_NAME "${PROJECT_NAME}${name}"
      VERSION ${BipedalLocomotionFramework_VERSION}
      PUBLIC_HEADER "${AUTOGENERATE_HDR}"
      )

    target_include_directories(${name} PUBLIC
    "$<BUILD_INTERFACE:${AUTOGENERATE_INCLUDE_DIRS}>"
    "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${CMAKE_INSTALL_INCLUDEDIR}>")

    # Specify installation targets, typology and destination folders.
    install(TARGETS    ${name}
      EXPORT           ${PROJECT_NAME}
      COMPONENT        runtime
      LIBRARY          DESTINATION "${CMAKE_INSTALL_LIBDIR}"                                                    COMPONENT shlib
      ARCHIVE          DESTINATION "${CMAKE_INSTALL_LIBDIR}"                                                    COMPONENT lib
      RUNTIME          DESTINATION "${CMAKE_INSTALL_BINDIR}"                                                    COMPONENT bin
      PUBLIC_HEADER    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/BipedalLocomotion/${installation_folder}"       COMPONENT dev
      PRIVATE_HEADER   DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/BipedalLocomotion/${installation_folder}/impl"  COMPONENT dev)

    set_property(GLOBAL APPEND PROPERTY BipedalLocomotionFramework_TARGETS ${name})

    message(STATUS "Created target ${name} for export ${PROJECT_NAME}.")

endfunction()
