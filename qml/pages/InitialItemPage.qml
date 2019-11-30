import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "../common"

Pane {
    id: pane
    property string name: "InitialItemPage"
    property int myIndex: -1
    width: appWindow.safeWidth
    property alias imageWidth: image.width
    LabelHeadline {
        id: initLabel
        anchors.left: parent.left
        anchors.right: parent.right
        topPadding: 12 + unsafeArea.unsafeTopMargin
        wrapMode: Label.WordWrap
        horizontalAlignment: Qt.AlignHCenter
        text: qsTr("Welcome to\n17cng2020")
    }
    BusyIndicator {
        id: busyIndicator
        topPadding: 24
        property int size: Math.min(rootPane.width, rootPane.height) / 5
        implicitHeight: size
        implicitWidth: size
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: initLabel.bottom
    }
    LabelTitle {
        id: infoLabel
        anchors.top: busyIndicator.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        wrapMode: Label.WordWrap
        horizontalAlignment: Qt.AlignHCenter
        topPadding: 12
        color: primaryColor
    }
    LabelSubheading {
        id: progressLabel
        anchors.top: infoLabel.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        wrapMode: Label.WrapAnywhere
        topPadding: 6
        leftPadding: 16
        rightPadding: 16
        color: accentColor
    }
    Item {
        id: imageItem
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: progressLabel.bottom

        Image {
            id: image
            property int size: Math.min(400, (pane.width))
            width: size
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/extra/17cng2020_intro.png"
        }
    }

    // emitting a Signal could be another option
    Component.onDestruction: {
        cleanup()
    }
    // called immediately after Loader.loaded
    function init() {
        console.log("Init done from InitialItemPage")
    }
    function update() {
        console.log("InitialItemPage running from UPDATE")
        imageItem.visible = false
        initLabel.text = qsTr("Conference APP\nfor\n17CNG-10CLBG 2020")
        infoLabel.text = qsTr("Conference Program will be updated...")
    }

    function showProgress(info) {
        progressLabel.text = info
    }

    function showInfo(info) {
        console.log("INFO: "+info)
        infoLabel.text = info
    }

    // called from Component.destruction
    function cleanup() {
        console.log("Cleanup done from InitialItemPage")
    }
} // initialItem
