# Termoid

Terminal in a plasmoid.  
Run your favourite terminal applications like nethogs, htop, colortail etc. on your desktop as a widget.

# Features
* Terminal :)
* Comes with many inbuilt color schemes 
* Configurable Font family and Font size in terminal
* Configurable Opacity 

# Screenshots
![Screenshot running Nethogs](https://cn.pling.com/img/e/6/3/4/23df0d53b03331a44f31d8b55b9fc93f6a4a.png)

# Requirements
`qmltermwidget` package is required as this is the core of the plasmoid.

Source: [Github link](https://github.com/Swordfish90/qmltermwidget)  
Arch Distribution: [`qmltermwidget`](https://www.archlinux.org/packages/community/x86_64/qmltermwidget/)  
AUR: [`qmltermwidget-git`](https://aur.archlinux.org/packages/qmltermwidget-git/)  
Ubuntu: `qml-module-qmltermwidget1.0`  

# Installation

## KDE Store
[Store link](https://store.kde.org/p/1169451/)

## Build it Yourself
* [Download the source](https://github.com/koldbyte/termoid/archive/master.zip)
* Unzip and cd into directory
* `./build`
* `./install`      (for first time)
* `./reinstall`    (for updating the plasmoid)

Add the Termoid widget from "Add widgets" on your desktop

* The `build`/`run` commands require `kreadconfig5`.
* Do *not* run the `install`/`reinstall` scripts with `sudo` or the plasmoid will be placed in `/usr/share/` instead of your home directory.

## Locations

* `/usr/share/plasma/plasmoids/`  
  Where KDE's default plasmoids are stored.
* `~/.local/share/plasma/plasmoids/`  
  Where downloaded plasmoids are stored. It's also where this plasmoid will be installed to.

# Using Nethogs in Termoid
Install package `nethogs`  
Run `sudo setcap "cap_net_admin,cap_net_raw+pe" /usr/bin/nethogs` once on the system so that sudo permission is not required for running nethogs.

# TODOs
* Restart plasmoid command without restarting whole plasmashell.
* Support for Keyboard input.
* Support for button form in panel.
* Make sudo commands runnable.
* More configuration.

# Want to learn more about Plasmoids
## ExampleRepositories

Note that official KDE software is only mirrored on github, however github is much better for navigating the codebase.

* https://github.com/KDE/plasma-desktop/tree/master/applets
* https://github.com/KDE/plasma-workspace/blob/master/applets
* https://github.com/KDE/kdeplasma-addons/tree/master/applets
* https://github.com/KDE/plasma-pa/tree/master/applet
* https://github.com/KDE/plasma-nm/tree/master/applet
* https://github.com/KDE/discover/tree/master/notifier
* https://github.com/kotelnik/plasma-applet-weather-widget
* https://github.com/kotelnik/plasma-applet-redshift-control
* https://github.com/psifidotos/nowdock-plasmoid
* https://github.com/psifidotos/nowdock-panel
* https://github.com/dfaust/plasma-applet-netspeed-widget
* https://github.com/dfaust/plasma-applet-popup-launcher
* https://github.com/dfaust/plasma-applet-places-widget


## Documentation

* Plasma API Tutorials
	* Getting Started  
		https://techbase.kde.org/Development/Tutorials/Plasma5/QML2/GettingStarted
	* API Reference / Overview  
		https://techbase.kde.org/Development/Tutorials/Plasma2/QML2/API
* [QML documentation](http://doc.qt.io/qt-5/qtqml-syntax-basics.html)
* plasma-framework (PlasmaCore, PlasmaComponents, etc) API Documentation  
	https://api.kde.org/frameworks/plasma-framework/html/index.html
	* Source Code  
		https://github.com/KDE/plasma-framework/tree/master/src/declarativeimports/
* [plasmapkg2 source code](https://github.com/KDE/plasma-framework/blob/master/src/plasmapkg/plasmapkg.cpp)
