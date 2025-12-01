import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../Controls2"
import "../Components"
import Style 1.0

DrawerType2 {
    id: root
    
    collapsedHeight: 80
    expandedHeight: parent.height * 0.75
    
    // Hardcoded model for testing
    ListModel {
        id: serversModel
        
        ListElement {
            name: "United States"
            location: "US West"
            flag: "🇺🇸"
            signal: 4
            isPremium: false
        }
        ListElement {
            name: "United States"
            location: "US East"
            flag: "🇺🇸"
            signal: 3
            isPremium: false
        }
        ListElement {
            name: "United Kingdom"
            location: "London"
            flag: "🇬🇧"
            signal: 3
            isPremium: false
        }
        ListElement {
            name: "Germany"
            location: "Frankfurt"
            flag: "🇩🇪"
            signal: 4
            isPremium: false
        }
        ListElement {
            name: "Singapore"
            location: "Singapore"
            flag: "🇸🇬"
            signal: 2
            isPremium: false
        }
        ListElement {
            name: "Australia"
            location: "Sydney"
            flag: "🇦🇺"
            signal: 2
            isPremium: true
        }
    }
    
    property int selectedIndex: 0
    
    collapsedStateContent: Item {
        height: root.collapsedHeight
        
        ColumnLayout {
            anchors.fill: parent
            spacing: 0
            
            // Drag Handle
            Rectangle {
                Layout.preferredWidth: 40
                Layout.preferredHeight: 4
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 12
                radius: 2
                color: AmneziaStyle.color.mutedGray
            }
            
            // Selected Server Display
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 24
                Layout.rightMargin: 24
                Layout.bottomMargin: 12
                spacing: 16
                
                Text {
                    text: serversModel.get(root.selectedIndex).flag
                    font.pixelSize: 24
                }
                
                Column {
                    Layout.fillWidth: true
                    spacing: 2
                    
                    Text {
                        text: serversModel.get(root.selectedIndex).name
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        color: AmneziaStyle.color.paleGray
                    }
                    
                    Text {
                        text: serversModel.get(root.selectedIndex).location
                        font.pixelSize: 13
                        color: AmneziaStyle.color.mutedGray
                    }
                }
                
                // Signal Strength
                Row {
                    spacing: 2
                    Repeater {
                        model: 4
                        Rectangle {
                            width: 4
                            height: (index + 2) * 3
                            radius: 2
                            color: index < serversModel.get(root.selectedIndex).signal ? 
                                  AmneziaStyle.color.primaryBlue : 
                                  AmneziaStyle.color.slateGray
                            anchors.bottom: parent.bottom
                        }
                    }
                }
                
                // Chevron
                Text {
                    text: "▲"
                    color: AmneziaStyle.color.mutedGray
                    font.pixelSize: 12
                    rotation: root.isExpandedStateActive() ? 180 : 0
                    
                    Behavior on rotation {
                        NumberAnimation { duration: 200 }
                    }
                }
            }
        }
    }
    
    expandedStateContent: Item {
        height: root.expandedHeight
        
        ColumnLayout {
            anchors.fill: parent
            spacing: 0
            
            // Header
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Select Server")
                    font.pixelSize: 18
                    font.weight: Font.Bold
                    color: AmneziaStyle.color.paleGray
                }
                
                // Close button
                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 24
                    anchors.verticalCenter: parent.verticalCenter
                    text: "✕"
                    font.pixelSize: 18
                    color: AmneziaStyle.color.mutedGray
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.closeTriggered()
                    }
                }
            }
            
            // Server List
            ListView {
                id: listView
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                
                model: serversModel
                
                delegate: ServerListItem {
                    width: ListView.view.width
                    serverName: model.name
                    serverLocation: model.location
                    serverFlag: model.flag
                    serverSignal: model.signal
                    isSelected: index === root.selectedIndex
                    isPremium: model.isPremium
                    
                    onClicked: {
                        root.selectedIndex = index
                        root.closeTriggered()
                    }
                }
            }
        }
    }
}
