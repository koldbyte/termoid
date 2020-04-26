# Set minimum CMake version (required for CMake 3.0 or later)
cmake_minimum_required(VERSION 2.8.12)
set_property(GLOBAL PROPERTY GLOBAL_DEPENDS_DEBUG_MODE 1)
project(termoid_pkg)

add_subdirectory(qmltermwidget)
add_subdirectory(plasmoid)