import QtQuick 2.15
import QtGraphicalEffects 1.15
import QtQuick.Controls 2.12
import "Level1"
import "Local_save/"
import "Entity/MainHero"

Item {
    property alias loadingImage: loadingImage
    property alias source: pageLoader.source
    property alias pageLoader: pageLoader
    property alias saver: saver
    property alias progress: pageLoader.progress
    //    property alias _levelGen: _levelGen
    Saver {
        id: saver
    }
    Loader {
        id: pageLoader
        property string type
        anchors.fill: parent
        source: "Main_menu/MainMenu.qml"
        anchors.centerIn: parent
        onLoaded: {
            forceActiveFocus()
            loadingAnimation.running = true
        }
        asynchronous: true
        visible: status == Loader.Ready
        onStatusChanged: {
            if (pageLoader.status !== Loader.Ready) {
                loadingAnimation2.running = true
            }
        }
    }
    FastBlur {
        id: fastBlur
        opacity: pageLoader.type === "level" ? subMenu.item.opacity + inventory.item.opacity : 0
        source: pageLoader.type === "level" ? pageLoader : undefined
        anchors.fill: pageLoader.type === "level" ? pageLoader : undefined
        radius: pageLoader.type === "level" ? (inventory.item.opacity
                                               + subMenu.item.opacity) * 64 : 0
    }
    Component {
        id: _inventory
        Inventory {
            opacity: 0
            enabled: false
            Behavior on opacity {
                PropertyAnimation {
                    target: inventory.item
                    property: "opacity"
                    duration: 500
                    //easing.type: inventory.item.opacity === 1 ? "OutExpo" : "InExpo"
                }
            }
        }
    }
    Component {
        id: _subMenu
        SubMenu {
            opacity: 0
            enabled: false
            Behavior on opacity {
                PropertyAnimation {
                    target: subMenu.item
                    property: "opacity"
                    duration: 500
                    //easing.type: subMenu.item.opacity === 1 ? "OutExpo" : "InExpo"
                }
            }
        }
    }
    //    Component {
    //        id: _levelGen
    //        LevelGen {}
    //    }
    Loader {
        id: inventory
        height: windowHeight
        width: windowWidth
        asynchronous: false
        sourceComponent: pageLoader.type === "level" ? _inventory : undefined
    }
    Loader {
        id: subMenu
        height: windowHeight
        width: windowWidth
        asynchronous: false
        sourceComponent: pageLoader.type === "level" ? _subMenu : undefined
    }

    //    Loader {
    //        id: levelGen
    //        asynchronous: false
    //        sourceComponent: pageLoader.type === "level" ? _levelGen : undefined
    //    }
    Image {
        id: loadingImage
        source: "Loading/Gachi.png"
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
            value: pageLoader.progress
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        height: 0.02 * main.windowHeight
        anchors.left: parent.left
        anchors.right: parent.right
        color: "transparent"
        Text {
            text: "build: " + main.version
            color: "#88FFFFFF"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 0.15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 100
            minimumPointSize: 1
            fontSizeMode: Text.Fit
            style: Text.Outline
            styleColor: "#88000000"
        }
        Text {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            color: "gray"
            text: saver.localSave.seed
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5;height:720;width:1280}
}
##^##*/

