import QtQuick
import QtQuick.Layouts
import Style 1.0

Rectangle {
    id: root
    
    height: 72
    color: mouseArea.pressed ? AmneziaStyle.color.slateGray :
           mouseArea.containsMouse ? AmneziaStyle.color.onyxBlack :
           "transparent"
    
    property string serverName: ""
    property string serverLocation: ""
    property string serverFlag: ""
    property int serverSignal: 3
    property bool isSelected: false
    property bool isPremium: false
    
    signal clicked()
    
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 24
        anchors.rightMargin: 24
        spacing: 16
        
        // Flag (using emoji for now, can replace with images later)
        Text {
            text: root.serverFlag
            font.pixelSize: 32
            Layout.alignment: Qt.AlignVCenter
        }
        
        // Server Info
        Column {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: 4
            
            Text {
                text: root.serverName
                font.pixelSize: 16
                font.weight: Font.Medium
                color: AmneziaStyle.color.paleGray
            }
            
            Text {
                text: root.serverLocation
                font.pixelSize: 13
                color: AmneziaStyle.color.mutedGray
            }
        }
        
        // Premium Badge
        Text {
            visible: root.isPremium
            text: "👑"
            font.pixelSize: 20
            Layout.alignment: Qt.AlignVCenter
        }
        
        // Signal Strength
        Row {
            spacing: 2
            Layout.alignment: Qt.AlignVCenter
            
            Repeater {
                model: 4
                Rectangle {
                    width: 4
                    height: (index + 2) * 3
                    radius: 2
                    color: index < root.serverSignal ? 
                          AmneziaStyle.color.primaryBlue : 
                          AmneziaStyle.color.slateGray
                    anchors.bottom: parent.bottom
                }
            }
        }
        
        // Selection Radio Button
        Rectangle {
            width: 20
            height: 20
            radius: 10
            border.width: 2
            border.color: root.isSelected ? 
                         AmneziaStyle.color.primaryBlue : 
                         AmneziaStyle.color.mutedGray
            color: "transparent"
            Layout.alignment: Qt.AlignVCenter
            
            Rectangle {
                anchors.centerIn: parent
                width: 10
                height: 10
                radius: 5
                color: AmneziaStyle.color.primaryBlue
                visible: root.isSelected
            }
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
