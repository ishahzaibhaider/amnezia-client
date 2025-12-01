import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import SortFilterProxyModel 0.2

import PageEnum 1.0
import ProtocolEnum 1.0
import ContainerProps 1.0
import ContainersModelFilters 1.0
import Style 1.0

import "./"
import "../Components"
import "../Controls2"
import "../Controls2/TextTypes"
import "../Config"
import "../Components"

PageType {
    id: root

    Connections {
        target: Qt.application

        function onStateChanged() {
            if (Qt.application.state !== Qt.ApplicationActive) {
                if (drawer.isOpened) {
                    drawer.closeTriggered()
                }
                if (homeSplitTunnelingDrawer.isOpened) {
                    homeSplitTunnelingDrawer.closeTriggered()
                }
            }
        }
    }

    Connections {
        objectName: "pageControllerConnections"

        target: PageController

        function onRestorePageHomeState(isContainerInstalled) {
            drawer.openTriggered()
            if (isContainerInstalled) {
                containersDropDown.rootButtonClickedFunction()
            }
        }
    }

    Connections {

        target: ApiPremV1MigrationController

        function onMigrationFinished() {
            apiPremV1MigrationDrawer.closeTriggered()

            var headerText = qsTr("You've successfully switched to the new Amnezia Premium subscription!")
            var descriptionText = qsTr("Old keys will no longer work. Please use your new subscription key to connect. \nThank you for staying with us!")
            var yesButtonText = qsTr("Continue")
            var noButtonText = ""

            var yesButtonFunction = function() {
            }
            var noButtonFunction = function() {
            }

            showQuestionDrawer(headerText, descriptionText, yesButtonText, noButtonText, yesButtonFunction, noButtonFunction)
        }

        function onShowMigrationDrawer() {
            apiPremV1MigrationDrawer.openTriggered()
        }
    }

    Item {
        objectName: "homeColumnItem"

        anchors.fill: parent
        anchors.bottomMargin: drawer.collapsedHeight

        ColumnLayout {
            objectName: "homeColumnLayout"

            anchors.fill: parent
            anchors.topMargin: 40 + SettingsController.safeAreaTopMargin
            anchors.bottomMargin: 16
            spacing: 0

            // Main Connect Button (centered, takes most space)
            ConnectButton {
                id: connectButton
                objectName: "connectButton"

                Layout.fillHeight: true
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 250
                Layout.preferredHeight: 250
                Layout.topMargin: 60
            }

            // Status Text
            Text {
                id: statusText
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 40
                
                text: ConnectionController.isConnected ? qsTr("Connected") :
                      ConnectionController.isConnecting ? qsTr("Connecting...") :
                      qsTr("Tap to connect :)")
                
                font.pixelSize: 16
                font.weight: Font.Normal
                color: AmneziaStyle.color.mutedGray
            }

            // Connection Stats (Visible when connected)
            ConnectionStats {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 24
                Layout.bottomMargin: 24
            }

            // Spacer to push everything up
            Item {
                Layout.fillHeight: true
                Layout.minimumHeight: 40
            }
        }
    }

    ServerSelectionDrawer {
        id: drawer
        objectName: "serverSelectionDrawer"
        anchors.fill: parent
    }
}
