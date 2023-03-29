import QtQuick 2.15
import "../../"

//import "../MainHero"
Item {
    id: hostile
    property var type
    property alias hitbox: hitbox
    property alias picture: picture
    property alias mask: mask
    property string imageSource: typeof (type) !== 'undefined' ? type.imageSource : ""
    property string name: typeof (type) !== 'undefined' ? type.name : ""
    property real maxHealth: typeof (type) !== 'undefined' ? type.maxHealth : 0
    property real health: typeof (type) !== 'undefined' ? type.health : 0
    property real strength: typeof (type) !== 'undefined' ? type.strength : 0
    property var move1: typeof (type) !== 'undefined' ? type.move1 : ["", "", ""]
    property var attack1: typeof (type) !== 'undefined' ? type.attack1 : ["", "", "", "", ""]
    property var attack2: typeof (type) !== 'undefined' ? type.attack2 : ["", "", "", "", ""]
    property var died: typeof (type) !== 'undefined' ? type.died : ["", "", "", "", ""]
    //    property var sitting: typeof (type) !== 'undefined' ? type.sitting : []
    property var idle: typeof (type) !== 'undefined' ? type.idle : [""]
    property var skill1: typeof (type) !== 'undefined' ? type.skill1 : ["", "", "", ""]
    property var level: levelName
    property bool off: false
    property bool masked: false
    property string latestActivity: ""
    property int i: 0
    property int j: 0
    property int k: 0
    property int l: 0
    property bool isMirrored: false
    //    property var hostile: []
    property double speed: 1
    property double defense: 0
    readonly property double moveH: 90 * pageLoader.width / 1280 * speed
    readonly property double moveV: 36 * pageLoader.height / 720 * speed
    //    readonly property string path: "Entity/Hotsile/"
    onIsMirroredChanged: picture.mirror = isMirrored
    onOffChanged: off ? switchOff() : waiting.running = true
    property double posX: 0
    property double posY: 0
    onPosXChanged: x = posX
    onPosYChanged: y = posY
    z: (way.height * 2 / 3 <= y
        + hitbox.height) ? 3 : (way.height * 1 / 3 <= y
                                + hitbox.height) ? 2 : (0 < y + hitbox.height) ? 1 : 0
    state: "idle"
    onHealthChanged: health <= 0 ? state = "die" : state === "die" ? state = "idle" : {}

    //    onXChanged: (hostile.x-windowWidth/2>=mainHero.x && hostile.x+hitbox.width<=mainHero.x+mainHero.hitbox.width)?waiting.running=true:switchOff()
    Behavior on opacity {
        PropertyAnimation {
            target: hostile
            property: "opacity"
            duration: 500
        }
    }
    SequentialAnimation {
        id: waiting
        running: true
        ScriptAction {
            script: switchOff()
        }
        PauseAnimation {
            duration: 1000
        }
        ScriptAction {
            script: {
                off = false
                isRun()
            }
        }
    }

    function switchOff() {
        off = true
    }

    function isRun() {
        if (level.state !== "stopGame" && level.state !== "dialogue"
                && off === false) {
            walking()
        } else if (level.state !== "stopGame" && level.state === "dialogue"
                   && off === false) {
            hostile.state = Qt.binding(function () {
                return health <= 0 ? "die" : "idle"
            })
        } else if (off === true) {
            switchOff()
        } else
            return
    }

    function walking() {
        if (health <= 0) {
            hostile.state = "die"
        } else if (health > 0 && mainHero.state !== "die") {
            hostile.state = Qt.binding(function () {
                return health <= 0 ? "die" : "idle"
            })
            return (((mainHero.x <= hostile.x && mainHero.x
                      + mainHero.hitbox.width / 2 >= hostile.x && isMirrored
                      === false) || (mainHero.x >= hostile.x && hostile.x + hostile.hitbox.width / 2
                                     >= mainHero.x && isMirrored === true)) && hostile.z
                    == mainHero.z) ? hostile.state = "punch" : [//                                                (hostile.x-pageLoader.width/2>=mainHero.x && hostile.x+hitbox.width+pageLoader.width/2<=mainHero.x+mainHero.hitbox.width)?[
                                                                mainHero.x + mainHero.width / 2 < hostile.x ? [hostile.x -= moveH, hostile.picture.mirror = false, mainHero.x + mainHero.width / 2 > hostile.x - moveH ? hostile.x = mainHero.x + mainHero.width / 2 : {}] : mainHero.x + mainHero.width / 2 > hostile.x ? [hostile.x += moveH, hostile.picture.mirror = true, mainHero.x + mainHero.width / 2 < hostile.x + moveH ? hostile.x = mainHero.x - mainHero.width / 2 : {}] : {}, hostile.z < mainHero.z ? hostile.y += moveV : hostile.z > mainHero.z ? hostile.y -= moveV : {}]
            //                                                                                                                                                                         :waiting.running=true]
        } else if (mainHero.state === "die") {
            return (hostile.name === van.name) ? hostile.state = "skill" : {}
        } else
            isRun()
    }

    function punching() {
        mainHero.health -= strength * (1 - mainHero.defense)
        hostile.isMirrored ? (mainHero.x + mainHero.moveH / mainHero.speed * 0.2 * (1 - mainHero.defense)) < 0 ? mainHero.x = 0 : mainHero.x += mainHero.moveH / mainHero.speed * 0.2 * (1 - mainHero.defense) : (mainHero.x - mainHero.moveH / mainHero.speed * 0.2 * (1 - mainHero.defense)) >= way.width - mainHero.hitbox.width ? mainHero.x = way.width - mainHero.hitbox.width : mainHero.x -= mainHero.moveH / mainHero.speed * 0.2 * (1 - mainHero.defense)
        mainHero.health <= 0 ? mainHero.state = "die" : {}
    }

    transformOrigin: Item.Center
    Behavior on x {
        ParallelAnimation {
            PropertyAnimation {
                properties: "x"
                target: hostile
                duration: 320
            }
            SequentialAnimation {
                ScriptAction {
                    script: {
                        j = 0
                    }
                }
                SequentialAnimation {
                    loops: 3
                    PauseAnimation {
                        duration: 80
                    }
                    ScriptAction {
                        script: {
                            picture.source = move1[j]
                            j++
                        }
                    }
                }
                PauseAnimation {
                    duration: 80
                    //                    duration: 200
                }
                ScriptAction {
                    script: {
                        picture.source = imageSource
                        isRun()
                    }
                }
            }
        }
    }
    Behavior on y {
        ParallelAnimation {
            NumberAnimation {
                property: "y"
                target: hostile
                duration: 200
            }
            SequentialAnimation {
                ScriptAction {
                    script: {
                        k = 0
                    }
                }
                SequentialAnimation {
                    loops: 2
                    PauseAnimation {
                        duration: 80
                    }
                    ScriptAction {
                        script: {
                            picture.source = move1[k]
                            k++
                        }
                    }
                }
                PauseAnimation {
                    duration: 80
                    //                    duration: 200
                }
                ScriptAction {
                    script: {
                        picture.source = imageSource
                        isRun()
                    }
                }
            }
        }
    }

    transitions: [

        Transition {
            to: "punch"
            SequentialAnimation {
                paused: (level.state === "stopGame" && running) ? true : false
                ScriptAction {
                    script: i = 0
                }
                SequentialAnimation {
                    loops: 5
                    PauseAnimation {
                        duration: 66
                    }
                    ScriptAction {
                        script: {
                            if (latestActivity !== "attack1") {
                                i == 4 ? [latestActivity = "attack1", punching(
                                              )] : picture.source = attack1[i]
                            } else {
                                i == 4 ? [latestActivity = "attack2", punching(
                                              )] : picture.source = attack2[i]
                            }
                            i++
                        }
                    }
                }
                PauseAnimation {
                    duration: 66 + 250
                    //                    duration: 200
                }
                ScriptAction {
                    script: {
                        //                        attack.visible = false
                        picture.source = imageSource
                        isRun()
                    }
                }
                PauseAnimation {
                    duration: 500
                }
            }
        },
        Transition {
            to: "die"
            reversible: true
            SequentialAnimation {
                alwaysRunToEnd: true
                paused: (level.state === "stopGame" && running) ? true : false
                ScriptAction {
                    script: {
                        i = 0
                    }
                }
                ParallelAnimation {
                    SequentialAnimation {
                        loops: 5
                        PauseAnimation {
                            duration: 66
                        }
                        ScriptAction {
                            script: {
                                picture.source = died[i]
                                //                            console.log(picture.source +" "+ i)
                                i++
                            }
                        }
                    }
                    //                ScriptAction {script: hostile.width=hostile.height}
                    RotationAnimation {
                        target: picture
                        duration: 330
                        direction: RotationAnimation.Clockwise
                        to: 90
                        easing.type: "InExpo"
                    }
                    //                NumberAnimation { target: hostile; property: "y"; duration: 330; easing.type: "InExpo"; to:  hostile.y+hitbox.width/2}
                }
            }
        },
        Transition {
            from: "die"
            ParallelAnimation {
                alwaysRunToEnd: true
                ScriptAction {
                    script: {
                        /*hostile.width=Qt.binding(function() {return main.width!==undefined?0.16 * main.width: 0});*/ picture.source = imageSource
                    }
                }
                RotationAnimation {
                    target: picture
                    duration: 300
                    direction: RotationAnimation.Clockwise
                    to: 0
                    easing.type: "InExpo"
                }
                //                NumberAnimation { target: mainHero; property: "y"; duration: 300; easing.type: "InExpo"; to: mainHero.y-hitbox.width/2;}
            }
        },
        Transition {
            to: "skill"
            SequentialAnimation {
                alwaysRunToEnd: true
                paused: (level.state === "stopGame" && running) ? true : false
                ScriptAction {
                    script: {
                        l = 0
                    }
                }
                SequentialAnimation {
                    loops: 4
                    PauseAnimation {
                        duration: 66
                    }
                    ScriptAction {
                        script: {
                            picture.source = skill1[l]
                            l++
                        }
                    }
                }
                OpacityAnimator {
                    target: hostile
                    //                    from: 1
                    to: 0
                    duration: 500
                }
                ScriptAction {
                    script: {
                        picture.source = imageSource
                    }
                }
            }
        },
        Transition {
            to: "idle"
            SequentialAnimation {
                paused: (level.state === "stopGame" && running) ? true : false
                loops: Animation.Infinite
                ScriptAction {
                    script: {
                        l = 0
                        picture.source = imageSource
                    }
                }
                ParallelAnimation {
                    SequentialAnimation {
                        loops: 10
                        ScriptAction {
                            script: {
                                if ((_dialogue.item.visible === true
                                     && name === levelText[_dialogue.item.indexId * 2])
                                        || (_dialogue.visible === true
                                            && name === levelText[_dialogue.indexId * 2])) {
                                    if (l > 3) {
                                        l = 1
                                    }
                                    picture.source = idle[l]
                                    l++
                                } else if ((_dialogue.item.visible === true
                                            && name !== levelText[_dialogue.item.indexId * 2])
                                           || (_dialogue.visible === true
                                               && name !== levelText[_dialogue.indexId * 2])) {
                                    picture.source = imageSource
                                }
                            }
                        }
                        PauseAnimation {
                            duration: 300
                        }
                    }
                    SequentialAnimation {
                        PauseAnimation {
                            duration: 300 * 11
                        }
                        ScriptAction {
                            script: {
                                picture.source = idle[0]
                            }
                        }
                    }
                }
                PauseAnimation {
                    duration: 200
                }
            }
        }
    ]

    Image {
        id: picture
        width: main.width !== undefined ? 0.17 * main.width : 0
        height: main.height !== undefined ? 0.45 * main.height : 0
        //        anchors.centerIn: hostile.Center
        source: imageSource
        fillMode: Image.PreserveAspectCrop
        transformOrigin: Item.Bottom
        //        onMirrorChanged: isMirrored=mirror
        //        anchors.fill: parent
        Rectangle {
            id: hitbox
            anchors.fill: parent
            //            width: parent.paintedWidth
            //            height: parent.paintedHeight
            border.width: saver.settingsSave.hitboxVisible === true ? 2 : 0
            border.color: "black"
            //            border.color: "transparent"
            color: "transparent"
            anchors.centerIn: parent.Center
        }
        Image {
            id: mask
            source: masked ? "Van/Van_mask.png" : ""
            width: picture.width
            height: picture.height
            fillMode: picture.fillMode
            mirror: picture.mirror
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

