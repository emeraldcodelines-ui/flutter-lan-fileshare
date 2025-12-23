cmake_minimum_required(VERSION 3.14)
project(flutter_lan_fileshare LANGUAGES CXX)

# Set CMake policies
if(POLICY CMP0091)
  cmake_policy(SET CMP0091 NEW)
endif()

# Define the location of the Flutter SDK
set(FLUTTER_ROOT "$ENV{FLUTTER_ROOT}" CACHE PATH "Flutter SDK root directory")

# Include the Flutter tooling
if(NOT FLUTTER_ROOT)
  message(FATAL_ERROR "FLUTTER_ROOT not set. Please set the FLUTTER_ROOT environment variable.")
endif()
list(APPEND CMAKE_MODULE_PATH "${FLUTTER_ROOT}/packages/flutter_tools/cmake")

# Include the Flutter build system
include(Flutter)

# Set application name and version
set(APPLICATION_NAME "flutter_lan_fileshare")
set(APPLICATION_VERSION "1.0.0.0")

# Configure the build
flutter_setup_application(
  APPLICATION_NAME ${APPLICATION_NAME}
  APPLICATION_VERSION ${APPLICATION_VERSION}
  FLUTTER_ROOT ${FLUTTER_ROOT}
)

# Add the runner executable
add_subdirectory(runner)