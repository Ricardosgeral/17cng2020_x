// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import org.ekkescorner.data 1.0
import QtQuick.Window 2.10

import "../common"
import "../popups"


ScrollView {
    id: homePage
    anchors.fill: parent
    anchors.margins: 10
    ScrollBar.horizontal.interactive: false

    height: appWindow.height
    contentHeight: column.implicitHeight

    clip: true
    padding: 1
    topPadding: 10
    bottomPadding: 10
    leftPadding: unsafeArea.unsafeLeftMargin
    rightPadding: unsafeArea.unsafeRightMargin


    property string name: "HomePage"
    // property Conference conference
    property string otherConferenceCity: dataUtil.otherConferenceCity()
    property bool isAutoVersionCheckMode: true
    onIsAutoVersionCheckModeChanged: {
        checkVersionPopup.isAutoVersionCheckMode = homePage.isAutoVersionCheckMode
        appWindow.autoVersionCheck = homePage.isAutoVersionCheckMode
    }




    ColumnLayout {
        id: column
        spacing: 15
        width: Math.max(implicitWidth, homePage.availableWidth)

        RowLayout {
            spacing: 10
            // setting Layout.fillWidth for the RowLayout is technically unnecessary,
            // because layouts have it on by default, but for the sake of clarity,
            // if you use anything else than a layout
            Layout.fillWidth: true

            // set Layout.fillWidth for the elements inside the RowLayout to make them expand
            Image{
                Layout.fillWidth: true
                Layout.maximumHeight: isTablet ?  250: 115

                Layout.maximumWidth: homePage.availableWidth
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/homepage_app.png"



            }

        }



        LabelBodySecondary{
            topPadding: -10
            bottomPadding: -5
            Layout.fillWidth: true
            text: qsTr("Mobile app powered by ricardos@lnec.pt")
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: isTablet ? 14 : 11
            font.italic: true
        }

        HorizontalDivider{Layout.fillWidth: true}


        LabelTitle{
            topPadding: 5
            bottomPadding: -5
            Layout.fillWidth: true
            text: qsTr("Organization")
            color: primaryColor
            //            font.pixelSize: 20
        }



        RowLayout {
            spacing: 10
            Image{
                Layout.maximumHeight: 40
                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/3.4
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/SPG_logo.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("https://www.spgeotecnia.pt/")
                    }
                }


            }

            Image{
                Layout.maximumHeight:40
                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/3.4
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/LNEC_logo.png"


                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("http://www.lnec.pt/")
                    }
                }


            }
            Image{
                Layout.maximumHeight:40
                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/3.4
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/ABMS_logo.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("https://www.abms.com.br")
                    }
                }

            }
        }


        HorizontalDivider{Layout.fillWidth: true}


        LabelTitle{
            topPadding: 5
            Layout.fillWidth: true
            text: qsTr("Sponsors")
            color: primaryColor
        }

//        LabelBodySecondary{
//            Layout.fillWidth: true
//            text: qsTr("Diamond: Banquet Sponsor")
//            font.pixelSize: 16
//        }


//        RowLayout {
//            Layout.fillWidth: true
//            // set Layout.fillWidth for the elements inside the RowLayout to make them expand
//            Image{
//                Layout.maximumHeight:65
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_diamond.png"
//            }

//        }


//        LabelBodySecondary{
//            Layout.fillWidth: true
//            text: qsTr("Platinum")
//            font.pixelSize: 16
//        }

//        RowLayout {
//            spacing: 10
//            Image{
//                Layout.maximumHeight: 60
//                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/3.2
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_platina.png"
//            }

//            Image{
//                Layout.maximumHeight:60
//                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/3.2
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_platina.png"
//            }
//            Image{
//                Layout.maximumHeight:60
//                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/3.2
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_platina.png"
//            }
//        }


//        LabelBodySecondary{
//            Layout.fillWidth: true
//            text: qsTr("Gold")
//            font.pixelSize: 16
//        }


//        RowLayout {
//            spacing: 10
//            Image{
//                Layout.maximumHeight: 60
//                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/4.4
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_ouro.png"
//            }

//            Image{
//                Layout.maximumHeight:60
//                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/4.4
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_ouro.png"
//            }
//            Image{
//                Layout.maximumHeight:60
//                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/4.4
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_ouro.png"
//            }
//            Image{
//                Layout.maximumHeight:60
//                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/4.4
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_ouro.png"
//            }
//        }


        LabelBodySecondary{
            Layout.fillWidth: true
            text: qsTr("Silver")
            font.pixelSize: 16
        }

        RowLayout {
//            spacing: 10
            Image{
                Layout.maximumHeight: 50
                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/3
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/Logo_TPF.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("https://www.tpf.pt/")
                    }
                }
            }

//            Image{
//                Layout.maximumHeight:50
//                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/5.7
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_prata.png"
//            }
//            Image{
//                Layout.maximumHeight:50
//                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/5.7
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_prata.png"
//            }
//            Image{
//                Layout.maximumHeight:50
//                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/5.7
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_prata.png"
//            }
//            Image{
//                Layout.maximumHeight:50
//                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/5.7
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_prata.png"
//            }
        }


        LabelBodySecondary{
            Layout.fillWidth: true
            text: qsTr("Bronze")
            font.pixelSize: 16
        }

        RowLayout {
//            spacing: 10
            Image{
                Layout.maximumHeight: 50
                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/4.5
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/Logo_JETsj.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("https://jetsj.com/")
                    }
                }

            }

//            Image{
//                Layout.maximumHeight:50
//                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/5.7
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_prata.png"
//            }
//            Image{
//                Layout.maximumHeight:50
//                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/5.7
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_prata.png"
//            }
//            Image{
//                Layout.maximumHeight:50
//                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/5.7
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_prata.png"
//            }
//            Image{
//                Layout.maximumHeight:50
//                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/5.7
//                Layout.fillWidth: true
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/images/extra/sponsors_types_prata.png"
//            }
        }

        HorizontalDivider{Layout.fillWidth: true}

        LabelTitle{
            topPadding: 5
            Layout.fillWidth: true
            text: qsTr("Technical Exposition")
            color: primaryColor
        }


        RowLayout {
            spacing: 10
            Image{
                Layout.maximumHeight: 60
                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/4
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/Logo_Geoarea.jpg"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("http://www.geoarea.pt/")
                    }
                }

            }

            Image{
                Layout.maximumHeight:60
                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/4.8
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/Logo_Geocontrolo.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("http://www.geocontrole.pt/")
                    }
                }

            }
            Image{
                Layout.maximumHeight:50
                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/16
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/Logo_JETsj.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("https://jetsj.com/")
                    }
                }

            }
        }



        RowLayout {
            spacing: 10
            Image{
                Layout.maximumHeight: 60
                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/3.8
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/Logo_Teixeiraduarte.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("http://www.teixeiraduarte.pt/")
                    }
                }

            }

            Image{
                Layout.maximumHeight:60
                Layout.maximumWidth: (Math.max(implicitWidth, homePage.availableWidth))/4.2
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/Logo_Tecnilab.png"


                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("https://www.tecnilab.pt/")
                    }
                }


            }
            Image{
                Layout.maximumHeight:50
                Layout.maximumWidth : (Math.max(implicitWidth, homePage.availableWidth))/10
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/extra/Logo_TPF.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally("https://www.tpf.pt/")
                    }
                }

            }
        }












        HorizontalDivider{Layout.fillWidth: true}




    }// Column

//    ButtonRaised {
//        width: parent.width
//        visible: true
//        id: gotosite
//        topPadding: 12
//        anchors.bottom: parent.Bottom
//        bottomPadding: 15
//        text: qsTr("Congress website")
//        font.bold: true
//        onClicked: {
//            Qt.openUrlExternally("http://17cng2020.lnec.pt")
//        }
//    }

//    HorizontalDivider{Layout.fillWidth: true}

    FloatingActionButton {
        visible: !homePage.isAutoVersionCheckMode || !currentConference
        property string imageName: "/refresh.png"
        z: 1
        anchors.margins: 15
        anchors.left: parent.left
        anchors.top: parent.top
        imageSource: "qrc:/images/"+iconOnAccentFolder+imageName
        backgroundColor: accentColor
        onClicked: {
            // check if there's no conference yet
            if(dataUtil.isNoConference()) {
                checkVersionExplicitely()
                return
            }
            // check if date is OK
            if(dataUtil.isDateTooLate()) {
                appWindow.showToast(qsTr("Sorry - the Conference is closed.\nNo more Updates available"))
                return
            }
            checkVersionExplicitely()
        }
    } // FAB


    //        Image {
    //            id: conferenceImage
    //            anchors.top: parent.top
    //            anchors.centerIn: parent.Center
    //    //        x: 16
    //    //        y: 16
    //            property int reduceWidth: isSmallDevice? appWindow.safeWidth/2 : 0
    //            width: isLandscape? undefined : appWindow.safeWidth - 32 - reduceWidth
    //            height: isLandscape? appWindow.safeHeight - 32 : undefined
    //            fillMode: Image.PreserveAspectFit
    //            source: "qrc:/images/extra/Intro.png"
    //            horizontalAlignment: isLandscape? Image.AlignAlignHCenter : Image.AlignHCenter
    //            verticalAlignment: Image.AlignTop
    //            transformOrigin: Item.TopLeft
    //        } // image



    //    LabelHeadline {
    //        id: conferenceTitle
    //        anchors.top: isLandscape? parent.top : conferenceImage.bottom
    //        anchors.topMargin: 10
    //        anchors.left: isLandscape? conferenceImage.right : parent.left
    //        anchors.leftMargin: isLandscape? 6 : 24
    //        text: currentConference? currentConference.id === 201902? qsTr("November, 29\nTOKYO, Japan") : qsTr("November, 04-06\nBERLIN, Germany") : ""
    //        color: accentColor
    //    }

    //    ButtonRaised {
    //        visible: currentConference
    //        id: conferenceSwitchButton
    //        anchors.bottom: parent.bottom
    //        anchors.bottomMargin:  20 + unsafeArea.unsafeBottomMargin
    //        anchors.left: conferenceTitle.left
    //        text: qsTr("Change to %1").arg(otherConferenceCity)
    //        onClicked: {
    //            currentConference = dataUtil.switchConference()
    //            appWindow.conferenceSwitched()
    //            otherConferenceCity = dataUtil.otherConferenceCity()
    //        }
    //    }


    // open modal dialog and wait if update required
    function checkVersionExplicitely() {
        homePage.isAutoVersionCheckMode = false
        checkVersionPopup.text = qsTr("Checking Conference Server\nfor new Program Data ...")
        checkVersionPopup.buttonsVisible = false
        checkVersionPopup.isUpdate = false
        checkVersionPopup.open()
    }
    function checkVersionAutomatically() {
        homePage.isAutoVersionCheckMode = true
        dataUtil.checkVersion()
    }
    // open modal dialog and wait
    function updateFromOldConference() {
        homePage.isAutoVersionCheckMode = false
        checkVersionPopup.text = qsTr("New Conference Data available ...")
        checkVersionPopup.buttonsVisible = false
        checkVersionPopup.isUpdate = false
        checkVersionPopup.open()
    }

    PopupUpdate {
        id: checkVersionPopup
        modal: true
        closePolicy: Popup.NoAutoClose
        onOpened: {
            dataUtil.checkVersion()
        }
        onClosed: {
            if(checkVersionPopup.isUpdate) {
                rootPane.startUpdate()
                return
            }
            if(checkVersionPopup.doItManually) {
                homePage.isAutoVersionCheckMode = false
                return
            }
            // try it later
            homePage.isAutoVersionCheckMode = true
            rootPane.startAutoVersionCheckTimer()
        }
    } // checkVersionPopup

    function updateDone() {
        // update was done with success
        // so we switch back to auto version check if coming from manually version check
        homePage.isAutoVersionCheckMode = true
    }

    function updateAvailable(apiVersion) {
        console.log("QML updateAvailable " + apiVersion)
        checkVersionPopup.text = qsTr("Update available.\nAPI Version: ")+apiVersion
        checkVersionPopup.showUpdateButton = true
        checkVersionPopup.buttonsVisible = true
        checkVersionPopup.isAutoVersionCheckMode = homePage.isAutoVersionCheckMode
        if(isAutoVersionCheckMode) {
            rootPane.gotoFirstDestination()
            checkVersionPopup.open()
        }
    }
    function noUpdateRequired() {
        console.log("QML noUpdateRequired")
        if(isAutoVersionCheckMode) {
            rootPane.startAutoVersionCheckTimer()
            return
        }
        checkVersionPopup.text = qsTr("No Update required.")
        checkVersionPopup.showUpdateButton = false
        checkVersionPopup.buttonsVisible = true
    }
    function checkFailed(message) {
        console.log("QML checkFailed "+message)
        if(isAutoVersionCheckMode) {
            rootPane.startAutoVersionCheckTimer()
            return
        }
        checkVersionPopup.text = qsTr("Version Check failed:\n")+message
        checkVersionPopup.showUpdateButton = false
        checkVersionPopup.buttonsVisible = true
    }
    Connections {
        target: dataUtil
        onUpdateAvailable: updateAvailable(apiVersion)
    }
    Connections {
        target: dataUtil
        onNoUpdateRequired: noUpdateRequired()
    }
    Connections {
        target: dataUtil
        onCheckForUpdateFailed: checkFailed(message)
    }
    Connections {
        target: appWindow
        onDoAutoVersionCheck: checkVersionAutomatically()
    }
    Connections {
        target: appWindow
        onOldConference: updateFromOldConference()
    }

    // also catched from main
    Connections {
        target: dataUtil
        onUpdateDone: rootPane.updateDone()
    }

    // emitting a Signal could be another option
    Component.onDestruction: {
        cleanup()
    }


    // called immediately after Loader.loaded
    function init() {
        // conference = dataManager.conferencePropertyList.length > 0? dataManager.conferencePropertyList[0] : dataManager.createConference()
        console.log("Init done from Home Page")
    }
    // called from Component.destruction
    function cleanup() {
        console.log("Cleanup done from Home Page")
    }

}//pane
