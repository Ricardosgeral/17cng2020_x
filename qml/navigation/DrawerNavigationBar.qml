// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import "../common"

Drawer {
    id: myBar
    z: 1
    topMargin: unsafeArea.unsafeTopMargin
    topPadding: 0
    leftPadding: unsafeArea.unsafeLeftMargin
    property alias navigationButtons: navigationButtonRepeater
    property real activeOpacity: iconFolder == "black" ?  0.87 : 1.0
    property real inactiveOpacity: iconFolder == "black" ?  0.56 : 0.87 //  0.26 : 0.56
    width: drawerWidth
    height: appWindow.height
    interactive: !appWindow.modalMenuOpen && !appWindow.backKeyfreezed && !appWindow.modalPopupActive && !isTabletInLandscape
    modal: !isTabletInLandscape
    position: !isTabletInLandscape? 0 : 1
    visible: isTabletInLandscape

    Flickable {
        contentHeight: myButtons.height
        anchors.fill: parent
        clip: true
        ColumnLayout {
            id: myButtons
            focus: false
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0
            Item {
                //anchors.left: parent.left
                //anchors.right: parent.right
                Layout.fillWidth: true
                height: 120
                Rectangle {
                    anchors.fill: parent
                    color: primaryColor

                    Image {
                        id: drawerLogo
                        height: parent.height
                        source: "qrc:/images/extra/17CNG_app_drawer.png"
                        fillMode:Image.PreserveAspectFit
                    }

                }
// changed by above image
//                Item {
//                    anchors.left: parent.left
//                    anchors.right: parent.right
//                    anchors.bottom: parent.bottom
//                    height: 56
//                    Column {
//                        anchors.verticalCenter: parent.verticalCenter
//                        leftPadding: 16
//                        rightPadding: 16
//                        LabelBody {
//                            text: "17CNG-10 CLBG\n3-6 maio 2020, Lisboa, LNEC"
//                            wrapMode: Text.WordWrap
//                            font.weight: Font.Medium
//                            color: textOnPrimary
//                        }
//                        LabelBody {
//                            text: "SPG, LNEC, ABMS\n"
//                            color: textOnPrimary
//                        }
//                        LabelBody {
//                            text: qsTr("Powered by ricardos\xa92020\n")
//                            color: textOnPrimary
//                        }
//                    }
//                }
                Item {
                    // space between content - see google material guide
                    height: 8
                }
//                Image {
//                    id:imagedrawer
//                    width: 64
//                    height: 64
//                    x: 16
//                    y: 12
//                    source: "qrc:/images/extra/17CNGlogo.png"
//                }

            }
            Item {
                // space between content - see google material guide
                height: 8
            }
            Repeater {
                id: navigationButtonRepeater
                model: navigationModel
                Loader {
                    Layout.fillWidth: true
                    source: modelData.type
                    active: true
                }
            } // repeater
            //
        } // ColumnLayout myButtons
        ScrollIndicator.vertical: ScrollIndicator { }

    } // Flickable

    function replaceIcon(position, theIconName) {
        navigationButtonRepeater.itemAt(position).item.theIcon = theIconName
    }
    function replaceText(position, theText) {
        navigationButtonRepeater.itemAt(position).item.theText = theText
    }

} // drawer
