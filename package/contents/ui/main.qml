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
import org.kde.plasma.components 2.0 as PlasmaComponentss

import QMLTermWidget 1.0


import "../code/utils.js" as Utils

Item{
    id: main

    width: plasmoid.configuration.width
    height: plasmoid.configuration.height

    Layout.minimumWidth: units.gridUnit * 10
    Layout.minimumHeight: units.gridUnit * 10

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
        colorScheme: plasmoid.configuration.colorschemetext === null ? "Linux" : plasmoid.configuration.colorschemetext

        opacity: plasmoid.configuration.opacity / 100

        session: QMLTermSession{
            id: mainsession
            initialWorkingDirectory: "$HOME"
        }

        Component.onCompleted: {
            mainsession.setShellProgram(plasmoid.configuration.command === "" ? "$SHELL" : Utils.prog(plasmoid.configuration.command));
            mainsession.setArgs(Utils.arg(plasmoid.configuration.command) || []);

            mainsession.startShellProgram();
        }

        // Enable keyboard input on mouse click over the plasmoid window
        MouseArea {
            anchors.fill: parent

            onClicked: {
                forceActiveFocus(Qt.MouseFocusReason);
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
    }
}
