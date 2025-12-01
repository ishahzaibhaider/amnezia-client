import QtQuick
import QtQuick.Layouts
import Style 1.0
import ConnectionState 1.0

Item {
    id: root
    
    implicitWidth: 300
    implicitHeight: 80
    
    visible: ConnectionController.isConnected
    opacity: visible ? 1.0 : 0.0
    
    Behavior on opacity {
        NumberAnimation { duration: 300 }
    }
    
    RowLayout {
        anchors.fill: parent
        spacing: 24
        
        // Download Speed
        Column {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: 80
            spacing: 4
            
            Text {
                text: "⬇"
                color: AmneziaStyle.color.primaryBlue
                font.pixelSize: 18
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Text {
                // Mock data for now, replace with ConnectionController.downloadSpeed later
                text: "12.5 MB/s" 
                color: AmneziaStyle.color.paleGray
                font.pixelSize: 14
                font.weight: Font.Medium
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Text {
                text: qsTr("DOWNLOAD")
                color: AmneziaStyle.color.mutedGray
                font.pixelSize: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        
        // Duration Timer
        Column {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: 4
            
            Text {
                id: timerText
                text: "00:00:00"
                color: AmneziaStyle.color.paleGray
                font.pixelSize: 24
                font.weight: Font.Bold
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "PT Root UI VF"
            }
            
            Text {
                text: qsTr("DURATION")
                color: AmneziaStyle.color.mutedGray
                font.pixelSize: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            // Timer Logic
            Timer {
                interval: 1000
                running: ConnectionController.isConnected
                repeat: true
                property int seconds: 0
                
                onTriggered: {
                    seconds++
                    var h = Math.floor(seconds / 3600)
                    var m = Math.floor((seconds % 3600) / 60)
                    var s = seconds % 60
                    
                    timerText.text = (h > 0 ? (h < 10 ? "0" + h : h) + ":" : "") +
                                     (m < 10 ? "0" + m : m) + ":" +
                                     (s < 10 ? "0" + s : s)
                }
                
                onRunningChanged: {
                    if (!running) seconds = 0
                }
            }
        }
        
        // Upload Speed
        Column {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: 80
            spacing: 4
            
            Text {
                text: "⬆"
                color: AmneziaStyle.color.successGreen // Or primaryBlue
                font.pixelSize: 18
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Text {
                // Mock data for now
                text: "4.2 MB/s"
                color: AmneziaStyle.color.paleGray
                font.pixelSize: 14
                font.weight: Font.Medium
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Text {
                text: qsTr("UPLOAD")
                color: AmneziaStyle.color.mutedGray
                font.pixelSize: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
