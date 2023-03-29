import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    id: button
    property string text: "Text"
    property alias buttonArea: buttonArea
    property int animationDuration: 200
    property string alignment: "center"
    width: buttonText.contentWidth * 1.5
    height: buttonText.contentHeight * 1.5
    Rectangle {
        id: buttonRect
        anchors.fill: parent
        color: "transparent"
        Text {
            id: buttonText
            text: parent.parent.text
            width: contentWidth
            height: main.windowHeight * 0.05
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: alignment === "center" ? parent.horizontalCenter : undefined
            anchors.left: alignment === "left" ? parent.left : undefined
            anchors.right: alignment === "right" ? parent.right : undefined
            horizontalAlignment: alignment
                                 === "center" ? Text.AlignHCenter : alignment
                                                === "left" ? Text.AlignLeft : Text.AlignRight
            verticalAlignment: alignment
                               === "center" ? Text.AlignVCenter : alignment
                                              === "left" ? Text.AlignLeft : Text.AlignRight
            font.pointSize: 72
            fontSizeMode: Text.VerticalFit
            font.family: "Comfortaa"
            font.bold: true
            color: button.enabled ? "#FFFFFF" : "#AAAAAA"
        }
        Glow {
            id: glow
            anchors.fill: buttonText
            radius: 10
            samples: 32
            color: "black"
            source: buttonText
            spread: 0.3
            SequentialAnimation {
                running: buttonArea.containsMouse
                PropertyAnimation {
                    target: glow
                    property: "radius"
                    duration: animationDuration
                    to: 20
                }
            }
            SequentialAnimation {
                running: !buttonArea.containsMouse
                PropertyAnimation {
                    target: glow
                    property: "radius"
                    duration: animationDuration
                    to: 10
                }
            }
        }
        MouseArea {
            id: buttonArea
            anchors.fill: parent
            enabled: button.enabled
            hoverEnabled: true
        }
    }
}
