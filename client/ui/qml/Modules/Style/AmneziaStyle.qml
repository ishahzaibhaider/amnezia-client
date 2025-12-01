pragma Singleton

import QtQuick

QtObject {
    property QtObject color: QtObject {
        // Base colors
        readonly property color transparent: 'transparent'
        
        // Light Blue Theme - Primary Colors
        readonly property color primaryBlue: '#03A9F4'        // Light Blue 500
        readonly property color primaryDark: '#0288D1'        // Light Blue 700
        readonly property color primaryLight: '#4FC3F7'       // Light Blue 300
        readonly property color accentCyan: '#00BCD4'         // Cyan 500
        readonly property color accentLight: '#26C6DA'        // Cyan 400
        
        // Status Colors
        readonly property color successGreen: '#4CAF50'       // Green 500
        readonly property color warningOrange: '#FF9800'      // Orange 500
        readonly property color vibrantRed: '#EB5757'         // Red (kept from original)
        
        // Gray Scale (kept from original - works well with blue)
        readonly property color paleGray: '#D7D8DB'
        readonly property color lightGray: '#C1C2C5'
        readonly property color mutedGray: '#878B91'
        readonly property color charcoalGray: '#494B50'
        readonly property color slateGray: '#2C2D30'
        readonly property color onyxBlack: '#1C1D21'
        readonly property color midnightBlack: '#0E0E11'
        readonly property color darkCharcoal: '#261E1A'
        readonly property color pearlGray: '#EAEAEC'
        
        // Translucent Colors
        readonly property color sheerWhite: Qt.rgba(1, 1, 1, 0.12)
        readonly property color translucentWhite: Qt.rgba(1, 1, 1, 0.08)
        readonly property color barelyTranslucentWhite: Qt.rgba(1, 1, 1, 0.05)
        readonly property color translucentMidnightBlack: Qt.rgba(14/255, 14/255, 17/255, 0.8)
        readonly property color mistyGray: Qt.rgba(215/255, 216/255, 219/255, 0.8)
        readonly property color cloudyGray: Qt.rgba(215/255, 216/255, 219/255, 0.65)
        readonly property color translucentSlateGray: Qt.rgba(85/255, 86/255, 92/255, 0.13)
        readonly property color translucentOnyxBlack: Qt.rgba(28/255, 29/255, 33/255, 0.13)
        readonly property color translucentPrimaryBlue: Qt.rgba(3/255, 169/255, 244/255, 0.3)
        
        // Legacy color aliases (for backward compatibility during transition)
        readonly property color goldenApricot: primaryBlue    // Map old accent to new primary
        readonly property color burntOrange: primaryDark      // Map old dark accent to new dark
        readonly property color mutedBrown: accentCyan        // Map to cyan accent
        readonly property color richBrown: primaryDark        // Map to dark blue
        readonly property color deepBrown: midnightBlack      // Map to black
        readonly property color softGoldenApricot: translucentPrimaryBlue  // Map to translucent blue
        readonly property color translucentRichBrown: translucentPrimaryBlue
    }
}
