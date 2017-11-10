import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

import ".."
// import "../../code/utils.js" as Utils

ConfigPage {
    id: page

    property alias cfg_commandString: command.text
    property alias cfg_fontfamilyString: fontfamily.text
    property alias cfg_fontsizeString: fontsize.value
    property alias cfg_colorschemeInt: colorscheme.currentIndex
    property string cfg_colorschemetextString: cbItems.get(colorscheme.currentIndex).text
    property alias cfg_opacityInt: opacity.value

    Component.onCompleted: {
        cfg_commandString = plasmoid.configuration.command;
        cfg_fontfamilyString = plasmoid.configuration.fontfamily;
        cfg_fontsizeString = plasmoid.configuration.fontsize;
        cfg_colorschemeInt = plasmoid.configuration.colorscheme;
        colorscheme.currentIndex = cfg_colorschemeInt;
        cfg_opacityInt = plasmoid.configuration.opacity;
        
        console.log("ConfigPage loaded");
    }
    
    onCfg_commandStringChanged: {
        plasmoid.configuration.command = command.text;
        console.log("Command Updated " + command.text);
    }
    
    onCfg_fontfamilyStringChanged: { 
        plasmoid.configuration.fontfamily = fontfamily.text;
        console.log("Font Family Updated " + fontfamily.text);
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
        plasmoid.configuration.opacity = opacity.value;
        console.log("Opacity Widget Updated " + opacity.value);        
    }
    
    GroupBox {
        Layout.fillWidth: true

        ColumnLayout {
            Layout.fillWidth: true

            Text {
                text: i18n("Appearance")
                font.bold: true
            }

            RowLayout {
                Text {
                   text: i18n("Font") 
                }
                
                TextField {
                    id: fontfamily
                    placeholderText: cfg_fontfamilyString
                    Layout.fillWidth: true
                }
            }
            RowLayout {
                Text {
                   text: i18n("Font Size") 
                }
                
                SpinBox {
                    id: fontsize
                    suffix: i18n(" px")
                    maximumValue: 1000
                }
            }
            RowLayout {
                Text {
                   text: i18n("Color Scheme") 
                }
                
                ComboBox {
                    id: colorscheme
                    currentIndex: plasmoid.configuration.colorscheme
                    Layout.fillWidth: true
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
                    }
                }
            }
            RowLayout {
                Text {
                   text: i18n("Opacity")
                }
                
                SpinBox {
                    id: opacity
                    suffix: i18n(" %")
                    maximumValue: 100
                    stepSize: 1
                }
            }
        }
    }

    
    GroupBox {
        Layout.fillWidth: true

        ColumnLayout {
            Layout.fillWidth: true

            Text {
                text: i18n("Enter command to execute")
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
