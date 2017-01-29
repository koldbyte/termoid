# Termoid

Terminal in a plasmoid

The plasmoid depends on `qmltermwidget`.

# Features
* Terminal :)
* Font family and Font size configurable
* Comes with inbuilt color schemes 

# Screenshots

# Get it 
[Store link]TODO

# Requirements
Currently using it to show Nethogs in the plasmoid. 
So you need to install package `nethogs`
Dont forget to `sudo setcap "cap_net_admin,cap_net_raw+pe" /usr/bin/nethogs` as we cannot not run sudo inside this plasmoid.

You will also require to install `qmltermwidget` as this is the core of the plasmoid.


## Build it Yourself
* Download the source[Master link]
* Untar and cd into directory
* ./build
* ./install      (for first time)
* ./reinstall    (for updating the plasmoid)

Add the Termoid widget from "Add widgets" on your desktop

* The `build`/`run` commands require `kreadconfig5`.
* Do *not* run the `install`/`reinstall` scripts with `sudo` or the plasmoid will be placed in `/usr/share/` instead of your home directory.

## Locations

* `/usr/share/plasma/plasmoids/`  
  Where KDE's default plasmoids are stored.
* `~/.local/share/plasma/plasmoids/`  
  Where downloaded plasmoids are stored. It's also where this plasmoid will be installed to.

# TODOs
* Make this a proper terminal on plasmoid as keyboard input is not working currently.
* sudo commands not runnable.
* Adjust according to how people use it. Currently tested to run Nethogs. Need to know more usecases.
* More configuration
* Transparency
  
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
