import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import org.kde.plasma.components 2.0 as PlasmaComponents

import ".."

ConfigPage {
    id: page

    property alias cfg_commandString: command.text
    property alias cfg_fontfamilyString: fontfamily.currentText
    property alias cfg_fontsizeString: fontsize.value
    property alias cfg_colorschemeInt: colorscheme.currentIndex
    property string cfg_colorschemetextString: cbItems.get(colorscheme.currentIndex).text
    property alias cfg_opacityInt: opacity_spin.value
    property alias cfg_showBackgroundBool: show_background_switch.checked
    width: 500
    height: 250

    Component.onCompleted: {
        cfg_commandString = plasmoid.configuration.command;
        cfg_fontsizeString = plasmoid.configuration.fontsize;
        cfg_colorschemeInt = plasmoid.configuration.colorscheme;
        colorscheme.currentIndex = cfg_colorschemeInt;
        cfg_opacityInt = plasmoid.configuration.opacity;
        cfg_showBackgroundBool = plasmoid.configuration.showBackground
        
        console.log("ConfigPage loaded");
    }
    
    onCfg_commandStringChanged: {
        plasmoid.configuration.command = command.text;
        console.log("Command Updated " + command.text);
    }
    
    onCfg_fontfamilyStringChanged: {
        plasmoid.configuration.fontfamily = fontfamily.currentText;
        console.log("Font Family Updated " + fontfamily.currentText);
    }
    
    onCfg_fontsizeStringChanged: {
        plasmoid.configuration.fontsize = fontsize.value;
        console.log("Font size Updated " + fontsize.value);        
    }
    
    onCfg_colorschemeIntChanged: {
        plasmoid.configuration.colorscheme = colorscheme.currentIndex;
        plasmoid.configuration.colorschemetext = cbItems.get(colorscheme.currentIndex).text;
        console.log("Color Scheme Updated " + colorscheme.currentIndex + " " + cbItems.get(colorscheme.currentIndex).text);        
    }
    
    onCfg_opacityIntChanged: {
        plasmoid.configuration.opacity = opacity_spin.value;
        console.log("Opacity Widget Updated " + opacity_spin.value);
    }

    onCfg_showBackgroundBoolChanged: {
        plasmoid.configuration.showBackground = show_background_switch.checked;
        console.log("Show Background Updated " + show_background_switch.checked);
    }
    
    GroupBox {
        Layout.fillWidth: true

        ColumnLayout {
            spacing: 8
            anchors.fill: parent
            Layout.fillWidth: true

            PlasmaComponents.Label {
                text: i18n("Appearance")
                font.bold: true
            }

            GridLayout{
                columns: 2
                PlasmaComponents.Label {
                   id: text1
                   text: i18n("Font")
                }

                ComboBox {
                    id: fontfamily
                    model: Qt.fontFamilies()
                    currentIndex: Qt.fontFamilies().indexOf(plasmoid.configuration.fontfamily)
                }

                PlasmaComponents.Label {
                   text: i18n("Font Size")
                }

                SpinBox {
                    id: fontsize
                    suffix: i18n(" px")
                    value: plasmoid.configuration.fontsize
                    maximumValue: 1000
                }

                PlasmaComponents.Label {
                   id: labelText
                   text: i18n("Color Scheme")
                }

                ComboBox {
                    id: colorscheme
                    currentIndex: plasmoid.configuration.colorscheme
                    model: ListModel {
                        id: cbItems
                        ListElement { text: "BlackOnLightYellow"; }
                        ListElement { text: "BlackOnRandomLight"; }
                        ListElement { text: "Linux"; }
                        ListElement { text: "BlackOnWhite"; }
                        ListElement { text: "DarkPastels"; }
                        ListElement { text: "GreenOnBlack"; }
                        ListElement { text: "WhiteOnBlack"; }
                        ListElement { text: "BreezeModified"; }
                        ListElement { text: "cool-retro-term"; }
                    }
                }

                PlasmaComponents.Label {
                   text: i18n("Opacity")
                }

                SpinBox {
                    id: opacity_spin
                    value: plasmoid.configuration.opacity
                    suffix: i18n(" %")
                    minimumValue: 0
                    maximumValue: 100
                    stepSize: 1
                }

                PlasmaComponents.Label {
                   text: i18n("Show Background")
                }

                CheckBox {
                    id: show_background_switch
                    checked: plasmoid.configuration.showBackground
                }
            }
        }
    }

    
    GroupBox {
        Layout.fillWidth: true

        ColumnLayout {
            Layout.fillWidth: true

            PlasmaComponents.Label {
                text: i18n("Enter command(with arguments if any) to execute")
                font.bold: true
                Layout.fillWidth: true
            }

            TextField {
                id: command
                placeholderText: cfg_commandString
                Layout.fillWidth: true
            }
        }
    }

}
