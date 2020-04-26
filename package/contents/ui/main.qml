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
import QtQuick.Controls 1.2

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import QMLTermWidget 1.0


import "../code/utils.js" as Utils

Item{
    id: main

    width: plasmoid.configuration.width
    height: plasmoid.configuration.height

    Layout.minimumWidth: units.gridUnit * 10
    Layout.minimumHeight: units.gridUnit * 10
    
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: plasmoid.configuration.showBackground ? PlasmaCore.Types.DefaultBackground : PlasmaCore.Types.NoBackground
    
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

    Component.onCompleted: {
        plasmoid.setAction("openKonsole", i18n("Start Konsole"), "utilities-terminal");
    }

    onWidthChanged: { plasmoid.configuration.width = main.width }
    onHeightChanged: { plasmoid.configuration.height = main.height }

    QMLTermWidget {
        id: terminal
        anchors.fill: parent
        
        font.family: plasmoid.configuration.fontfamily === "" ? "Monospace" : plasmoid.configuration.fontfamily || theme.defaultFont.family
        font.pointSize: plasmoid.configuration.fontsize === "" ? "12" : plasmoid.configuration.fontsize
        antialiasText:true

        colorScheme: plasmoid.configuration.colorschemetext === null ? "Linux" : plasmoid.configuration.colorschemetext
        opacity: plasmoid.configuration.opacity / 100
        fullCursorHeight: true

        session: QMLTermSession{
            id: mainsession
            initialWorkingDirectory: "$HOME"
            //shellProgram: plasmoid.configuration.command === "" ? "$SHELL" : Utils.prog(plasmoid.configuration.command)
            //shellProgramArgs: Utils.arg(plasmoid.configuration.command) || []
        }

        Component.onCompleted: {
            mainsession.setShellProgram(plasmoid.configuration.command === "" ? "$SHELL" : Utils.prog(plasmoid.configuration.command));
            mainsession.setArgs(Utils.arg(plasmoid.configuration.command) || []);
            console.log("Running with session shellProgram: " + JSON.stringify(mainsession))
            mainsession.startShellProgram();
            forceActiveFocus();
        }
        
        // Switch focus properly to terminal to allow text selection
        onFocusChanged:
        {
            mouse_area.enabled = !terminal.focus
        }
        
        // Enable keyboard input on mouse click over the plasmoid window
        MouseArea {
            id: mouse_area
            anchors.fill: parent
            propagateComposedEvents: false
            cursorShape: terminal.terminalUsesMouse ? Qt.ArrowCursor : Qt.IBeamCursor
            acceptedButtons: Qt.RightButton | Qt.LeftButton
            
            // Pass on the events to terminal object to enable text selection
            onDoubleClicked:
            {
                var coord = correctDistortion(mouse.x, mouse.y);
                terminal.simulateMouseDoubleClick(coord.x, coord.y, mouse.button, mouse.buttons, mouse.modifiers);
            }
            
            onPressed: 
            {
                var coord = correctDistortion(mouse.x, mouse.y);
                terminal.simulateMousePress(coord.x, coord.y, mouse.button, mouse.buttons, mouse.modifiers)
            }
            
            onReleased: 
            {
                var coord = correctDistortion(mouse.x, mouse.y);
                terminal.simulateMouseRelease(coord.x, coord.y, mouse.button, mouse.buttons, mouse.modifiers);
            }
            
            onPositionChanged:
            {
                var coord = correctDistortion(mouse.x, mouse.y);
                terminal.simulateMouseMove(coord.x, coord.y, mouse.button, mouse.buttons, mouse.modifiers);
            }
            
            onClicked:
            {
                if(mouse.button === Qt.LeftButton)
                    terminal.forceActiveFocus()
            }
        }

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
        
        // Manage copy and paste
        Connections{
            target: copyAction
            onTriggered: terminal.copyClipboard();
        }
        Connections{
            target: pasteAction
            onTriggered: terminal.pasteClipboard()
        }
    }
    
    Action{
        id: copyAction
        text: qsTr("Copy")
        shortcut: "Ctrl+Shift+C"
    }
    Action{
        id: pasteAction
        text: qsTr("Paste")
        shortcut: "Ctrl+Shift+V"
    }

    function correctDistortion(x, y)
    {   
        x = x / width;
        y = y / height;
        
        var cc = Qt.size(0.5 - x, 0.5 - y);
        var distortion = 0;
        
        return Qt.point((x - cc.width  * (1+distortion) * distortion) * terminal.width,
                        (y - cc.height * (1+distortion) * distortion) * terminal.height)
    }
}
