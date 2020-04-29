
#------------------------------------------------------------------------------
# CPACK
include(InstallRequiredSystemLibraries)

set(CPACK_PACKAGE_VENDOR "koldbyte")
set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_CONTACT "Bhaskar Divya")
set(HOMEPAGE "https://github.com/koldbyte/termoid")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY
    "Terminal on a Desktop")
set(CPACK_PACKAGE_DESCRIPTION_FILE "${PROJECT_SOURCE_DIR}/ReadMe.md")
#set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/license.md")
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

set(CPACK_PACKAGE_INSTALL_DIRECTORY "${CMAKE_PROJECT_NAME}")
set(CPACK_PACKAGE_DIRECTORY "${CMAKE_BINARY_DIR}/build")


# set human names to exetuables
#set(CPACK_PACKAGE_EXECUTABLES "exampleApp" "My Example Executable")
#set(CPACK_CREATE_DESKTOP_LINKS "exampleApp")
set(CPACK_STRIP_FILES TRUE)

# Linux specific
set(CPACK_GENERATOR "DEB;TBZ2;TXZ")
message(STATUS "Package generation - UNIX")
message(STATUS "   + DEB                                  YES ")
message(STATUS "   + TBZ2                                 YES ")
message(STATUS "   + TXZ                                  YES ")

find_program(RPMBUILD_PATH rpmbuild)
if(RPMBUILD_PATH)
    message(STATUS "   + RPM                                  YES ")
    set(CPACK_GENERATOR "${CPACK_GENERATOR};RPM")
    set(CPACK_RPM_PACKAGE_LICENSE "MIT")
    # set(CPACK_RPM_PACKAGE_REQUIRES "gtkmm30")
    # exclude folders which clash with default ones
    set(CPACK_RPM_EXCLUDE_FROM_AUTO_FILELIST
        ${CPACK_RPM_EXCLUDE_FROM_AUTO_FILELIST}
        /usr
        /usr/bin
        /usr/share
        /usr/share/applications
        /usr/share/doc
        /usr/share/icons
        /usr/share/icons/hicolor
        /usr/share/icons/hicolor/256x256
        /usr/share/icons/hicolor/256x256/apps
        /usr/share/icons/gnome
        /usr/share/icons/gnome/256x256
        /usr/share/icons/gnome/256x256/apps)
else()
    message(STATUS "   + RPM                                  NO ")
endif()

# TODO do this better
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "amd64")
set(CPACK_DEBIAN_PACKAGE_CONTROL_STRICT_PERMISSION TRUE)
set(CPACK_DEBIAN_PACKAGE_HOMEPAGE "${HOMEPAGE}")
# set(CPACK_DEBIAN_COMPRESSION_TYPE "xz")
# set(CPACK_DEBIAN_PACKAGE_DEPENDS "libgtkmm-3.0")

#------------------------------------------------------------------------------
# and include CPack, so we get target for packages
include(CPack)



