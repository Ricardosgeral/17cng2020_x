// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import org.ekkescorner.data 1.0

import "../common"
import "../navigation"

Page {
    id: sessionDetailPage
    focus: true
    property string name: "SessionDetailPage"

    property Session session
    property bool isScheduleItem: false
    property int sessionId: -2
    onSessionIdChanged: {
        if(sessionId > 0) {
            session = dataManager.findSessionBySessionId(sessionId)
            // already resolved for the list
            // dataManager.resolveOrderReferences(order)
            // customer = order.customerAsDataObject
            isScheduleItem = session.isGenericScheduleSession
        }
    }

    Flickable {
        id: flickable
        property string name: "sessionDetail"
        // need some extra space if scrolling to bottom
        // and nothing covered by the FAB
        contentHeight: root.implicitHeight + 60
        anchors.fill: parent

        Pane {
            id: root
            anchors.fill: parent

            ColumnLayout {
                Layout.fillWidth: true
                anchors.right: parent.right
                anchors.left: parent.left
                RowLayout {
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    Layout.bottomMargin: 12
                    LabelTitle {
                        text: session.title
                        wrapMode: Text.WordWrap
                        font.bold: true
                    }
                }
                HorizontalDivider{}
                RowLayout {
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    ButtonOneCharUncolored {
                        visible: !isScheduleItem
                        // anchors.verticalCenter: parent.verticalCenter
                        Layout.alignment: Qt.AlignVCenter
                        Layout.minimumHeight: 42
                        Layout.minimumWidth: 36
                        Layout.maximumHeight: 42
                        Layout.maximumWidth: 36
                        text: dataUtil.letterForButton(session)
                    } // button one char
                    IconActive {
                        visible: isScheduleItem
                        // anchors.verticalCenter: parent.verticalCenter
                        Layout.alignment: Qt.AlignVCenter
                        //transform: Translate { x: -36 }
                        imageSize: 24
                        imageName: isScheduleItem? dataUtil.scheduleItemImageForSession(session) : ""
                    } // scheduleItemImage

                    LabelSubheading {
                        Layout.leftMargin: 16
                        // anchors.verticalCenter: parent.verticalCenter
                        Layout.alignment: Qt.AlignVCenter
                        text: dataUtil.textForSessionType(session)
                        wrapMode: Text.WordWrap
                    }
                    IconActive {
                        visible: !isScheduleItem
                        imageSize: 36
                        imageName: "stars.png"
                        opacity: session.isFavorite? opacityToggleActive : opacityToggleInactive
                        // anchors.right: parent.right
                        // anchors.top: parent.top
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                session.isFavorite = !session.isFavorite
                                if(session.isFavorite) {
                                    appWindow.showToast(qsTr("Added to Favorites"))
                                } else {
                                    appWindow.showToast(qsTr("Removed from Favorites"))
                                }
                                if(appWindow.myScheduleActive) {
                                    dataUtil.refreshMySchedule()
                                }
                            }
                        }
                    } // favoritesIcon
                }

                // T R A C K   REPEATER
                Repeater {
                    model: session.sessionTracksPropertyList
                    RowLayout {
                        visible: trackLabel.text.length > 0
                        Layout.leftMargin: 16
                        Layout.rightMargin: 16
                        IconActive{
                            visible: index == 0
                            imageSize: 24
                            imageName: "tag.png"
                        }
                        Item {
                            visible: index > 0
                            width: 24
                        }
                        Rectangle {
                            Layout.leftMargin: 16
                            width: 16
                            height: 16
                            color: model.modelData.color
                            radius: width / 2
                        }
                        LabelSubheading {
                            id: trackLabel
                            rightPadding: 16
                            text: dataUtil.textForSessionTrack(model.modelData)
                            wrapMode: Text.WordWrap
                        }
                    } // track row
                } // track repeater

                RowLayout {
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    IconActive{
                        imageSize: 24
                        imageName: "calendar.png"
                    }
                    LabelSubheading {
                        Layout.leftMargin: 16
                        text: session.sessionDayAsDataObject? session.sessionDayAsDataObject.conferenceDay.toLocaleDateString() : ""
                    }
                }
                RowLayout {
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    IconActive{
                        imageSize: 24
                        imageName: "time.png"
                    }
                    LabelSubheading {
                        Layout.leftMargin: 16
                        // text: session.startTime.toLocaleTimeString("HH:mm") + " - " + session.endTime.toLocaleTimeString("HH:mm")
                        text: session? dataUtil.displayStartToEnd(session) : ""
                    }
                }
                RowLayout {
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    transform: Translate{y: -10}
                    IconActive{
                        imageSize: 24
                        imageName: "directions.png"
                    }
                    LabelSubheading {
                        Layout.leftMargin: 16
                        text: session.roomAsDataObject? session.roomAsDataObject.roomName : ""
                    }
                    FloatingActionMiniButton {
                        z: 1
                        visible: session.roomAsDataObject // && session.roomAsDataObject.inAssets
                        transform: Translate{y: -6}
                        showShadow: true
                        imageSource: "qrc:/images/"+iconOnAccentFolder+"/directions.png"
                        backgroundColor: accentColor
                        // anchors.right: parent.right
                        Layout.alignment: Qt.AlignRight
                        onClicked: {
                            navPane.pushRoomDetail(session.roomAsDataObject.roomId)
                        }
                    } // favoritesIcon
                }
                LabelBodySecondary {
                    text: "id "+session.sessionId
                    font.italic: true
                    transform: Translate{y: -8}
                }
                HorizontalDivider{
                    height: 3
                    transform: Translate{y: -8}
                }
                //                LabelSubheading {
                //                    visible: session.subtitle.length
                //                    Layout.leftMargin: 16
                //                    Layout.rightMargin: 16
                //                    text: session.subtitle
                //                    wrapMode: Text.WordWrap
                //                }
                LabelSubheading {
                    visible: session.description.length
                    Layout.topMargin: 12
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    text: session.description
                    wrapMode: Text.WordWrap
                }

                HorizontalDivider{
                    visible: session.description.length // session.subtitle.length ||
                }

                LabelSubheading {
                    visible: session.abstractText.length
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    text: session.abstractText
                    wrapMode: Text.WordWrap
                }

                HorizontalDivider{
                    visible: session.abstractText.length
                }
                RowLayout {
                    visible: session.presenterPropertyList.length
                    Layout.leftMargin: 16
                    IconActive {
                        // anchors.verticalCenter: parent.verticalCenter
                        Layout.alignment: Qt.AlignVCenter
                        //transform: Translate { x: -36 }
                        imageSize: 36
                        imageName: "supervisor.png"
                    } // speaker image
                    LabelHeadline {
                        leftPadding: 10
                        text: qsTr("Authors")
                        color: primaryColor
                    }
                }
                LabelBodySecondary {
                    visible: session.presenterPropertyList.length
                    leftPadding: 16
                    font.italic: true
                    text: qsTr("Tap on the Author to get the Details. Authors sorted by alfabethical order!")
                    wrapMode: Text.WordWrap
                }
                HorizontalListDivider{
                    visible: session.presenterPropertyList.length
                }

                // S P E A K E R    Repeater
                Repeater {
                    model: session.presenterPropertyList

                    Pane {
                        padding: 0
                        Layout.fillWidth: true

                        ColumnLayout {
                            id: speakerRow
                            // without this divider not over total width
                            Layout.fillWidth: true
                            implicitWidth: sessionDetailPage.width
                            ItemDelegate {
                                implicitWidth: sessionDetailPage.width
                                Layout.minimumHeight: detailRow.height
                                RowLayout {
                                    id: detailRow
                                    spacing: 20
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.leftMargin: 16
                                    anchors.rightMargin: 16
                                    anchors.bottomMargin: 2
                                    SpeakerImageItem {
                                        speaker: model.modelData
                                    }
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        // without setting a maximum width, word wrap not working
                                        Layout.maximumWidth: appWindow.safeWidth-154
                                        spacing: 0
                                        LabelSubheading {
                                            rightPadding: 12
                                            text: model.modelData.name.length? model.modelData.name : qsTr("Unnamed Speaker")
                                            font.bold: true
                                            wrapMode: Label.WordWrap
                                        } // label
                                        LabelSubheading {
                                            visible: model.modelData.title.length
                                            rightPadding: 12
                                            bottomPadding: 6
                                            text: model.modelData.title
                                            wrapMode: Text.WordWrap
                                            font.italic: true
                                        }
                                        LabelBody {
                                            text: dataUtil.sessionInfoForSpeaker(model.modelData)
                                            rightPadding: 12
                                            wrapMode: Label.WordWrap
                                            maximumLineCount: 3
                                            elide: Label.ElideRight
                                        }
                                    }
                                    //                                MouseArea {
                                    //                                    anchors.fill: parent
                                    //                                    onClicked: {
                                    //                                        navPane.pushSpeakerDetail(model.modelData.speakerId)
                                    //                                    }
                                    //                                } // mouse
                                } // end Row Layout
                                onClicked: {
                                    navPane.pushSpeakerDetail(model.modelData.speakerId)
                                }
                            } // delegate
                            HorizontalListDivider{}
                        } // end Col Layout speaker row

                    }// presenter Pane
                } // speaker repeater
            } // main col layout

        }// root pane
        ScrollIndicator.vertical: ScrollIndicator { }
    } // flickable

    Component.onDestruction: {
        cleanup()
    }

    // called immediately after Loader.loaded
    function init() {
        console.log("Init done from SessionDetailPage")
    }
    // called from Component.destruction
    function cleanup() {
        console.log("Cleanup done from SessionDetailPage")
    }

} // page
