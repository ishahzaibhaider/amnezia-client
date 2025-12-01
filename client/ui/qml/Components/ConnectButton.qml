import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects

import ConnectionState 1.0
import PageEnum 1.0
import Style 1.0

Button {
    id: root

    property bool buttonActiveFocus: activeFocus && (Qt.platform.os !== "android" || SettingsController.isOnTv())
    property bool isFocusable: true
    
    Keys.onTabPressed: {
        FocusController.nextKeyTabItem()
    }

    Keys.onBacktabPressed: {
        FocusController.previousKeyTabItem()
    }

    Keys.onUpPressed: {
        FocusController.nextKeyUpItem()
    }
    
    Keys.onDownPressed: {
        FocusController.nextKeyDownItem()
    }
    
    Keys.onLeftPressed: {
        FocusController.nextKeyLeftItem()
    }

    Keys.onRightPressed: {
        FocusController.nextKeyRightItem()
    }
        
    implicitWidth: 250
    implicitHeight: 250

    text: ConnectionController.connectionStateText

    Connections {
        target: ConnectionController

        function onPreparingConfig() {
            PageController.showNotificationMessage(qsTr("Unable to disconnect during configuration preparation"))
        }
    }

    background: Item {
        implicitWidth: parent.width
        implicitHeight: parent.height
        transformOrigin: Item.Center

        // Segmented Ring (24 segments like competitor)
        Repeater {
            model: 24
            
            Rectangle {
                width: 8
                height: 24
                radius: 4
                
                x: root.width / 2 - width / 2
                y: 10
                
                transformOrigin: Item.Bottom
                
                rotation: index * 15
                
                color: {
                    if (ConnectionController.isConnected) {
                        return AmneziaStyle.color.primaryBlue
                    } else if (ConnectionController.isConnectionInProgress) {
                        // Animated segments during connection
                        return (index < (connectingProgress * 24)) ? 
                               AmneziaStyle.color.primaryLight : 
                               AmneziaStyle.color.slateGray
                    } else {
                        return AmneziaStyle.color.slateGray
                    }
                }
                
                opacity: {
                    if (ConnectionController.isConnected) {
                        return 1.0
                    } else if (ConnectionController.isConnectionInProgress) {
                        return 0.8
                    } else {
                        return 0.3
                    }
                }
                
                Behavior on color {
                    ColorAnimation { duration: 300 }
                }
                
                Behavior on opacity {
                    NumberAnimation { duration: 300 }
                }
            }
        }
        
        // Connecting animation progress
        property real connectingProgress: 0
        
        SequentialAnimation {
            running: ConnectionController.isConnectionInProgress
            loops: Animation.Infinite
            
            NumberAnimation {
                target: root.background
                property: "connectingProgress"
                from: 0
                to: 1
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }

        // Center Button Circle
        Rectangle {
            id: centerButton
            anchors.centerIn: parent
            width: 180
            height: 180
            radius: 90
            
            gradient: Gradient {
                GradientStop { position: 0.0; color: AmneziaStyle.color.slateGray }
                GradientStop { position: 1.0; color: AmneziaStyle.color.onyxBlack }
            }
            
            border.width: root.buttonActiveFocus ? 2 : 0
            border.color: AmneziaStyle.color.primaryBlue
            
            // Pulse animation when connected
            SequentialAnimation {
                running: ConnectionController.isConnected
                loops: Animation.Infinite
                
                NumberAnimation {
                    target: centerButton
                    property: "scale"
                    from: 1.0
                    to: 1.05
                    duration: 1500
                    easing.type: Easing.InOutQuad
                }
                
                NumberAnimation {
                    target: centerButton
                    property: "scale"
                    from: 1.05
                    to: 1.0
                    duration: 1500
                    easing.type: Easing.InOutQuad
                }
            }
            
            // Glow effect when connected
            layer.enabled: ConnectionController.isConnected
            layer.effect: Glow {
                samples: 20
                radius: 16
                color: AmneziaStyle.color.primaryBlue
                spread: 0.3
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                enabled: false
            }
        }
    }

    contentItem: Text {
        height: 24

        font.family: "PT Root UI VF"
        font.weight: 700
        font.pixelSize: 18

        color: {
            if (ConnectionController.isConnected) {
                return AmneziaStyle.color.primaryBlue
            } else if (ConnectionController.isConnectionInProgress) {
                return AmneziaStyle.color.primaryLight
            } else {
                return AmneziaStyle.color.paleGray
            }
        }
        
        text: {
            if (ConnectionController.isConnected) {
                return qsTr("CONNECTED")
            } else if (ConnectionController.isConnectionInProgress) {
                return qsTr("CONNECTING...")
            } else {
                return qsTr("CONNECT")
            }
        }

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        
        Behavior on color {
            ColorAnimation { duration: 300 }
        }
    }

    onClicked: {
        ServersModel.setProcessedServerIndex(ServersModel.defaultIndex)
        ConnectionController.connectButtonClicked()
    }

    Keys.onEnterPressed: this.clicked()
    Keys.onReturnPressed: this.clicked()
}
