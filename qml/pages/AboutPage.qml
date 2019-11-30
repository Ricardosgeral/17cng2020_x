// ricardos.geral @gmail.com
// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import "../common"

Flickable {
    id: flickable
    // index to get access to Loader (Destination)
    property int myIndex: index
    contentHeight: root.implicitHeight
    // StackView manages this, so please no anchors here
    // anchors.fill: parent
    property string name: "About"

    Pane {
        id: root
        anchors.fill: parent
        anchors.leftMargin: unsafeArea.unsafeLeftMargin
        anchors.rightMargin: unsafeArea.unsafeRightMargin
        ColumnLayout {
            anchors.right: parent.right
            anchors.left: parent.left
            RowLayout {
                ColumnLayout {
                    Image {
                        source: "qrc:/images/extra/17CNGlogo@2x.png"
                    }
                    LabelBodySecondary {
                        text: "Version: 1.02";
                    }
                    LabelBodySecondary {
                        text: "API: "+dataManager.settingsData().apiVersion;
                    }
                }
                LabelHeadline {
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("17CNG, 10CLBG \n3-6 de maio de 2020\nLisboa - LNEC\nMobile App")
                    color: primaryColor
                }

            }

            HorizontalDivider {}
            RowLayout {
                LabelSubheading {
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("17º Congresso Nacional de Geotecnia\n10º Cong. Luso Brasileiro de Geotecnia\n11º Encontro de Jovens Geotécnicos")
                    color: accentColor
                }
            }
            HorizontalDivider {}
            RowLayout {
                LabelTitle {
                    wrapMode: Text.WordWrap
                    text: qsTr("Organization")
                    color: primaryColor
                }
            }

            RowLayout {

                Image {
                    x: 15
                    source: "qrc:/images/extra/SPG_logo.png"
                }
            }
            RowLayout {
                Image {
                    x:15
                    source: "qrc:/images/extra/LNEC_logo.png"
                }
            }

            RowLayout {
                Image {
                    x:15
                    source: "qrc:/images/extra/ABMS_logo.png"
                }
            }

            HorizontalDivider {}

            RowLayout {
                LabelSubheading {
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("This mobile APP is provided to help participants of <a href=\"http://http://17cng2020.lnec.pt\">17CNG | 10CLBG</a>, which will take place from 3 to 6 May 2020, in Lisbon, at the National Laboratory of Civil Engineering (LNEC).")
                    onLinkActivated: Qt.openUrlExternally("http://17cng2020.lnec.pt")
                }
            }
            HorizontalDivider {}


            RowLayout {
                LabelSubheading {
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("App powered by\nRicardo Correia dos Santos (LNEC)\nricardos@lnec.pt")
                }
            }

            HorizontalDivider {}

            RowLayout {
                LabelSubheading {
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("All work is available at my <a href=\"https://https://github.com/Ricardosgeral/17cng2020_mobX\">Github repository</a>, and is based on the work developed by @ekkescorner. \nDanke schon für deine hilfe ekke!")
                    onLinkActivated: Qt.openUrlExternally("https://github.com/Ricardosgeral/17cng2020_mobX")
                }
            }

//
            HorizontalDivider {}

        } // col layout
    } // root

    ScrollIndicator.vertical: ScrollIndicator { }

    // emitting a Signal could be another option
    Component.onDestruction: {
        cleanup()
    }

    // called immediately after Loader.loaded
    function init() {
        console.log("Init done from ABOUT")
    }
    // called from Component.destruction
    function cleanup() {
        console.log("Cleanup done from ABOUT")
    }
} // flickable
