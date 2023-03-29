import QtQuick 2.15
import QtGraphicalEffects 1.15
import ".."
import "../Controls"

Item {
    id: mainMenu
    //    property alias mainMenu: mainMenu
    property var menuButtonScript
    property var buttonText: ["Почати гру", "Налаштування", "Вихід"]
    property alias container: container
    property string type: 'menu'
    Component.onCompleted: pageLoader.type = type
    /*: [,cont(),,exit()]*/ /*mainMenu.z =-1; level1.z=0; mainMenu.enabled=false*/
    function play() {
        //        mainMenu2.visible = true
        mainMenu2.opacity = 1
        mainMenu2.enabled = true
        //        container.visible = false
        container.opacity = 0
        container.enabled = false
        //        pageLoader.loadingImage.source="Loading/Gachi.png"; pageLoader.progressBar.visible=true
    }
    function setting() {
        //        settings.visible = true
        settings.opacity = 1
        settings.enabled = true
        //        container.visible = false
        container.opacity = 0
        container.enabled = false
        bg.bgFace.visible = false
        bg.bgFace.enabled = false
        logo.opacity = 0
        logo.enabled = false
    }
    function exit() {
        Qt.callLater(Qt.quit)
    }

    Bg {
        anchors.fill: parent
        id: bg
    }

    Settings {
        id: settings
        anchors.fill: parent
        //        visible: false
        opacity: 0
        enabled: false
        Behavior on opacity {
            PropertyAnimation {
                target: settings
                property: "opacity"
                duration: 500
                easing.type: settings.opacity === 1 ? "OutExpo" : "InExpo"
            }
        }
    }
    Image {
        id: logo
        source: "logo.png"
        width: 0.45 * parent.width
        height: 0.2 * parent.height
        fillMode: Image.PreserveAspectCrop
        anchors.right: bg.right
        anchors.top: bg.top
        anchors.margins: 50
        Behavior on opacity {
            PropertyAnimation {
                target: logo
                property: "opacity"
                duration: 500
                easing.type: logo.opacity === 1 ? "OutExpo" : "InExpo"
            }
        }
    }
    MainMenu2 {
        id: mainMenu2
        anchors.fill: parent
        opacity: 0
        enabled: false
        Behavior on opacity {
            PropertyAnimation {
                target: mainMenu2
                property: "opacity"
                duration: 500
                easing.type: mainMenu2.opacity === 1 ? "OutExpo" : "InExpo"
            }
        }
    }

    Rectangle {
        id: container
        width: bg.width / 4
        anchors.right: logo.right
        color: "transparent"
        height: (bg.height - logo.height) / 8 * 3
        y: (bg.height - container.height) / 2

        Behavior on opacity {
            PropertyAnimation {
                target: container
                property: "opacity"
                duration: 1000
                easing.type: container.opacity === 1 ? "OutExpo" : "InExpo"
            }
        }

        Column {
            anchors.fill: parent
            z: 2
            Repeater {
                id: button
                model: buttonText
                Button3 {
                    text: modelData
                    alignment: "right"
                    visible: index !== 1
                    anchors.right: parent.right
                    buttonArea.onClicked: index === 0 ? play() : index === 1 ? setting() : exit()
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}
}
##^##*/

