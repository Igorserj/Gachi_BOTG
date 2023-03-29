import QtQuick 2.12
import QtGraphicalEffects 1.15

Item {
    property string text: "Слава Україні!"
    property int timer: 500
    opacity: 0
    id: item1
    onOpacityChanged: fading.running = true
    enabled: false
    Rectangle {
        id: rectangle
        color: "#55000000"
        width: text.contentWidth
        height: pageLoader.height * 0.08
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: pageLoader.height * 0.11
        Text {
            id: text
            text: item1.text
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 100
            fontSizeMode: Text.VerticalFit
            font.family: "Overpass"
            color: "white"
            font.weight: Font.DemiBold
            padding: parent.height * 0.1
        }
    }

    SequentialAnimation {
        id: fading
        //        alwaysRunToEnd: true
        OpacityAnimator {
            target: item1
            from: 0
            to: 1
            duration: 250
        }

        PauseAnimation {
            duration: timer
        }
        OpacityAnimator {
            target: item1
            from: 1
            to: 0
            duration: 250
        }
        ScriptAction {
            script: timer = 500
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

