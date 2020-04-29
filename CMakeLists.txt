# Set minimum CMake version (required for CMake 3.0 or later)
cmake_minimum_required(VERSION 3.1)

project(termoid)

set_property(GLOBAL PROPERTY GLOBAL_DEPENDS_DEBUG_MODE 1)

add_subdirectory(qmltermwidget)
add_subdirectory(plasmoid)

# Packaging stuff (deb, rpm etc)
add_subdirectory(packaging)