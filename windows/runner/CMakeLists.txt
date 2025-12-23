cmake_minimum_required(VERSION 3.14)

# Define the executable
add_executable(${APPLICATION_NAME} WIN32)

# Add source files
target_sources(${APPLICATION_NAME}
  PRIVATE
    main.cpp
)

# Link Flutter library
target_link_libraries(${APPLICATION_NAME}
  PRIVATE
    flutter
)

# Add Flutter plugin libraries
flutter_auto_plugins(${APPLICATION_NAME})

# Install the executable
install(TARGETS ${APPLICATION_NAME}
  RUNTIME DESTINATION "."
  BUNDLE DESTINATION "."
)