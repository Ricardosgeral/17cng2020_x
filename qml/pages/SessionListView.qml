// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import org.ekkescorner.data 1.0
import "../common"

ListView {
    id: listView
    focus: true
    clip: true
    // highlight: Rectangle {color: Material.listHighlightColor }
    currentIndex: -1
    anchors.fill: parent
    // setting the margin to be able to scroll the list above the FAB to use the Switch on last row
    bottomMargin: 40
    // QList<Session*>
    // conferenceDay.sessionsPropertyList

    delegate:

        Loader {
        id: sessionLoader
        // define Components inside Loader to enable direct access to ListView functions and modelData
        sourceComponent: isGenericScheduleSession? scheduleRowComponent : sessionRowComponent

        // LIST ROW DELEGATES
        Component {
            id: scheduleRowComponent

            ColumnLayout {
                id: scheduleRow
                // without setting impliciWidth divider not over total width
                implicitWidth: appWindow.safeWidth
                RowLayout {
                    spacing: 20
                    Layout.leftMargin: 20
                    Layout.rightMargin: 6
                    Layout.topMargin: 6
                    ColumnLayout {
                        IconActive {
                            //transform: Translate { x: -36 }
                            imageSize: 36
                            imageName: dataUtil.scheduleItemImageForSession(model.modelData)
                            // opacity: model.modelData.isFavorite? opacityToggleActive : opacityToggleInactive
                        } // scheduleItemImage
                    } // left column
                    ColumnLayout {
                        Layout.fillWidth: true
                        // without setting a maximum width, word wrap not working
                        Layout.maximumWidth: appWindow.safeWidth-132
                        Layout.minimumWidth: appWindow.safeWidth-132
                        spacing: 0
                        LabelTitle {
                            rightPadding: 12
                            text: model.modelData.title
                            color: primaryColor
                            //font.bold: true
                            wrapMode: Label.WordWrap
                            maximumLineCount: 2
                            elide: Label.ElideRight
                        } // label
                        LabelSubheading {
                            rightPadding: 12
                            bottomPadding: 6
                            font.italic: true
                            // text: model.modelData.startTime.toLocaleTimeString("HH:mm") + " - " + model.modelData.endTime.toLocaleTimeString("HH:mm")
                            text: dataUtil.displayStartToEnd(model.modelData)
                        }
                    } // middle column
//                    ListRowButton {
//                        onClicked: {
//                            navPane.pushSessionDetail(model.modelData.sessionId)
//                        }
//                    }
                }
            } // scheduleRow

        } // scheduleRowComponent

        Component {
            id: sessionRowComponent
            ItemDelegate {
                id: theItem
                height: sessionRow.height
                implicitWidth: appWindow.safeWidth
                Rectangle {
                    anchors.top: theItem.top
                    height: sessionRow.height-2
                    width: 8
                    color: dataUtil.trackColorFirstTrack(model.modelData)
                }
                onClicked: {
                    navPane.pushSessionDetail(model.modelData.sessionId)
                }

                ColumnLayout {
                    id: sessionRow
                    // without this divider not over total width
                    implicitWidth: appWindow.safeWidth
                    RowLayout {
                        spacing: 20
                        Layout.leftMargin: 16+12
                        Layout.rightMargin: 6
                        Layout.topMargin: 6
//                        ColumnLayout {
//                            CharCircle {
//                                size: 24
//                                text: dataUtil.letterForButton(model.modelData)
//                            }
//                        } // left column
                        ColumnLayout {
                            Layout.fillWidth: true
                            // without setting a maximum width, word wrap not working
                            Layout.maximumWidth: appWindow.safeWidth-132+44
                            Layout.minimumWidth: appWindow.safeWidth-132+44
                            spacing: 0
                            LabelSubheading {
                                rightPadding: 12
                                text: model.modelData.title
                                font.bold: true
                                wrapMode: Label.WordWrap
                                maximumLineCount: 3
                                elide: Label.ElideRight
                            } // label
                            RowLayout {
                                LabelBody {
                                    Layout.fillWidth: false
                                    // text: model.modelData.startTime.toLocaleTimeString("HH:mm") + " - " + model.modelData.endTime.toLocaleTimeString("HH:mm") + ","
                                    text: dataUtil.displayStartToEnd(model.modelData) + " "
                                }
                                IconActive{
                                    imageSize: 18
                                    imageName: "directions.png"
                                }
                                LabelBody {
                                    Layout.fillWidth: false
                                    text: model.modelData.roomAsDataObject? model.modelData.roomAsDataObject.roomName : ""
                                }
                            }
                            RowLayout {
                                visible: speakerNamesLabel.text.length
                                IconActive{
                                    imageSize: 18
                                    imageName: "supervisor.png"
                                }
                                LabelBody {
                                    id: speakerNamesLabel
                                    font.italic: true
                                    text: dataUtil.speakerNamesForSession(model.modelData)
                                    wrapMode: Label.WordWrap
                                    maximumLineCount: 3
                                    elide: Label.ElideRight
                                }
                            }
                        } // middle column
                        ColumnLayout {
                            Layout.rightMargin: 16
                            IconActive {
                                transform: Translate { x: -6 }
                                imageSize: 36
                                imageName: "stars.png"
                                opacity: model.modelData.isFavorite? opacityToggleActive : opacityToggleInactive
                                ListRowButton {
                                    onClicked: {
                                        model.modelData.isFavorite = !model.modelData.isFavorite
                                        if(model.modelData.isFavorite) {
                                            appWindow.showToast(qsTr("Added to My Favorites"))
                                        } else {
                                            appWindow.showToast(qsTr("Removed from My Favorites"))
                                        }
                                        if(appWindow.myScheduleActive) {
                                            dataUtil.refreshMySchedule()
                                        }
                                    }
                                }
                            } // favoritesIcon
                        } // right column
                    } // end Row Layout
                    HorizontalListDivider{}
                } // end Col Layout speaker row

            } // row item



        } // sessionRowComponent

    } // sessionLoader

    section.property: "sortKey"
    section.criteria: ViewSection.FullString
    section.delegate: sectionHeading
    ScrollIndicator.vertical: ScrollIndicator { }

} // end listView
