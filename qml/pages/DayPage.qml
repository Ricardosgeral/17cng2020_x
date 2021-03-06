// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import org.ekkescorner.data 1.0
import "../common"

Page {
    id: dayListPage
    focus: true
    property string name: "dayListPage"
    property Day conferenceDay
    property alias theModel: listView.model
    bottomPadding: 6
    topPadding: 6

    property int dayIndex

    // SECTION HEADER DELEGATE
    Component {
        id: sectionHeading
        Pane {
            topPadding: 0
            bottomPadding: 12
            leftPadding: 0
            rightPadding: 0
            width: parent.width
            background: Rectangle{color: Material.listHighlightColor}
            ColumnLayout {
                y: -6
                width: parent.width
                height: 48
                RowLayout {
                    Layout.topMargin: 6
                    spacing: 10

                    LabelTitle {
                        text: dataUtil.localWeekdayAndTime(section)
                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        color: accentColor
                        font.bold: true
                        bottomPadding: 3
                        font.pixelSize: 14
                    }
                } // section row
                //HorizontalListDivider{}
            } // section col
        } // section Pane
    } // sectionHeading Component

    // LIST VIEW
    SessionListView {
        id: listView
    }

    function goToItemIndex(theIndex) {
        if(theIndex === -1) {
            appWindow.showToast(qsTr("No item found"))
            return
        }
        if(theIndex > 0) {
            if(theIndex === listView.model.length) {
                appWindow.showToast(qsTr("Too late for a Presentation"))
            }

            theIndex = theIndex-1
        }

        listView.positionViewAtIndex(theIndex, ListView.Beginning)
    }

    Component.onDestruction: {
        cleanup()
    }

    function init() {
        console.log("Init done from dayListPage")
        console.log("Day# "+currentConference.daysPropertyList.length)
        if(currentConference.daysPropertyList.length > 0) {
            conferenceDay = currentConference.daysPropertyList[dayIndex]
            console.log(conferenceDay.conferenceDay)
            console.log("Sessions:"+conferenceDay.sessionsPropertyList.length)
            listView.model = conferenceDay.sessionsPropertyList
        } else {
            listView.model =  []
        }
    }
    Component.onCompleted: {
        // init()
    }

    // called from Component.destruction
    function cleanup() {
        console.log("Cleanup done from dayListPage")
    }
} // end primaryPage
