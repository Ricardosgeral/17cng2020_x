// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import org.ekkescorner.data 1.0

import "../common"

ScrollView {
    id: flickable
    // index to get access to Loader (Destination)
    property int myIndex: index
    contentHeight: appWindow.safeHeight
    contentWidth: appWindow.safeWidth
    // StackView manages this, so please no anchors here
    // anchors.fill: parent
    property string name: "VenuePage"

    Pane {
        id: root
        anchors.fill: parent
        topPadding: 0
        leftPadding: 0
        rightPadding: 0
        bottomPadding: 0


        ColumnLayout {
            spacing: 15
            width: Math.max(implicitWidth, flickable.availableWidth)
            anchors.right: parent.right
            anchors.left: parent.left


            Image {
                id: conferenceImage
                Layout.fillWidth: true

//                anchors.top: parent.top
//                anchors.topMargin: isLandscape? 16 : undefined
//                anchors.left: parent.left
                width: flickable.width * 0.9//isLandscape? appWindow.safeWidth/2 : appWindow.safeWidth
                fillMode: Image.PreserveAspectFit
                source: currentConference? currentConference.id === 201901? "qrc:/data-assets/conference/floorplan/centro_cong_LNEC.png" : "qrc:/data-assets/conference/floorplan/centro_cong_LNEC.png" : ""
                horizontalAlignment: Image.AlignHCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (Qt.platform.os === "ios"){
                            Qt.openUrlExternally("http://maps.apple.com/?q=bcc, Avenida do Brasil, 101, 1700-066, Lisboa, Portugal")
                        } else {
                            Qt.openUrlExternally("geo:0,0?q=LNEC Lisboa")
                        }
                    }
                }

            } // image


            RowLayout {
                visible: currentConference
                LabelTitle {
                    topPadding: 16
                    leftPadding: 16
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: currentConference? qsTr("Event Location")  : ""     // currentConference.conferenceCity)
                    color: accentColor
                }
            }
            RowLayout {
                visible: currentConference
                LabelBody {
                    leftPadding: 16
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: currentConference? currentConference.address : ""
                    color: primaryColor
                }
            }



            HorizontalDivider{ Layout.fillWidth: true }





        }

        //        //        RowLayout {
        //        //            visible: currentConference
        //        //            LabelSubheading {
        //        //                topPadding: 10
        //        //                leftPadding: 16
        //        //                rightPadding: 10
        //        //                wrapMode: Text.WordWrap
        //        //                text: currentConference? "<a href=\"" + currentConference.homePage + qsTr("\">Conference Homepage") + "</a>" : ""
        //        //                onLinkActivated: Qt.openUrlExternally(currentConference.homePage)
        //        //            }
        //        //        }
        //        RowLayout {
        //            visible: currentConference && Qt.platform.os !== "ios"
        //            Image {
        //                width: parent.width
        //                visible: status === Image.Ready || status === Image.Loading
        //                fillMode: Image.PreserveAspectFit
        //                source: "qrc:/data-assets/conference/floorplan/mapLNEC.png"

        //                MouseArea {
        //                    anchors.fill: parent
        //                    onClicked: {
        //                        if (Qt.platform.os === "ios"){
        //                            Qt.openUrlExternally("http://maps.apple.com/?q=bcc, Avenida do Brasil 101, 1700-066, Lisboa, Portugal")
        //                        } else {
        //                            Qt.openUrlExternally("geo:0,0?q=52.520427,13.416309")
        //                        }
        //                    }


        //                }



        //                //            LabelSubheading {
        //                //                topPadding: 10
        //                //                leftPadding: 16
        //                //                rightPadding: 10
        //                //                wrapMode: Text.WordWrap
        //                //                text: currentConference? "<a href=\"" + currentConference.homePage + qsTr("\">See in Google Maps") + "</a>" : ""
        //                //                onLinkActivated: Qt.openUrlExternally("https://www.google.com/maps/search/?api=1&query="+currentConference.coordinate+"&query_place_id="+currentConference.placeId)
        //                            }
        //            }
        //            //        RowLayout {
        //            //            visible: currentConference && Qt.platform.os === "ios" && currentConference.id === 201901
        //            //            LabelSubheading {
        //            //                topPadding: 10
        //            //                leftPadding: 16
        //            //                rightPadding: 10
        //            //                wrapMode: Text.WordWrap
        //            //                text: currentConference? "<a href=\"" + currentConference.homePage + qsTr("\">See in Apple Map") + "</a>" : ""
        //            //                onLinkActivated: Qt.openUrlExternally("http://maps.apple.com/maps/?sll="+currentConference.coordinate+"&address="+currentConference.mapAddress)
        //            //            }
        //            //        }

    } // root
    // ScrollIndicator.vertical: ScrollIndicator { }

    // emitting a Signal could be another option
    Component.onDestruction: {
        cleanup()
    }

    // called immediately after Loader.loaded
    function init() {
        console.log("Init done from VenuePage")
    }
    // called from Component.destruction
    function cleanup() {
        console.log("Cleanup done from VenuePage")
    }
} // flickable
