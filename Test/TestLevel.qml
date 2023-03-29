import QtQuick 2.0
import "../Entity/Hotsile"
import "../Entity/MainHero"
import "../Interface"
import "../Interact"
import ".."

Item {
    id: levelName
    //    property alias levelName: testLevel
    state: subMenu.item.opacity === 1 ? "stopGame" : _dialogue.item.visible
                                        === true ? "dialogue" : ""
    onStateChanged: console.log(state)
    property alias mainHero: mainHero
    property alias _hostile: _hostile
    //    property var trainerPic: ["Objects/Trainer1","Objects/Trainer2","Objects/Trainer3","Objects/Trainer4"]
    property string name1: ""
    property string name2: ""
    property string type: "level"
    property var levelText: [name2, "You're a fucking slave", name1, "Go fuck yourself"]
    //    property double containerWidth2: 100
    property bool levelFinished: false
    property bool hosLoad: false
    onHosLoadChanged: {
        gui.sourceComponent = _gui
        _dialogue.sourceComponent = dialogue
    }
    Component.onCompleted: pageLoader.type = type

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

    State {
        name: "stopGame"
    }

    //        Component{
    //            id: _subMenu
    //            SubMenu {
    //                anchors.fill: parent
    //                visible: false
    //                enabled: false
    //            }}
    //        Loader {
    //            id: subMenu
    //            width: levelName.width
    //            height: levelName.height
    //            asynchronous: false
    //            sourceComponent: _subMenu
    //            x: -parent.x
    //            y: -parent.y
    //            z: 10
    //          }
    Rectangle {
        id: room
        //            source: "levelName/Room.png"
        color: "black"
        height: pageLoader.height
        width: height / 1080 * 3840
        //            color: "white"
        z: 0

        Rectangle {
            id: way
            border.color: "black"
            //                border.color: "transparent"
            border.width: saver.settingsSave.hitboxVisible === true ? 2 : 0
            color: "transparent"
            height: 0.25 * room.height
            width: 0.75 * room.width
            //                anchors.fill: parent
            //                anchors.left: parent.left
            anchors.bottom: parent.bottom
            z: room.z + 1
            //                y: 0.74*room.height
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
                source: "../Level1/Objects/Floor_locker_edited.png"
                fillMode: Image.Tile
                anchors.fill: parent
            }

            Interact {
                id: bench
                x: way.width * 0.2
                y: -way.height * 0.3
                z: 1
                //                    source: "../Level1/Objects/bench.png"
                finished: true
                type: "bench"
                //                    message: qsTr(mainHero.name + " сів")
                imageHeight: 40
                scaling: 2.5 * (pageLoader.width / 1280)
            }

            //                Semen { id: semen }
            MainHero {
                id: mainHero
                transformOrigin: Item.Center
                y: -mainHero.picture.paintedHeight + way.height
                //                    maxHealth: semen.maxHealth
                //                    health: semen.health
                //                    strength: semen.strength
                //                    name: semen.name
                //                    move1: semen.move1
                //                    attack1: semen.attack1
                //                    attack2: semen.attack2
                //                    died: semen.died
                //                    idle: semen.idle
                //                    imageSource: semen.imageSource
                //                    sitting: semen.sitting
                //                    block: semen.block
                //                    speed: semen.speed
            }

            Van {
                id: van
            }
            Slave {
                id: slave
            }
            Repeater {
                model: 2
                id: _hostile
                delegate: Hostile {
                    id: hostile
                    x: (way.width - hitbox.width) / 2 + index * hitbox.width
                    y: way.height / 2 - hitbox.height
                    type: index === 1 ? van : slave
                }
                Component.onCompleted: {
                    hosLoad = true
                }
            }
        }
    }
    Component {
        id: dialogue
        Dialogue {
            visible: false
            enabled: false
            anchors.fill: parent
            z: 4
        }
    }

    Component {
        id: _gui
        GUI {}
    }

    Light {
        id: light
        lowerBound: 0.35
        upperBound: 0.75
        //            x: way.x
        lightRotation: 60
        height: room.height * 2
        anchors.verticalCenter: room.verticalCenter
        anchors.horizontalCenter: room.horizontalCenter
        width: room.width * 2
        z: gui.z - 1
    }
    Loader {
        id: gui
        z: 5
        anchors.fill: parent
    }
    Loader {
        id: _dialogue
        z: 5
        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.125;height:720;width:1280}
}
##^##*/

