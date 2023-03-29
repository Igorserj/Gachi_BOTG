import QtQuick 2.12
import "../Entity/MainHero"
import "../Entity/Hotsile"
import "../Interact"
import "../Interface"
import ".."
import "../Lighting"

Item {
    id: levelName
    property alias mainHero: mainHero
    property bool levelFinished: true
    property real door_right_angle: 0
    property string type: "level"
    property var levelText: ["", ""]
    property var doorArray: [leftUp_door, rightUp_door, leftCenter_door, rightCenter_door, leftDown_door, rightDown_door]
    state: subMenu.item.opacity === 1 ? "stopGame" : _dialogue.item.visible
                                        === true ? "dialogue" : ""
    width: pageLoader.width
    height: image_back.sourceSize.height * (width / image_back.sourceSize.width)
    y: -(3 - saver.localSave.floor) * (levelName.height / 1.64)
    Component.onCompleted: {
        pageLoader.type = type
        var doorQunatity = 0
        for (var i = 0; i < levelGen.q; i++) {
            doorQunatity += levelGen.roomQ[i]
            var door = doorArray[levelGen.doorQ[i]]
            door.opened = true
            door.roomChange = levelGen.doorQ[i]
                    === 4 ? (doorQunatity - 1).toString(
                                ) : (doorQunatity - levelGen.roomQ[i] + 1).toString()
            //            console.log("opened")
        }
    }

    Behavior on x {
        ParallelAnimation {
            PropertyAnimation {
                properties: "x"
                target: levelName
                duration: 320
            }
        }
    }
    Behavior on y {
        ParallelAnimation {
            NumberAnimation {
                property: "y"
                target: levelName
                duration: 320
            }
        }
    }

    Rectangle {
        id: room
        anchors.fill: parent
        Image {
            id: image_back
            source: "Bridge_room_back.png"
            width: pageLoader.width
            height: image_back.sourceSize.height * (width / image_back.sourceSize.width)
        }
        Interact {
            type: "stairs left"
            x: 0.075 * pageLoader.width
            y: 0.66 * pageLoader.height
            z: image_back.z
            imageHeight: image_back.height / 2.95
            finished: true
        }
        Interact {
            type: "stairs right"
            x: 0.1 * pageLoader.width
            y: image_back.height / 2.95 + 0.66 * pageLoader.height
            z: image_back.z
            imageHeight: image_back.height / 2.95
            finished: true
        }

        Interact {
            id: leftUp_door
            anchors.leftMargin: 0.011 * pageLoader.width
            imageHeight: room.height * 0.5
            anchors.left: parent.left
            y: 0.872 * pageLoader.height - way.height - imageHeight
            finished: saver.localSave.floor === 3
            type: levelGen.doorSides[0]
        }

        Interact {
            id: rightUp_door
            x: 0.92 * pageLoader.width
            imageHeight: leftUp_door.imageHeight
            y: leftUp_door.y
            finished: leftUp_door.finished
            type: levelGen.doorSides[1]
        }

        Interact {
            id: leftCenter_door
            anchors.leftMargin: leftUp_door.anchors.leftMargin
            imageHeight: leftUp_door.imageHeight
            anchors.left: leftUp_door.anchors.left
            y: leftUp_door.y + 9.3 * mainHero.moveV * 1.5
            finished: saver.localSave.floor === 2
            type: levelGen.doorSides[2]
        }

        Interact {
            id: rightCenter_door
            x: rightUp_door.x
            imageHeight: leftUp_door.imageHeight
            y: leftCenter_door.y
            finished: leftCenter_door.finished
            type: levelGen.doorSides[3]
        }

        Interact {
            id: leftDown_door
            anchors.leftMargin: 0.028 * pageLoader.width
            imageHeight: leftUp_door.imageHeight * 1.02
            anchors.left: leftUp_door.anchors.left
            y: leftCenter_door.y + 9.3 * mainHero.moveV * 1.5
            finished: saver.localSave.floor === 1
            type: levelGen.doorSides[4]
        }

        Interact {
            id: rightDown_door
            x: 0.905 * pageLoader.width
            imageHeight: leftDown_door.imageHeight
            y: leftDown_door.y * 1.01
            finished: leftDown_door.finished
            type: levelGen.doorSides[5]
            z: 0
        }

        Image {
            id: image_front
            source: "Bridge_room_front.png"
            z: image_back.z + 1
            width: pageLoader.width
            height: image_back.height
        }

        Rectangle {
            id: way
            visible: true
            border.color: "black"
            border.width: saver.settingsSave.hitboxVisible === true ? 2 : 0
            color: "transparent"
            width: parent.width * 0.852
            height: 0.1 * parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            x: 0
            y: 0.78 * pageLoader.height - way.height
               + (3 - saver.localSave.floor) * (levelName.height / 1.44)
            z: image_front.z
            //            Semen {id: semen}
            MainHero {
                id: mainHero
                transformOrigin: Item.Center
                x: saver.localSave.side === "left" ? 0 : way.width - mainHero.hitbox.width
                y: -mainHero.hitbox.height + way.height / 2
            }
            Behavior on y {
                NumberAnimation {
                    property: "y"
                    target: way
                    duration: 320
                }
            }

            Repeater {
                model: 1
                id: _hostile
                delegate: Hostile {}
            }
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
                monologue: true
                visible: false
                enabled: false
            }
        }
        Loader {
            id: gui
            z: 5
            anchors.fill: parent
            sourceComponent: _gui
        }
        Loader {
            id: _dialogue
            z: 5
            anchors.fill: parent
            sourceComponent: dialogue
        }
        ButtonIcon {
            id: buttonIcon
        }
        Arealight {
            id: light
            width: room.width
            height: image_back.height / 3
            anchors.top: image_back.top
            lowerBound: 0.3
            upperBound: 0.7
            z: image_front.z + 1
            //            layer.enabled: true
        }
        Arealight {
            id: light2
            width: room.width
            height: image_back.height / 3 + 1
            //            anchors.verticalCenter: image_back.verticalCenter
            anchors.top: light.bottom
            lowerBound: light.lowerBound
            upperBound: light.upperBound
            z: light.z
            //            layer.enabled: true
        }
        Arealight {
            id: light3
            width: room.width
            height: image_back.height / 3
            anchors.top: light2.bottom
            lowerBound: light.lowerBound
            upperBound: light.upperBound
            z: light.z
            //            layer.enabled: true
        }
    }
    Loader {
        id: npc
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75;height:720;width:1280}
}
##^##*/

