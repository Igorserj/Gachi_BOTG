import QtQuick 2.15
//import QtGraphicalEffects 1.15
import "../../"

Item {
    id: mainHero
    focus: true
    property var type
    property alias hitbox: hitbox
    property alias picture: picture
    property alias semen_face: semen_face
    property alias semen_pupils: semen_pupils
    property alias semen_mouth: semen_mouth
    property alias semen_speak: semen_speak
    property alias semen_speak2: semen_speak2
    property alias sideChange: sideChange
    property alias whoIsTheBoss: whoIsTheBoss
    property alias semen_jeans: semen_jeans
    property alias semen_shirt: semen_shirt
    property alias left_boot: left_boot
    property alias right_boot: right_boot
    readonly property string name: "Семен"
    property real maxHealth
    property real health
    property real strength: 7
    property double speed: 1
    property double defenseDef: 0
    property double defense: defenseDef
    property int prevState: 0
    property int targetId: 0
    property var level: levelName
    property var currentPos: [0, 0]
    property string latestActivity: ""
    property bool isMirrored: false
    readonly property double moveH: 90 * pageLoader.width / 1280 * speed
    readonly property double moveV: 36 * pageLoader.height / 720 * speed

    readonly property double sluAngleRotDef: -3
    property double sluAngleRot: sluAngleRotDef
    readonly property double slAngleRotDef: 3
    property double slAngleRot: slAngleRotDef
    readonly property double slu1AngleRotDef: -3
    property double slu1AngleRot: slu1AngleRotDef
    readonly property double sl1AngleRotDef: 3
    property double sl1AngleRot: sl1AngleRotDef
    readonly property double slhu1AngleRotDef: 0
    property double slhu1AngleRot: slhu1AngleRotDef
    readonly property double slh1AngleRotDef: -5
    property double slh1AngleRot: slh1AngleRotDef
    readonly property double slhuAngleRotDef: 0
    property double slhuAngleRot: slhuAngleRotDef
    readonly property double slhAngleRotDef: 5
    property double slhAngleRot: slhAngleRotDef
    readonly property double sfAngleRotDef: 0
    property double sfAngleRot: sfAngleRotDef
    property double semenRot: 0
    property double semenSideRot: saver.localSave.side === "left" ? 0 : -180
    height: hitbox.height
    width: hitbox.width
    transformOrigin: Item.Bottom
    z: (way.height * 2 / 3 < y
        + hitbox.height) ? 3 : (way.height * 1 / 3 < y
                                + hitbox.height) ? 2 : (0 < y + hitbox.height) ? 1 : 0
    onHealthChanged: {
        saver.localSave.playerHealth = health
        health <= 0 ? state = "die" : state === "die" ? state = "idle" : {}
    }
    onMaxHealthChanged: saver.localSave.playerMaxHealth = maxHealth
    Component.onCompleted: {
        health = saver.localSave.playerHealth
        maxHealth = saver.localSave.playerMaxHealth
        state = health > 0 ? "idle" : "die"
    }

    //        transitions: [
    //            Transition {
    //                to: "defense"
    //                ScriptAction {
    //                    script: blocking.running = true
    //                }
    //            },
    //            Transition {
    //                to: "idle"
    //                ScriptAction {
    //                    script: standup.running = true
    //                }
    //            }
    //        ]
    function isDead() {
        if (mainHero.state === "die") {
            inventory.item.opacity = 0
            inventory.item.enabled = false
            return
        }
    }
    function punching() {
        if (typeof (_hostile) !== 'undefined') {
            switch (isMirrored) {
            case false:
                //punch right
                for (var indexId = 0; indexId < _hostile.model; indexId++) {
                    if (((((_hostile.itemAt(
                                indexId).x + _hostile.itemAt(indexId).hitbox.width) >= (mainHero.x + hitbox.width / 2)) && ((_hostile.itemAt(indexId).x) <= (mainHero.x + hitbox.width))) && (((mainHero.y < _hostile.itemAt(indexId).y && mainHero.y + mainHero.hitbox.height / 2 < _hostile.itemAt(indexId).y + _hostile.itemAt(indexId).hitbox.height && mainHero.y + mainHero.hitbox.height / 2 > _hostile.itemAt(indexId).y)) || (mainHero.y + mainHero.hitbox.height / 2 > _hostile.itemAt(indexId).y + _hostile.itemAt(indexId).hitbox.height && mainHero.y < _hostile.itemAt(indexId).y + _hostile.itemAt(indexId).hitbox.height && mainHero.y > _hostile.itemAt(indexId).y) || (mainHero.y >= _hostile.itemAt(indexId).y && mainHero.y + mainHero.hitbox.height / 2 <= _hostile.itemAt(indexId).y + _hostile.itemAt(indexId).hitbox.height))) && (_hostile.itemAt(indexId).state !== "die")) {
                        console.log("Hit!")
                        targetId = indexId
                        _hostile.itemAt(
                                    indexId).health -= strength * (1 - _hostile.itemAt(
                                                                       indexId).defense)
                        console.log("Damage: " + (strength * (1 - _hostile.itemAt(
                                                                  indexId).defense)))
                        _hostile.itemAt(indexId).x += _hostile.itemAt(
                                    indexId).moveH / _hostile.itemAt(
                                    indexId).speed * 0.2 * (1 - _hostile.itemAt(
                                                                indexId).defense)
                        //                        _hostile.itemAt(
                        //                                    indexId).health <= 0 ? _hostile.itemAt(
                        //                                                               indexId).state = "die" : {}
                    }
                }
                break
            case true:
                for (var indexId = 0; indexId < _hostile.model; indexId++) {
                    if (((((_hostile.itemAt(
                                indexId).x + _hostile.itemAt(indexId).hitbox.width) >= (mainHero.x)) && ((_hostile.itemAt(indexId).x) <= (mainHero.x + hitbox.width / 2))) && (((mainHero.y < _hostile.itemAt(indexId).y && mainHero.y + mainHero.hitbox.height / 2 < _hostile.itemAt(indexId).y + _hostile.itemAt(indexId).hitbox.height && mainHero.y + mainHero.hitbox.height / 2 > _hostile.itemAt(indexId).y)) || (mainHero.y + mainHero.hitbox.height / 2 > _hostile.itemAt(indexId).y + _hostile.itemAt(indexId).hitbox.height && mainHero.y < _hostile.itemAt(indexId).y + _hostile.itemAt(indexId).hitbox.height && mainHero.y > _hostile.itemAt(indexId).y) || (mainHero.y >= _hostile.itemAt(indexId).y && mainHero.y + mainHero.hitbox.height / 2 <= _hostile.itemAt(indexId).y + _hostile.itemAt(indexId).hitbox.height))) && (_hostile.itemAt(indexId).state !== "die")) {
                        console.log("Hit!")
                        targetId = indexId
                        _hostile.itemAt(
                                    indexId).health -= strength * (1 - _hostile.itemAt(
                                                                       indexId).defense)
                        console.log("Damage: " + (strength * (1 - _hostile.itemAt(
                                                                  indexId).defense)))
                        _hostile.itemAt(indexId).x -= _hostile.itemAt(
                                    indexId).moveH / _hostile.itemAt(
                                    indexId).speed * 0.2 * (1 - _hostile.itemAt(
                                                                indexId).defense)
                        //                        _hostile.itemAt(
                        //                                    indexId).health <= 0 ? _hostile.itemAt(
                        //                                                               indexId).state = "die" : {}
                    }
                }
                break
            }
        }
    }

    //    function punching() {
    //        if (typeof (_hostile) !== 'undefined') {
    //            switch (isMirrored) {
    //            case false:
    //                var hero = mainHero
    //                for (var indexId = 0; indexId < _hostile.model; indexId++) {
    //                    var enemy = _hostile.itemAt(indexId)
    //                    if (((((enemy.x + enemy.hitbox.width) >= (hero.x + hitbox.width / 2))
    //                          && ((enemy.x) <= (hero.x + hitbox.width))) && (((hero.y < enemy.y && hero.y + hero.hitbox.height / 2 < enemy.y + enemy.hitbox.height && hero.y + hero.hitbox.height / 2 > enemy.y)) || (hero.y + hero.hitbox.height / 2 > enemy.y + enemy.hitbox.height && hero.y < enemy.y + enemy.hitbox.height && hero.y > enemy.y) || (hero.y >= enemy.y && hero.y + hero.hitbox.height / 2 <= enemy.y + enemy.hitbox.height))) && (enemy.state !== "die")) {
    //                        targetId = indexId
    //                        _hostile.itemAt(
    //                                    indexId).health -= strength * (1 - enemy.defense)
    //                        _hostile.itemAt(indexId).x += enemy.moveH / enemy.speed
    //                                * 0.2 * (1 - enemy.defense)
    //                    }
    //                }

    //                break
    //            case true:
    //                var hero = mainHero
    //                for (var indexId = 0; indexId < _hostile.model; indexId++) {
    //                    var enemy = _hostile.itemAt(indexId)
    //                    if (((((enemy.x + enemy.hitbox.width) >= (hero.x)) && ((enemy.x) <= (hero.x + hitbox.width / 2))) && (((hero.y < enemy.y && hero.y + hero.hitbox.height / 2 < enemy.y + enemy.hitbox.height && hero.y + hero.hitbox.height / 2 > enemy.y)) || (hero.y + hero.hitbox.height / 2 > enemy.y + enemy.hitbox.height && hero.y < enemy.y + enemy.hitbox.height && hero.y > enemy.y) || (hero.y >= enemy.y && hero.y + hero.hitbox.height / 2 <= enemy.y + enemy.hitbox.height))) && (enemy.state !== "die")) {
    //                        _hostile.itemAt(
    //                                    indexId).health -= strength * (1 - enemy.defense)
    //                        _hostile.itemAt(indexId).x -= enemy.moveH / enemy.speed
    //                                * 0.2 * (1 - enemy.defense)
    //                    }
    //                }
    //                break
    //            }
    //        }
    //    }
    Behavior on x {
        ParallelAnimation {
            PropertyAnimation {
                properties: "x"
                target: mainHero
                duration: 320
            }
            ScriptAction {
                script: {
                    walking.running = true
                }
            }
        }
    }
    Behavior on y {
        ParallelAnimation {
            NumberAnimation {
                property: "y"
                target: mainHero
                duration: 320
            }
            ScriptAction {
                script: {
                    walking.running = true
                }
            }
        }
    }
    states: [
        State {
            name: "idle"
            PropertyChanges {
                target: mainHero
            }
        },
        State {
            name: "defense"
            PropertyChanges {
                target: mainHero
            }
        }
    ]
    transitions: [
        Transition {
            to: "die"
            ParallelAnimation {
                alwaysRunToEnd: true
                ScriptAction {
                    script: dying.running = true
                }
            }
        },
        Transition {
            from: "die"
            ParallelAnimation {
                alwaysRunToEnd: true
                ScriptAction {
                    script: standup.running = true
                }
            }
        },
        Transition {
            to: "sit"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        sitting.running = true
                    }
                }
            }
        },
        Transition {
            to: "idle"
            ScriptAction {
                script: standup.running = true
            }
        },
        Transition {
            to: "use"
            SequentialAnimation {
                PauseAnimation {
                    duration: 1000
                }
                PropertyAction {
                    target: mainHero
                    property: "state"
                    value: health <= 0 ? "die" : "idle"
                }
            }
        },
        Transition {
            to: "defense"
            ParallelAnimation {
                ScriptAction {
                    script: blocking.running = true
                }
                SequentialAnimation {
                    PauseAnimation {
                        duration: 200
                    }
                    ScriptAction {
                        script: mainHero.defense = 1
                    }
                }
            }
        },
        Transition {
            from: "defense"
            ScriptAction {
                script: standup.running = true
            }
        }
    ]

    Item {
        id: picture
        x: hitbox.width / 2
        y: -hitbox.height * 0.04
        scale: pageLoader.height / 1080 * 0.25
        transform: [
            Rotation {
                origin.x: picture.width / 2
                origin.y: picture.height / 2
                axis {
                    x: 0
                    y: 1
                    z: 0
                }
                angle: semenSideRot
            },
            Rotation {
                origin.x: picture.width / 2
                origin.y: hitbox.height
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: semenRot
            }
        ]

        Image {
            id: semen_nude_body
            y: 297
            anchors.horizontalCenter: parent.horizontalCenter
            source: "Semen/Semen_nude_body.png"
            fillMode: Image.PreserveAspectFit

            Image {
                id: semen_face
                x: 30
                y: -205
                anchors.bottom: semen_nude_body.top
                anchors.bottomMargin: -135
                anchors.left: semen_nude_body.left
                anchors.leftMargin: 30
                source: "Semen/Semen_face.png"
                transformOrigin: Item.Bottom
                fillMode: Image.PreserveAspectFit
                transform: Rotation {
                    origin.x: semen_face.width / 2
                    origin.y: semen_face.height * 0.60
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: sfAngleRot
                }

                Image {
                    id: semen_pupils
                    height: 30
                    anchors.verticalCenter: semen_face.verticalCenter
                    anchors.verticalCenterOffset: -semen_face.height * 0.045
                    x: semen_face.width * 0.41
                    width: 120
                    source: "Semen/Semen_pupils.png"
                    transformOrigin: Item.Center
                }
                Image {
                    id: semen_mouth
                    x: 133
                    y: 274
                    source: "Semen/Semen_mouth.png"
                    fillMode: Image.PreserveAspectFit
                    visible: (!semen_speak.visible && !semen_speak2.visible)
                }

                Image {
                    id: semen_speak
                    x: 133
                    y: 274
                    source: "Semen/Semen_speak.png"
                    fillMode: Image.PreserveAspectFit
                    visible: false
                }

                Image {
                    id: semen_speak2
                    x: 145
                    y: 274
                    source: "Semen/Semen_speak2.png"
                    fillMode: Image.PreserveAspectFit
                    visible: false
                }
            }
        }

        Image {
            id: semen_jeans
            width: 450
            height: 180
            anchors.left: semen_shorts.left
            anchors.bottom: semen_shorts.bottom
            source: "Semen/Semen_jeans.png"
            //        anchors.bottomMargin: 0
            anchors.leftMargin: -10
            fillMode: Image.Stretch
            visible: !!inventory.item ? inventory.item.midVisible ? true : false : true
        }

        Image {
            id: semen_leg_upper1
            anchors.right: semen_belt.right
            anchors.top: semen_belt.bottom
            anchors.rightMargin: 12
            anchors.topMargin: -9
            source: "Semen/Semen_leg_upper.png"
            transform: Rotation {
                origin.x: semen_leg_upper1.width / 2
                origin.y: semen_leg_upper1.height * 0.1
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: slu1AngleRot
            }

            Image {
                id: semen_leg1
                x: 44
                y: 422
                source: "Semen/Semen_leg.png"
                z: semen_leg_upper1.z + 1
                transform: Rotation {
                    origin.x: semen_leg1.width / 3
                    origin.y: semen_leg1.height * 0.05
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: sl1AngleRot
                }
                Image {
                    id: right_boot
                    source: "Semen/Semen_boot.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    visible: !!inventory.item ? inventory.item.botVisible ? true : false : true
                }
            }
        }

        Image {
            id: semen_leg_upper21
            anchors.left: semen_leg_upper1.left
            anchors.top: semen_leg_upper1.top
            anchors.right: semen_leg_upper1.right
            anchors.topMargin: -25
            anchors.rightMargin: -16
            anchors.leftMargin: -5
            source: "Semen/Semen_leg_upper2.png"
            mirror: false
            visible: semen_jeans.visible
            transform: Rotation {
                origin.x: semen_leg_upper.width / 1.75
                origin.y: semen_leg_upper.height * 0.165
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: slu1AngleRot
            }
            Image {
                id: semen_leg21
                source: "Semen/Semen_leg2.png"
                fillMode: Image.PreserveAspectFit
                anchors.top: semen_leg_upper21.bottom
                anchors.topMargin: -120
                anchors.horizontalCenter: semen_leg_upper21.horizontalCenter
                anchors.horizontalCenterOffset: 25
                transform: Rotation {
                    origin.x: semen_leg1.width / 2.2
                    origin.y: semen_leg1.height * 0.11
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: sl1AngleRot
                }
            }
        }

        Image {
            id: semen_leg_upper
            anchors.left: semen_belt.left
            anchors.top: semen_belt.bottom
            anchors.topMargin: -9
            anchors.leftMargin: 12
            source: "Semen/Semen_leg_upper.png"
            transform: Rotation {
                origin.x: semen_leg_upper.width / 2
                origin.y: semen_leg_upper.height * 0.1
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: sluAngleRot
            }

            Image {
                id: semen_leg
                x: 44
                y: 422
                source: "Semen/Semen_leg.png"
                z: semen_leg_upper.z + 1
                transform: Rotation {
                    origin.x: semen_leg.width / 3
                    origin.y: semen_leg.height * 0.05
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: slAngleRot
                }
                Image {
                    id: left_boot
                    source: "Semen/Semen_boot.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    visible: !!inventory.item ? inventory.item.botVisible ? true : false : true
                }
            }
        }

        Image {
            id: semen_leg_upper2
            anchors.left: semen_leg_upper.left
            anchors.top: semen_leg_upper.top
            anchors.topMargin: -25
            anchors.right: semen_leg_upper.right
            anchors.leftMargin: -16
            anchors.rightMargin: -5
            source: "Semen/Semen_leg_upper2.png"
            visible: semen_jeans.visible
            transform: [
                Rotation {
                    origin.x: semen_leg_upper.width / 1.65
                    origin.y: semen_leg_upper.height * 0.155
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: sluAngleRot
                }
            ]
            Image {
                id: semen_leg2
                source: "Semen/Semen_leg2.png"
                fillMode: Image.PreserveAspectFit
                anchors.top: semen_leg_upper2.bottom
                anchors.topMargin: -120
                anchors.horizontalCenter: semen_leg_upper2.horizontalCenter
                anchors.horizontalCenterOffset: 30
                transform: Rotation {
                    origin.x: semen_leg.width / 2.2
                    origin.y: semen_leg.height * 0.11
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: slAngleRot
                }
            }
        }

        Image {
            id: semen_shorts
            anchors.horizontalCenter: semen_nude_body.horizontalCenter
            anchors.top: semen_nude_body.bottom
            anchors.topMargin: -height / 3.5
            source: "Semen/Semen_shorts.png"
            fillMode: Image.PreserveAspectFit
            visible: !semen_jeans.visible
        }

        Image {
            id: semen_right_shoulder
            anchors.left: semen_nude_body.right
            anchors.top: semen_nude_body.top
            anchors.topMargin: 136
            anchors.leftMargin: -116
            source: "Semen/Semen_right_shoulder.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: semen_left_shoulder
            anchors.right: semen_nude_body.left
            anchors.top: semen_nude_body.top
            anchors.topMargin: 130
            anchors.rightMargin: -60
            source: "Semen/Semen_left_shoulder.png"
            fillMode: Image.PreserveAspectCrop
        }

        Image {
            id: semen_shirt
            anchors.horizontalCenter: semen_nude_body.horizontalCenter
            anchors.verticalCenter: semen_nude_body.verticalCenter
            anchors.verticalCenterOffset: 58
            anchors.horizontalCenterOffset: -33
            source: "Semen/Semen_shirt.png"
            fillMode: Image.PreserveAspectFit
            visible: !!inventory.item ? inventory.item.topVisible ? true : false : true
        }

        Image {
            id: semen_belt
            anchors.left: semen_shorts.left
            anchors.top: semen_nude_body.bottom
            anchors.topMargin: -20
            source: "Semen/Semen_belt.png"
            fillMode: Image.PreserveAspectFit
            visible: semen_jeans.visible
        }

        Image {
            id: semen_left_hand_upper1
            anchors.right: semen_right_shoulder.right
            anchors.rightMargin: -45
            y: 435
            source: "Semen/Semen_left_hand_upper.png"
            mirror: true
            fillMode: Image.PreserveAspectFit
            transform: Rotation {
                origin.x: semen_left_hand_upper1.width / 2
                origin.y: semen_left_hand_upper1.height * 0.1
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: slhu1AngleRot
            }

            Image {
                id: semen_left_hand1
                x: -135
                y: 402
                source: "Semen/Semen_left_hand.png"
                mirror: true
                fillMode: Image.PreserveAspectFit
                transform: Rotation {
                    origin.x: semen_left_hand1.width * 0.85
                    origin.y: semen_left_hand1.height * 0.04
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: slh1AngleRot
                }
            }

            Image {
                id: semen_left_hand21
                anchors.fill: semen_left_hand1
                source: "Semen/Semen_left_hand2.png"
                mirror: true
                fillMode: Image.PreserveAspectFit
                visible: !semen_left_hand1.visible
                transform: Rotation {
                    origin.x: semen_left_hand1.width * 0.85
                    origin.y: semen_left_hand1.height * 0.04
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: slh1AngleRot
                }
            }
        }

        Image {
            id: semen_left_hand_upper
            anchors.left: semen_left_shoulder.left
            anchors.leftMargin: -20
            y: 427
            source: "Semen/Semen_left_hand_upper.png"
            fillMode: Image.PreserveAspectFit
            transform: Rotation {
                origin.x: semen_left_hand_upper.width / 2
                origin.y: semen_left_hand_upper.height * 0.1
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: slhuAngleRot
            }

            Image {
                id: semen_left_hand
                x: 27
                y: 378
                source: "Semen/Semen_left_hand.png"
                rotation: 0
                fillMode: Image.PreserveAspectFit
                transform: Rotation {
                    origin.x: semen_left_hand.width * 0.1
                    origin.y: semen_left_hand.height * 0.1
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: slhAngleRot
                }
            }

            Image {
                id: semen_left_hand2
                anchors.fill: semen_left_hand
                source: "Semen/Semen_left_hand2.png"
                fillMode: Image.PreserveAspectFit
                visible: !semen_left_hand.visible
                transform: Rotation {
                    origin.x: semen_left_hand.width * 0.1
                    origin.y: semen_left_hand.height * 0.1
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: slhAngleRot
                }
            }
        }

        Image {
            id: semen_left_hand_upper21
            anchors.verticalCenter: semen_right_shoulder.verticalCenter
            anchors.horizontalCenter: semen_right_shoulder.horizontalCenter
            anchors.horizontalCenterOffset: 65
            anchors.verticalCenterOffset: 25
            visible: semen_shirt.visible
            source: "Semen/Semen_left_hand_upper2.png"
            fillMode: Image.PreserveAspectFit
            transform: [
                Rotation {
                    axis.y: 0
                    origin.x: semen_left_hand_upper21.width / 2
                    angle: slhu1AngleRot
                    origin.y: semen_left_hand_upper21.height * 0.2
                    axis.z: 1
                    axis.x: 0
                }
            ]
            mirror: true
            rotation: -1
        }

        Image {
            id: semen_left_hand_upper2
            anchors.verticalCenter: semen_left_shoulder.verticalCenter
            anchors.horizontalCenter: semen_left_shoulder.horizontalCenter
            anchors.horizontalCenterOffset: -45
            anchors.verticalCenterOffset: 25
            visible: semen_shirt.visible
            source: "Semen/Semen_left_hand_upper2.png"
            fillMode: Image.PreserveAspectFit
            transform: [
                Rotation {
                    axis.y: 0
                    origin.x: semen_left_hand_upper2.width / 2
                    origin.y: semen_left_hand_upper2.height * 0.15
                    angle: slhuAngleRot
                    axis.z: 1
                    axis.x: 0
                }
            ]
        }
    }
    Rectangle {
        id: hitbox
        //        x: picture.x - width / 2
        //        y: picture.y + height * 0.04
        height: picture.childrenRect.height * 0.58 * picture.scale / 0.4
        width: picture.childrenRect.width * 0.7 * picture.scale / 0.4
        border.width: saver.settingsSave.hitboxVisible === true ? 2 : 0
        border.color: "black"
        color: "transparent"
        anchors.centerIn: picture.Center
    }

    SequentialAnimation {
        id: blinking
        running: true
        loops: Animation.Infinite

        PauseAnimation {
            duration: 3000
        }
        ParallelAnimation {
            PropertyAnimation {
                target: semen_pupils
                property: "height"
                to: 10
                duration: 150
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: semen_pupils
                property: "height"
                to: 30
                duration: 150
            }
        }
    }

    SequentialAnimation {
        id: walking
        running: false
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "slu1AngleRot"
                to: -30
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "sl1AngleRot"
                to: 45
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "slhuAngleRot"
                to: -2
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "slhAngleRot"
                to: -2
                duration: 250
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: 250
                }
                ParallelAnimation {
                    ParallelAnimation {
                        PropertyAnimation {
                            target: mainHero
                            property: "slu1AngleRot"
                            to: slu1AngleRotDef
                            duration: 250
                        }
                        PropertyAnimation {
                            target: mainHero
                            property: "sl1AngleRot"
                            to: sl1AngleRotDef
                            duration: 250
                        }
                        PropertyAnimation {
                            target: mainHero
                            property: "slhuAngleRot"
                            to: slhuAngleRotDef
                            duration: 250
                        }
                        PropertyAnimation {
                            target: mainHero
                            property: "slhAngleRot"
                            to: slhAngleRotDef
                            duration: 250
                        }
                        PropertyAnimation {
                            target: mainHero
                            property: "sfAngleRot"
                            to: 2
                            duration: 250
                        }
                    }
                    SequentialAnimation {
                        ParallelAnimation {
                            PropertyAnimation {
                                target: mainHero
                                property: "sluAngleRot"
                                to: -30
                                duration: 250
                            }
                            PropertyAnimation {
                                target: mainHero
                                property: "slAngleRot"
                                to: 45
                                duration: 250
                            }
                            PropertyAnimation {
                                target: mainHero
                                property: "slhu1AngleRot"
                                to: 2
                                duration: 250
                            }
                            PropertyAnimation {
                                target: mainHero
                                property: "slh1AngleRot"
                                to: 2
                                duration: 250
                            }
                        }
                        ParallelAnimation {
                            PropertyAnimation {
                                target: mainHero
                                property: "sluAngleRot"
                                to: slu1AngleRotDef
                                duration: 250
                            }
                            PropertyAnimation {
                                target: mainHero
                                property: "slAngleRot"
                                to: slAngleRotDef
                                duration: 250
                            }
                            PropertyAnimation {
                                target: mainHero
                                property: "slhu1AngleRot"
                                to: slhu1AngleRotDef
                                duration: 250
                            }
                            PropertyAnimation {
                                target: mainHero
                                property: "slh1AngleRot"
                                to: slh1AngleRotDef
                                duration: 250
                            }
                            PropertyAnimation {
                                target: mainHero
                                property: "sfAngleRot"
                                to: sfAngleRotDef
                                duration: 250
                            }
                        }
                    }
                }
            }
        }
    }

    SequentialAnimation {
        id: punching1
        running: false
        PropertyAnimation {
            target: mainHero
            property: "slhAngleRot"
            to: -30
            duration: 150
        }
        PropertyAction {
            target: semen_left_hand
            property: "visible"
            value: false
        }
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "slhuAngleRot"
                to: -30
                duration: 150
                easing.type: Easing.InExpo
            }
            PropertyAnimation {
                target: mainHero
                property: "slhAngleRot"
                to: -35
                duration: 150
                easing.type: Easing.InExpo
            }
            PropertyAnimation {
                target: mainHero
                property: "sfAngleRot"
                to: 2
                duration: 150
            }
        }
        ScriptAction {
            script: punching()
        }
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "sfAngleRot"
                to: sfAngleRotDef
                duration: 150
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "slhuAngleRot"
                to: slhuAngleRotDef
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "slhAngleRot"
                to: slhAngleRotDef
                duration: 250
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: 100
                }
                PropertyAction {
                    target: semen_left_hand
                    property: "visible"
                    value: true
                }
            }
        }
    }

    SequentialAnimation {
        id: punching2
        running: false
        PropertyAnimation {
            target: mainHero
            property: "slh1AngleRot"
            to: -30
            duration: 150
        }
        PropertyAction {
            target: semen_left_hand1
            property: "visible"
            value: false
        }
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "slhu1AngleRot"
                to: -20
                duration: 150
            }
            PropertyAnimation {
                target: mainHero
                property: "slh1AngleRot"
                to: -155
                duration: 150
                easing.type: Easing.InExpo
            }
            PropertyAnimation {
                target: mainHero
                property: "sfAngleRot"
                to: 2
                duration: 150
            }
        }
        ScriptAction {
            script: punching()
        }
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "sfAngleRot"
                to: sfAngleRotDef
                duration: 150
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "slhu1AngleRot"
                to: slhu1AngleRotDef
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "slh1AngleRot"
                to: slh1AngleRotDef
                duration: 250
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: 100
                }
                PropertyAction {
                    target: semen_left_hand1
                    property: "visible"
                    value: true
                }
            }
        }
    }

    SequentialAnimation {
        id: blocking
        running: false
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "slhu1AngleRot"
                to: 10
            }
            PropertyAnimation {
                target: mainHero
                property: "slh1AngleRot"
                to: 90
            }
            PropertyAnimation {
                target: mainHero
                property: "slhuAngleRot"
                to: -10
            }
            PropertyAnimation {
                target: mainHero
                property: "slhAngleRot"
                to: -90
            }
            PropertyAction {
                target: semen_left_hand
                property: "visible"
                value: false
            }
            PropertyAction {
                target: semen_left_hand1
                property: "visible"
                value: false
            }
        }
    }

    SequentialAnimation {
        id: sitting
        running: false
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "slh1AngleRot"
                to: 10
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "slhAngleRot"
                to: -10
                duration: 250
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "sluAngleRot"
                to: -65
                duration: 300
            }
            PropertyAnimation {
                target: mainHero
                property: "slAngleRot"
                to: 45
                duration: 300
            }

            PropertyAnimation {
                target: mainHero
                property: "slu1AngleRot"
                to: -65
                duration: 300
            }
            PropertyAnimation {
                target: mainHero
                property: "sl1AngleRot"
                to: 45
                duration: 300
            }
        }
    }

    SequentialAnimation {
        id: standup
        running: false
        ParallelAnimation {
            PropertyAnimation {
                target: semen_pupils
                property: "height"
                to: 30
                duration: 150
            }
            PropertyAnimation {
                target: mainHero
                property: "slh1AngleRot"
                to: slh1AngleRotDef
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "slhAngleRot"
                to: slhAngleRotDef
                duration: 250
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "sluAngleRot"
                to: sluAngleRotDef
                duration: 300
            }
            PropertyAnimation {
                target: mainHero
                property: "slAngleRot"
                to: slAngleRotDef
                duration: 300
            }

            PropertyAnimation {
                target: mainHero
                property: "slu1AngleRot"
                to: slu1AngleRotDef
                duration: 300
            }
            PropertyAnimation {
                target: mainHero
                property: "sl1AngleRot"
                to: sl1AngleRotDef
                duration: 300
            }

            PropertyAnimation {
                target: mainHero
                property: "slhu1AngleRot"
                to: slhu1AngleRotDef
                duration: 300
            }
            PropertyAnimation {
                target: mainHero
                property: "slh1AngleRot"
                to: slh1AngleRotDef
                duration: 300
            }
            PropertyAnimation {
                target: mainHero
                property: "slhuAngleRot"
                to: slhuAngleRotDef
                duration: 300
            }
            PropertyAnimation {
                target: mainHero
                property: "slhAngleRot"
                to: slhAngleRotDef
                duration: 300
            }
            PropertyAnimation {
                target: mainHero
                property: "sfAngleRot"
                to: sfAngleRotDef
                duration: 300
            }
            PropertyAction {
                target: semen_left_hand
                property: "visible"
                value: true
            }
            PropertyAction {
                target: semen_left_hand1
                property: "visible"
                value: true
            }
            PropertyAnimation {
                target: mainHero
                property: "semenRot"
                to: 0
                duration: 300
            }
            ScriptAction {
                script: {
                    mainHero.defense = mainHero.defenseDef
                    blinking.running = true
                }
            }
        }
    }

    SequentialAnimation {
        id: sideChange
        running: false
        PropertyAnimation {
            target: mainHero
            property: "semenSideRot"
            to: semenSideRot == 0 ? -180 : 0
            duration: 500
        }
    }

    SequentialAnimation {
        id: dying
        running: false
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "slhuAngleRot"
                to: -10
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "slhAngleRot"
                to: -65
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "slhu1AngleRot"
                to: 10
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "slh1AngleRot"
                to: 65
                duration: 250
            }

            PropertyAnimation {
                target: semen_pupils
                property: "height"
                to: 10
                duration: 150
            }
            PropertyAnimation {
                target: semen_pupils
                property: "anchors.bottomMargin"
                to: 180
                duration: 150
            }
            PropertyAction {
                target: blinking
                property: "running"
                value: false
            }
            PropertyAnimation {
                target: mainHero
                property: "sfAngleRot"
                to: 10
                duration: 150
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "semenRot"
                to: -90
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "sluAngleRot"
                to: -15
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "slAngleRot"
                to: 30
                duration: 250
            }

            PropertyAnimation {
                target: mainHero
                property: "slu1AngleRot"
                to: -15
                duration: 250
            }
            PropertyAnimation {
                target: mainHero
                property: "sl1AngleRot"
                to: 30
                duration: 250
            }
        }
    }

    SequentialAnimation {
        id: speaking
        alwaysRunToEnd: true
        loops: Animation.Infinite
        running: (((_dialogue.item.visible === true
                    && name === levelText[_dialogue.item.indexId * 2])
                   || (_dialogue.visible === true
                       && name === levelText[_dialogue.indexId * 2]))) ? true : false
        PropertyAction {
            target: semen_speak
            property: "visible"
            value: true
        }
        PauseAnimation {
            duration: 200
        }
        ParallelAnimation {
            PropertyAction {
                target: semen_speak
                property: "visible"
                value: false
            }
            PropertyAction {
                target: semen_speak2
                property: "visible"
                value: true
            }
        }
        PauseAnimation {
            duration: 200
        }
        PropertyAction {
            target: semen_speak2
            property: "visible"
            value: false
        }
    }

    SequentialAnimation {
        id: whoIsTheBoss
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "slhuAngleRot"
                to: -30
                duration: 350
            }
            PropertyAnimation {
                target: mainHero
                property: "slhAngleRot"
                to: 0
                duration: 350
            }
        }
        PropertyAction {
            target: semen_left_hand
            property: "visible"
            value: false
        }
        PropertyAnimation {
            target: mainHero
            property: "slhAngleRot"
            to: -10
            duration: 300
        }
        PropertyAction {
            target: semen_left_hand
            property: "visible"
            value: true
        }
        ParallelAnimation {
            PropertyAnimation {
                target: mainHero
                property: "slhuAngleRot"
                to: 0
                duration: 450
            }
            PropertyAnimation {
                target: mainHero
                property: "slhAngleRot"
                to: 15
                duration: 450
            }
        }
        ParallelAnimation {
            ParallelAnimation {
                PropertyAnimation {
                    target: mainHero
                    property: "slhuAngleRot"
                    to: -30
                    duration: 350
                }
                PropertyAnimation {
                    target: mainHero
                    property: "slhAngleRot"
                    to: -45
                    duration: 350
                }
                SequentialAnimation {
                    PauseAnimation {
                        duration: 200
                    }
                    PropertyAction {
                        target: semen_left_hand
                        property: "visible"
                        value: false
                    }
                }
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: mainHero
                    property: "slhu1AngleRot"
                    to: -10
                    duration: 350
                }
                PropertyAnimation {
                    target: mainHero
                    property: "slh1AngleRot"
                    to: -135
                    duration: 350
                }
                SequentialAnimation {
                    PauseAnimation {
                        duration: 200
                    }
                    PropertyAction {
                        target: semen_left_hand1
                        property: "visible"
                        value: false
                    }
                }
            }
        }

        PauseAnimation {
            duration: 200
        }

        ParallelAnimation {
            ParallelAnimation {
                PropertyAnimation {
                    target: mainHero
                    property: "slhuAngleRot"
                    to: 0
                    duration: 300
                }
                PropertyAnimation {
                    target: mainHero
                    property: "slhAngleRot"
                    to: 15
                    duration: 300
                }
                SequentialAnimation {
                    PauseAnimation {
                        duration: 150
                    }
                    PropertyAction {
                        target: semen_left_hand
                        property: "visible"
                        value: true
                    }
                }
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: mainHero
                    property: "slhu1AngleRot"
                    to: 0
                    duration: 300
                }
                PropertyAnimation {
                    target: mainHero
                    property: "slh1AngleRot"
                    to: -15
                    duration: 300
                }
                SequentialAnimation {
                    PauseAnimation {
                        duration: 150
                    }
                    PropertyAction {
                        target: semen_left_hand1
                        property: "visible"
                        value: true
                    }
                }
            }
        }
    }

    function keyJ() {
        if (health > 0) {
            switch (level.state) {
            case "stopGame":
                break
            case "dialogue":
                break
            default:
                state = "idle"
                latestActivity == "attack1" ? [punching2.running = true, latestActivity
                                               = "attack2"] : [punching1.running
                                                               = true, latestActivity = "attack1"]
                break
            }
        }
    }

    function keyA() {
        if (health > 0) {
            switch (level.state) {
            case "stopGame":
                break
            case "dialogue":
                break
            default:
                state = "idle"
                if (semenSideRot === 0) {
                    sideChange.running = true
                } else {
                    if (x - moveH > 0)
                        x -= moveH
                    else
                        x = 0

                    if (way.x + x + hitbox.width / 2 <= room.width - main.windowWidth / 2
                            && -levelName.x - moveH > 0)
                        levelName.x = -(way.x + x) + main.windowWidth / 2
                    else if (-levelName.x - moveH <= 0) {
                        levelName.x = 0
                    }
                    //                    event.accepted = true
                }
                isMirrored = true
                break
            }
            //            event.accepted = true
        }
    }
    function keyD() {
        if (health > 0) {
            switch (level.state) {
            case "stopGame":
                break
            case "dialogue":
                break
            default:
                state = "idle"
                if (semenSideRot === -180) {
                    sideChange.running = true
                } else {
                    if (x + hitbox.width + moveH < way.width) {
                        x += moveH
                    } else
                        x = way.width - hitbox.width

                    if (way.x + x + hitbox.width / 2 >= main.windowWidth / 2
                            && -levelName.x + moveH + main.windowWidth < room.width)
                        levelName.x = -(way.x + x + hitbox.width) + main.windowWidth / 2
                    else if (-levelName.x + moveH + main.windowWidth >= room.width) {
                        levelName.x = -room.width + main.windowWidth
                    }
                    //                    event.accepted = true
                }
                isMirrored = false
                break
            }
            //            event.accepted = true
        }
    }
    function keyW() {
        if (health > 0) {
            switch (level.state) {
            case "stopGame":
                break
            case "dialogue":
                break
            default:
                state = "idle"
                if (y + hitbox.height + moveV < way.height)
                    y += moveV
                else
                    y = way.height - hitbox.height

                //                event.accepted = true
                break
            }
            //            event.accepted = true
        }
    }

    function keyS() {
        if (health > 0) {
            switch (level.state) {
            case "stopGame":
                break
            case "dialogue":
                break
            default:
                state = "idle"
                if (y + hitbox.height - moveV > 0)
                    y -= moveV
                else
                    y = -hitbox.height

                //                event.accepted = true
                break
            }
            //            event.accepted = true
        }
    }
    function keyE() {
        if (health > 0) {
            switch (level.state) {
            case "stopGame":
                break
            case "dialogue":
                break
            default:
                state = "idle"
                mainHero.state = "use"
                break
            }
        }
    }
    function keySpace() {
        if (typeof (_dialogue.item) !== 'undefined')
            return (_dialogue.item.visible ? _dialogue.item.fadeOutRunning = true : _dialogue.item.visible ? _dialogue.item.fadeOutRunning = true : {})
    }

    function keyEscape() {
        switch (level.state) {
        case "stopGame":
            subMenu.item ? [subMenu.item.opacity = 0, subMenu.item.enabled = false] : console.log(
                               "SubMenu not loaded yet")
            if (typeof (_hostile) !== 'undefined') {
                for (var indexId = 0; indexId < _hostile.model; indexId++) {
                    _hostile.itemAt(indexId).off = true
                    _hostile.itemAt(indexId).off = false
                    _hostile.itemAt(indexId).isRun()
                }
            }
            break
        default:
            inventory.item.opacity
                    > 0 ? [inventory.item.opacity = 0, inventory.item.enabled
                           = false] : subMenu.item ? [subMenu.item.opacity = 1, subMenu.item.enabled
                                                      = true] : console.log(
                                                         "SubMenu not loaded yet")
            break
        }
    }

    function keyI() {
        if (health > 0) {
            switch (level.state) {
            case "stopGame":
                break
            case "dialogue":
                break
            default:
                inventory.item.opacity = inventory.item.opacity > 0 ? 0 : 1
                inventory.item.enabled = !inventory.item.enabled
                break
            }
        }
    }

    function keyF() {
        mainHero.state = mainHero.state === "defense" ? "idle" : "defense"
    }

    Keys.onPressed: event => {
                        if (event.key === 74 || event.key === 1054) {
                            keyJ()
                            event.accepted = true
                        } else if (event.key === 65 || event.key === 1060) {
                            keyA()
                            event.accepted = true
                        } else if (event.key === 68 || event.key === 1042) {
                            keyD()
                            event.accepted = true
                        } else if (event.key === 83 || event.key === 1067) {
                            keyW()
                            event.accepted = true
                        } else if (event.key === 87 || event.key === 1062) {
                            keyS()
                            event.accepted = true
                        } else if (event.key === 69 || event.key === 1059) {
                            keyE()
                            event.accepted = true
                        } else if (event.key === 73 || event.key === 1064) {
                            keyI()
                            event.accepted = true
                        } else if (event.key === Qt.Key_Escape) {
                            keyEscape()
                            event.accepted = true
                        } else if (event.key === Qt.Key_Space) {
                            keySpace()
                            event.accepted = true
                        } else if (event.key === Qt.Key_F) {
                            keyF()
                            event.accepted = true
                        }
                    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75;height:720;width:1280}
}
##^##*/

