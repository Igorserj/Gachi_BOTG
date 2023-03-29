import QtQuick 2.12
import "../Entity/MainHero"
import "../Interact"
import "../Interface"
import ".."

Item {
    id: levelName
    property alias mainHero: mainHero
    property bool levelFinished: true
    property real door_right_angle: 0
    property string type: "level"
    property var levelText: ["", ""]
    //    property var doorArray: [leftUp_door, rightUp_door, leftCenter_door, rightCenter_door, leftDown_door, rightDown_door]
    state: subMenu.item.opacity === 1 ? "stopGame" : _dialogue.item.visible
                                        === true ? "dialogue" : ""
    width: pageLoader.width
    height: image_back.sourceSize.height * (width / image_back.sourceSize.width)
    y: -(3 - saver.localSave.floor) * (room.height / 1.64)
    Component.onCompleted: {
        pageLoader.type = type
        //        var doorQunatity = 0
        //        for (var i = 0; i < levelGen.q; i++) {
        //            doorQunatity += levelGen.roomQ[i]
        //            var door = doorArray[levelGen.doorQ[i]]
        //            door.opened = true
        //            door.roomChange = levelGen.doorQ[i]
        //                    === 4 ? (doorQunatity - 1).toString(
        //                                ) : (doorQunatity - levelGen.roomQ[i] + 1).toString()
        //        }
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
            //            visible: saver.localSave.floor === 1 || saver.localSave.floor === 2
            imageHeight: image_back.height / 2.95
            finished: true
        }
        Interact {
            type: "stairs right"
            x: 0.1 * pageLoader.width
            y: image_back.height / 2.95 + 0.66 * pageLoader.height
            z: image_back.z
            //            visible: saver.localSave.floor === 3 || saver.localSave.floor === 2
            imageHeight: image_back.height / 2.95
            finished: true
        }

        Image {
            id: image_front
            source: "Bridge_room_front.png"
            width: pageLoader.width
            height: image_back.height
        }

        Rectangle {
            id: way
            visible: true
            border.color: "black"
            border.width: saver.settingsSave.hitboxVisible === true ? 2 : 0
            color: "transparent" /*"#77000000"*/
            width: parent.width * 0.9
            height: 0.1 * parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            y: 0.78 * pageLoader.height - way.height
               + (3 - saver.localSave.floor) * (levelName.height / 1.44)
            z: image_front.z
            //            Semen {id: semen}
            MainHero {
                id: mainHero
                transformOrigin: Item.Center
                //                type: semen
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
            Interact {
                id: left_door
                anchors.leftMargin: 0.011 * pageLoader.width
                imageHeight: room.height * 0.5
                anchors.left: parent.left
                y: -imageHeight + way.height / 2
                //            y: 0.872 * pageLoader.height - way.height - imageHeight
                //                z: 0
                finished: true
                type: levelGen.doorSides[(3 - saver.localSave.floor) * 2]
                roomChange: ""
            }

            Interact {
                id: right_door
                imageHeight: left_door.imageHeight
                x: 0.92 * pageLoader.width - way.x
                y: -imageHeight + way.height / 2
                //                z: left_door.z
                finished: true
                type: levelGen.doorSides[(3 - saver.localSave.floor) * 2 + 1]
                roomChange: levelGen.doorQ[(3 - saver.localSave.floor) * 2 + 1]
                            === 4 ? (doorQunatity - 1).toString(
                                        ) : (doorQunatity - levelGen.roomQ[(3 - saver.localSave.floor) * 2 + 1] + 1).toString()
            }
        }
        Light {
            id: light
            width: room.width
            height: image_back.height
            lowerBound: 0.2
            upperBound: 0.6
            verticalRadius: height / 3 * 2
            verticalOffest: (3 - saver.localSave.floor - 1) * (room.height / 1.64)
            horizontalOffest: 0
            lowerFiller: height * ((saver.localSave.floor - 1) / 3.2)
            upperFiller: height * ((3 - saver.localSave.floor) / 3)
            //        anchors.verticalCenter: room.verticalCenter
            anchors.horizontalCenter: room.horizontalCenter
            //            z: room.z + 1
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

