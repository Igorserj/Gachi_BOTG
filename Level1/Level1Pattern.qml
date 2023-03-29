import QtQuick 2.12
import QtGraphicalEffects 1.15
import "../Entity/Hotsile"
import "../Entity/MainHero"
import ".."
import "../Interact"
import "../Interface"
import "../Lighting"

Item {
    id: levelName
    state: "stopGame"
    property alias mainHero: mainHero
    property alias _hostile: _hostile
    property string name1: ""
    property string name2: ""
    property string type: "level"
    property string type2: "intro"
    property bool levelFinished: false // saver.localSave.level1Finished[saver.localSave.currentRoom]
    property real door_right_angle: 0
    property var levelText: ["", ""]
    property bool hosLoad: false
    onHosLoadChanged: {
        lvl1scriptLoader.sourceComponent = lvl1script
        gui.sourceComponent = _gui
        gui.active = true
        _dialogue.sourceComponent = dialogue
    }
    onLevelFinishedChanged: {
        saver.localSave.level1Finished[0] = levelFinished
        saver.localSaving()
    }
    Component.onCompleted: pageLoader.type = type

    Image {
        id: room
        source: "Room.png"
        smooth: false
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        z: 0

        Rectangle {
            id: way
            border.color: "black"
            border.width: saver.settingsSave.hitboxVisible === true ? 2 : 0
            color: "transparent"
            height: 0.25 * room.paintedHeight
            width: 0.7 * room.paintedWidth
            z: room.z + 1
            y: 0.74 * room.height
            anchors.horizontalCenter: parent.horizontalCenter

            //                Semen { id: semen }
            MainHero {
                id: mainHero
                //                    transformOrigin: Item.Center
                //                    type: semen
                state: ""
            }

            Van {
                id: van
            }
            Slave {
                id: slave
            }
            Repeater {
                model: 1
                id: _hostile
                delegate: Hostile {
                    type: van
                    masked: true
                    off: levelFinished
                }
                Component.onCompleted: {
                    hosLoad = true
                }
            }

            Interact {
                id: door_left
                //                    source: "../Level1/Objects/door_left.png"
                anchors.rightMargin: way.x / 1.5
                imageHeight: room.height * 0.59
                anchors.right: parent.left
                y: -way.y / 1.76
                finished: true
                type: "door left"
                opened: false
                roomChange: "prev"
                onDoor_angleChanged: pageLoader.source = "Street.qml"
                //                    message: "Двері зачинені"
            }

            Interact {
                id: door_right
                anchors.leftMargin: way.x / 6.8
                imageHeight: room.height * 0.59
                anchors.left: parent.right
                y: door_left.y
                finished: true
                type: "door right"
                roomChange: "next"
                opened: true
                //                    message: "Відчинено"
            }

            Interact {
                id: bench
                x: way.width * 0.2
                y: way.height * 0.1
                z: 1
                finished: true
                type: "bench"
                imageHeight: room.height / 15
                //                scaling: 1.1 * (main.windowWidth / 1280)
            }

            Image {
                id: shelf
                x: room.width * 0.02
                width: room.width / 16
                height: room.height / 2.8
                anchors.bottom: way.top
                source: "Objects/shelf.png"
                smooth: false
                fillMode: Image.PreserveAspectFit
                z: 0
            }

            Image {
                id: shelf2_opened
                anchors.left: shelf.right
                anchors.leftMargin: room.width * 0.01
                anchors.bottom: way.top
                source: "Objects/shelf2_opened.png"
                smooth: false
                width: room.width / 16
                height: room.height / 2.8
                fillMode: Image.PreserveAspectFit
                z: 0
            }

            Image {
                id: shelf_opened
                anchors.left: shelf2_opened.right
                anchors.leftMargin: room.width * 0.01
                anchors.bottom: way.top
                source: "Objects/shelf_opened.png"
                smooth: false
                mirror: true
                width: room.width / 16
                height: room.height / 2.8
                fillMode: Image.PreserveAspectFit
                z: 0
            }

            Image {
                id: shelf2
                anchors.left: shelf_opened.right
                anchors.leftMargin: room.width * 0.01
                anchors.bottom: way.top
                source: "Objects/shelf2.png"
                smooth: false
                width: room.width / 16
                height: room.height / 2.8
                fillMode: Image.PreserveAspectFit
                z: 0
            }

            Image {
                id: shelf21
                x: way.width - width - room.width * 0.02
                anchors.bottom: way.top
                source: "Objects/shelf2.png"
                smooth: false
                width: room.width / 16
                height: room.height / 2.8
                fillMode: Image.PreserveAspectFit
                z: 0
            }

            Image {
                id: shelf2_opened1
                anchors.right: shelf21.left
                anchors.rightMargin: room.width * 0.01
                anchors.bottom: way.top
                source: "Objects/shelf2_opened.png"
                smooth: false
                width: room.width / 16
                height: room.height / 2.8
                fillMode: Image.PreserveAspectFit
                z: 0
            }

            Image {
                id: shelf3
                anchors.right: shelf2_opened1.left
                anchors.rightMargin: room.width * 0.01
                anchors.bottom: way.top
                source: "Objects/shelf.png"
                smooth: false
                width: room.width / 16
                height: room.height / 2.8
                fillMode: Image.PreserveAspectFit
                z: 0
            }

            Image {
                id: shelf2_opened2
                anchors.right: shelf3.left
                anchors.rightMargin: room.width * 0.01
                anchors.bottom: way.top
                source: "Objects/shelf2_opened.png"
                smooth: false
                mirror: true
                width: room.width / 16
                height: room.height / 2.8
                fillMode: Image.PreserveAspectFit
                z: 0
            }
        }

        Spotlight {
            id: light
            width: room.width
            height: room.height
            lowerBound: 0.6
            upperBound: 1
            scale: 1.6
            //            anchors.verticalCenter: parent.verticalCenter
            //            lightRotation: -3
            //            anchors.horizontalCenter: parent.horizontalCenter
            z: 4
        }

        //        Light {
        //            id: light2
        //            width: room.width / 2
        //            height: room.height
        //            lowerBound: 0.2
        //            upperBound: 0.5
        //            y: light.width
        //            //            anchors.verticalCenter: parent.verticalCenter
        //            //            lightRotation: -3
        //            //            anchors.horizontalCenter: parent.horizontalCenter
        //            z: 4
        //        }
        Image {
            id: business_card
            source: "../Level1/Objects/Business_card.png"
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
            y: (parent.height * 0.7 - height) / 2
            width: 0.65 * parent.width
            fillMode: Image.PreserveAspectFit
            z: 4
        }
        DropShadow {
            anchors.fill: business_card
            horizontalOffset: 3
            verticalOffset: 3
            radius: 8.0
            color: "#80000000"
            source: business_card
            visible: business_card.visible
            z: business_card.z
        }
    }
    Rectangle {
        id: timeSkipRect
        property string text: qsTr("Пройшло декілька годин")
        anchors.fill: parent
        opacity: 0
        color: "black"
        z: 6
        Rectangle {
            height: 0.1 * parent.height
            width: 0.4 * parent.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            Text {
                text: timeSkipRect.text
                color: "white"
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Bold
                font.family: "Overpass"
                font.pointSize: 72
                fontSizeMode: Text.Fit
            }
        }
    }
    Component {
        id: lvl1script
        Level1Script {}
    }
    Component {
        id: _gui
        GUI {
            anchors.fill: parent
        }
    }
    Component {
        id: dialogue
        Dialogue {
            visible: false
            enabled: false
        }
    }
    Loader {
        id: lvl1scriptLoader
    }
    Loader {
        id: gui
        z: 5
        anchors.fill: parent
        visible: false
    }
    Loader {
        id: _dialogue
        z: 5
        anchors.fill: parent
    }
    ButtonIcon {
        id: buttonIcon
    }
    Loader {
        id: npc
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.66;height:720;width:1280}
}
##^##*/

