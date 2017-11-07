    /***************************************************************************
 *   Copyright (C) 2012-2013 by Eike Hein <hein@kde.org>                   *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import QMLTermWidget 1.0
import QtQuick.Controls 1.2

// import "../code/utils.js" as Utils

Item{
    id: main
    opacity: plasmoid.configuration.opacity / 100

    Layout.minimumWidth: units.gridUnit * 1
    Layout.minimumHeight: units.gridUnit * 1
    Layout.preferredWidth: units.gridUnit * 640
    Layout.preferredHeight: units.gridUnit * 480
    Layout.maximumWidth: plasmoid.screenGeometry.width
    Layout.maximumHeight: plasmoid.screenGeometry.height
    
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    
    PlasmaCore.DataSource {
        id: executeSource
        engine: "executable"
        connectedSources: []
        onNewData: {
            disconnectSource(sourceName)
        }
    }
    
    function exec(cmd) {
        executeSource.connectSource(cmd)
    }
    
    function action_openKonsole() {
        exec("konsole");
    }
    // args
    Component.onCompleted: {
        plasmoid.setAction("openKonsole", i18n("Start Konsole"), "utilities-terminal");
    }
    
    property string command: plasmoid.configuration.command || "Linux"
    
    QMLTermWidget {
        id: terminal
        anchors.fill: parent
        font.family: plasmoid.configuration.fontfamily == "" ? "Monospace" : plasmoid.configuration.fontfamily || theme.defaultFont.family
        font.pointSize: plasmoid.configuration.fontsize == "" ? "12" : plasmoid.configuration.fontsize
        colorScheme: plasmoid.configuration.colorschemetext == null ? "Linux" : plasmoid.configuration.colorschemetext
        session: QMLTermSession{
            id: mainsession
            initialWorkingDirectory: "$HOME"
            
            function prog(cmd) {
                var l = cmd.split(' ');
                return l.shift();
            }
            
            function args(cmd) {
                var l = cmd.split(' ');
                l.shift();
                return l;                       // retrun list
            }
            
            Component.onCompleted: {

                console.log("Starting: %1 %2".arg(prog(plasmoid.configuration.command)).arg(args(plasmoid.configuration.command)));
            }

            shellProgram: plasmoid.configuration.command == "" ? "/bin/bash" : prog(plasmoid.configuration.command)
            shellProgramArgs: args(plasmoid.configuration.command)
            
        }
        
        Component.onCompleted: mainsession.startShellProgram();
        QMLTermScrollbar {
            terminal: terminal
            width: 20
            Rectangle {
                opacity: 0.4
                anchors.margins: 5
                radius: width * 0.5
                anchors.fill: parent
            }
        }
    }
}
