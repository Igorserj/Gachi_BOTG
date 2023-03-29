import QtQuick 2.12
//import QtGraphicalEffects 1.15
import "../Entity/Hotsile"
import "../Entity/MainHero"
import "../Entity/NPC"
import ".."
import "../Interface"
import "../Interact"
import "../Lighting"

Item {
    id: levelName
    state: subMenu.item.opacity === 1 ? "stopGame" : _dialogue.item.visible
                                        === true ? "dialogue" : ""
    property alias mainHero: mainHero
    property alias _hostile: _hostile
    property var trainerPic: ["Objects/Trainer1", "Objects/Trainer2", "Objects/Trainer3", "Objects/Trainer4"]
    property string name1: mainHero.name
    property string name2: !!npc.item ? npc.item.name : ""
    property string type: "level"
    property var levelText: [name1, "Агов! Ви не бачили тут чоловіка в масці?", name2, "Перепрошую, що?", name1, "Чоловіка в масці не бачили?", name2, "Ех-ех. Ти тут перший раз?", name1, "Так, а що?", name2, "Справа в тому, що тут всі в масках", name1, "Дійсно, я ж з ними бився", name1, "О, згадав, можливо ця візитівка щось підкаже", name2, "*волає від сміху*", name2, "Чуваче, тобі не повезло, ти зустрвся з Босом Качалки", name2, "Отже, відправляйся за цією адресою. Але я не впевнений, що ти дійдеш до нього", "", ""]
    //    property bool levelFinished: false
    property real door_right_angle: 0
    property var _dialogue
    property var gui
    property bool hosLoad: false
    property string bridgeDoor: "left"
    property int bridgeDoorId: 4
    property bool levelFinished: saver.localSave.level1Finished[saver.localSave.currentRoom]
    x: saver.localSave.side === "left" ? 0 : -room.width + pageLoader.width

    onLevelFinishedChanged: {
        saver.localSave.level1Finished[saver.localSave.currentRoom] = levelFinished
        saver.localSaving()
    }
    onHosLoadChanged: {
        gui.sourceComponent = _gui
        gui.active = true
        _dialogue.sourceComponent = dialogue
    }
    Component.onCompleted: {
        pageLoader.type = type
        var roomsQuantity = 0
        var isCloseRoom = false
        var isFarRoom = false
        for (var i = 0; i < doorQ.length; i++) {
            roomsQuantity += roomQ[i]

            if (saver.localSave.currentRoom <= roomsQuantity) {
                bridgeDoorId = doorQ[i]
                bridgeDoor = doorSides[bridgeDoorId]
                if (bridgeDoorId === 4) {
                    isFarRoom = false
                    roomsQuantity--
                    isCloseRoom = saver.localSave.currentRoom === roomsQuantity
                } else {
                    isFarRoom = saver.localSave.currentRoom === roomsQuantity
                    roomsQuantity -= (roomQ[i] - 1)
                    isCloseRoom = saver.localSave.currentRoom === roomsQuantity
                }
                i = doorQ.length - 1
            }
        }
        if (bridgeDoorId === 4) {
            if (isCloseRoom) {
                door_right.roomChange = roomQ[0].toString()
                door_left.roomChange = "prev"
                door_right.opened = true
                door_left.opened = true
            } else {
                door_right.roomChange = "next"
                door_left.roomChange = "prev"
                door_right.opened = true
                door_left.opened = true
            }
        } else if (bridgeDoor == "door left") {
            if (isCloseRoom && !isFarRoom) {
                door_right.roomChange = roomQ[0].toString()
                door_left.roomChange = "next"
                door_right.opened = true
                door_left.opened = true
            } else if (!isCloseRoom && isFarRoom) {
                door_right.roomChange = "prev"
                door_right.opened = true
            } else if (isCloseRoom && isFarRoom) {
                door_right.roomChange = roomQ[0].toString()
                door_right.opened = true
            } else {
                door_right.roomChange = "prev"
                door_left.roomChange = "next"
                door_right.opened = true
                door_left.opened = true
            }
        } else if (bridgeDoor == "door right") {
            if (isCloseRoom && !isFarRoom) {
                door_left.roomChange = roomQ[0].toString()
                door_right.roomChange = "next"
                door_left.opened = true
                door_right.opened = true
            } else if (!isCloseRoom && isFarRoom) {
                door_left.roomChange = "prev"
                door_left.opened = true
            } else if (isCloseRoom && isFarRoom) {
                door_left.roomChange = roomQ[0].toString()
                door_left.opened = true
            } else {
                door_right.roomChange = "next"
                door_left.roomChange = "prev"
                door_right.opened = true
                door_left.opened = true
            }
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
                duration: 200
            }
        }
    }

    //    Component{
    //        id: _subMenu
    //        SubMenu {
    //            anchors.fill: parent
    //            visible: false
    //        }}
    //    Loader {
    //        id: subMenu
    //        anchors.fill: parent
    //        asynchronous: false
    //        sourceComponent: _subMenu
    //        z: 10
    //    }
    //                Image {
    //                    id: trainer
    //                    source: trainerPic[Math.floor(Math.random() * 4)]
    //                    anchors.horizontalCenter: parent.horizontalCenter
    //                    width: 0.24*room.width
    //                    height: 0.4*room.height
    //                    fillMode: Image.PreserveAspectFit
    //                    anchors.bottom: way.top
    //                }
    Image {
        id: room
        source: (parseInt(saver.localSave.seed.charAt(3)) / 3)
                <= 1 ? "Room1.png" : (parseInt(
                                          saver.localSave.seed.charAt(
                                              3)) / 3) <= 2 ? "Room2.png" : "Room3.png"
        smooth: false
        fillMode: Image.PreserveAspectFit
        height: pageLoader.height
        width: height / 1080 * 3840
        z: 0
        Component.onCompleted: console.log(
                                   parseInt(saver.localSave.seed.charAt(3)) / 3)

        Rectangle {
            id: way
            border.color: "black"
            border.width: saver.settingsSave.hitboxVisible === true ? 2 : 0
            color: "transparent"
            height: 0.16 * room.height
            width: 0.86 * room.width
            z: room.z + 1
            y: room.height - height
            anchors.horizontalCenter: parent.horizontalCenter

            Interact {
                id: door_left
                anchors.rightMargin: width + 0.035 * room.width
                imageHeight: room.height * 0.5
                anchors.right: parent.left
                y: -way.y / 1.76 + way.height / 2
                finished: true
                type: "door left"
            }

            Interact {
                id: door_right
                //            source: door_left1.source
                //                x: 0.85*room.width
                anchors.left: parent.right
                anchors.leftMargin: 0.004 * room.width
                imageHeight: door_left.imageHeight
                y: door_left.y
                finished: true
                type: "door right"
            }

            //            Semen { id: semen }
            MainHero {
                id: mainHero
                transformOrigin: Item.Center
                x: saver.localSave.side === "left" ? 0 : way.width - mainHero.hitbox.width
                y: -mainHero.hitbox.height + way.height / 2
            }
            Van {
                id: van
            }
            Slave {
                id: slave
            }
            Repeater {
                model: saver.localSave.currentRoom
                       === 10 ? 0 : saver.localSave.currentRoom
                                % 3 ? 3 : saver.localSave.currentRoom % 2 ? 2 : 1
                id: _hostile
                property var isDead: []
                Hostile {
                    x: (way.width - (hitbox.width) * index) / 2
                    y: -hitbox.height + way.height
                    type: slave
                    health: type.health
                    onStateChanged: state === "die" ? [_hostile.isDead[index] = "dead", checkIfDead(
                                                           )] : {}

                    Component.onCompleted: {
                        !levelFinished ? _hostile.isDead[index]
                                         = "alive" : [_hostile.isDead[index]
                                                      = "dead", health = 0, visible = false]
                    }
                    function checkIfDead() {
                        for (var i = 0; i < _hostile.isDead.length; i++) {
                            if (_hostile.isDead[i] === "alive") {
                                //                                levelFinished = false
                                i = _hostile.isDead.length - 1
                            } else if (_hostile.isDead[i] === "dead"
                                       && i == _hostile.isDead.length - 1) {
                                levelFinished = true
                            }
                        }
                    }
                }
                Component.onCompleted: {
                    hosLoad = true
                }
            }
            Loader {
                id: npc
                sourceComponent: saver.localSave.currentRoom === 10 ? _npc : undefined
            }
        }
        Image {
            source: "Objects/sign.png"
            fillMode: Image.PreserveAspectFit
            visible: saver.localSave.currentRoom === 10
            height: room.height / 8
            x: room.width / 5.7
            y: room.height / 2.7
        }
    }

    Component {
        id: dialogue
        Dialogue {
            visible: false // mainHero.state==="die"?true:false
            enabled: false
            anchors.fill: parent
            z: 4
            indexId: 0
            SequentialAnimation {
                running: _dialogue.item.indexId === 11
                ScriptAction {
                    script: {
                        _dialogue.item.visible = false
                        _dialogue.item.enabled = false
                        levelFinished = true
                    }
                }
            }
        }
    }
    Component {
        id: _npc
        Harley {
            x: room.width / 5.7
            y: -hitbox.height
            Component.onCompleted: keyC()
        }
    }
    Arealight {
        id: light
        width: room.width
        height: room.height
        lowerBound: 0.3
        upperBound: 0.7
        verticalOffest: height / 4
        lightColor: "555599"
        //        scale: 1.6
        z: room.z + 1
    }

    Component {
        id: _gui
        GUI {}
    }
    Loader {
        id: gui
        z: 5
        anchors.fill: parent
    }
    Loader {
        id: _dialogue
        z: 5
        x: -levelName.x
        height: levelName.height
        width: levelName.width
        onLoaded: status === Loader.Ready ? (saver.localSave.currentRoom === 10
                                             && !saver.localSave.level1Finished[saver.localSave.currentRoom]) ? [_dialogue.item.visible = Qt.binding(function () {
                                                 return npc.item.inRange
                                             }), _dialogue.item.enabled = Qt.binding(function () {
                                                 return npc.item.inRange
                                             })] : {} : {}
}
ButtonIcon {
    id: buttonIcon
}
}
