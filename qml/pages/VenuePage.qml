// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import org.ekkescorner.data 1.0
import QtQuick.Window 2.10

import "../common"

ScrollView {
    id: flickable
    // index to get access to Loader (Destination)
    property int myIndex: index
    contentHeight: appWindow.height
//    contentWidth: appWindow.safeWidth

    property string name: "VenuePage"

    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.horizontal.interactive: false

//    height: appWindow.height
//    clip: true
    padding: 1

    topPadding: 10
    bottomPadding: 10
    leftPadding: unsafeArea.unsafeLeftMargin
    rightPadding: unsafeArea.unsafeRightMargin


    Image {
        id: conferenceImage
        width: isLandscape? parent.width/1.5 : parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: currentConference? currentConference.id === 201901? "qrc:/data-assets/conference/floorplan/centro_cong_LNEC.png" : "qrc:/data-assets/conference/floorplan/centro_cong_LNEC.png" : ""
        horizontalAlignment: Image.AlignHCenter

    } // image




    LabelTitle {
        id:labelTitle
        anchors.top: conferenceImage.bottom
        topPadding: 12
        leftPadding: 12
        rightPadding: 10
        wrapMode: Text.WordWrap
        text: currentConference? qsTr("Event Location")  : ""     // currentConference.conferenceCity)
        color: accentColor
    }


    LabelBody {
        id: labelbody
        anchors.top: labelTitle.bottom
        topPadding: 12
        bottomPadding: 18
        leftPadding: 16
        rightPadding: 10
        wrapMode: Text.WordWrap
        text: currentConference? currentConference.address : ""
        color: primaryColor
    }




    Image {
        id: conferenceMap
        anchors.top: labelbody.bottom

        width: isLandscape? parent.width/1.5 : parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: currentConference? currentConference.id === 201901? "qrc:/images/extra/mapLNEC.png" : "qrc:/images/extra/mapLNEC.png" : ""
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
