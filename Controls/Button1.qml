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
        color: button.enabled ? buttonArea.containsMouse ? "#99565656" : "#99787878" : "#99333333"
        radius: button.enabled ? buttonArea.containsMouse ? button.height / 2.5 : button.height
                                                            / 5 : button.height / 5
        anchors.fill: parent
        Behavior on color {
            PropertyAnimation {
                target: buttonRect
                property: "color"
                duration: animationDuration
            }
        }
        Behavior on radius {
            PropertyAnimation {
                target: buttonRect
                property: "radius"
                duration: animationDuration
            }
        }
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
            color: "white"
        }
        MouseArea {
            id: buttonArea
            anchors.fill: parent
            enabled: button.enabled
            hoverEnabled: true
        }
    }
    DropShadow {
        anchors.fill: buttonRect
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: buttonRect
    }
}
