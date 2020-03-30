# Copyright (C) 2020 Istituto Italiano di Tecnologia (IIT). All rights reserved.
# This software may be modified and distributed under the terms of the
# GNU Lesser General Public License v2.1 or any later version.

# set target name
if(BIPEDAL_LOCOMOTION_CONTROLLERS_COMPILE_Estimators)

    add_bipedal_component(
    NAME                   Estimators
    SOURCES                src/RecursiveLeastSquare.cpp
    PUBLIC_HEADERS         include/BipedalLocomotionControllers/Estimators/RecursiveLeastSquare.h
    SUBDIRECTORIES         tests
    PUBLIC_LINK_LIBRARIES  BipedalLocomotionControllers::ParametersHandler)

endif()