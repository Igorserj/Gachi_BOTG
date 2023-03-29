import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    anchors.fill: parent
    property alias loadingAnimation: loadingAnimation
    property alias loadingAnimation2: loadingAnimation2
    Image {
        id: loadingImage
        source: "../Loading/Gachi.png"
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
        OpacityAnimator {
            id: loadingAnimation
            target: loadingImage
            alwaysRunToEnd: true
            from: 1
            to: 0
            duration: 500
        }
        OpacityAnimator {
            id: loadingAnimation2
            target: loadingImage
            alwaysRunToEnd: true
            from: 0
            to: 1
            duration: 500
        }
        ProgressBar {
            id: progressBar
            width: 0.5 * windowWidth
            height: 0.05 * windowHeight
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 0.1 * windowHeight
            value: levelGenLoader.progress
        }
    }
}
