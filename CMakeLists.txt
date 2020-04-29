# Set minimum CMake version (required for CMake 3.0 or later)
cmake_minimum_required(VERSION 3.1)

project(termoid)
set(PROJECT_NAME "termoid")
set(PROJECT_VERSION_MAJOR 1)
set(PROJECT_VERSION_MINOR 0)
set(PROJECT_VERSION_PATCH 0)
set(PROJECT_VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH})
set(PROJECT_AUTHOR "Bhaskar Divya")
set(PROJECT_YEAR_COPYRIGHT "2020")
set(PROJECT_URL "https://github.com/koldbyte/termoid")
set(PROJECT_DESCRIPTION_SUMMARY "Terminal on a Desktop")

set_property(GLOBAL PROPERTY GLOBAL_DEPENDS_DEBUG_MODE 1)

add_subdirectory(qmltermwidget)
add_subdirectory(plasmoid)

# Packaging stuff (deb, rpm etc)
add_subdirectory(packaging)