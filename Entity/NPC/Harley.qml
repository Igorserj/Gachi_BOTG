import QtQuick 2.15

import QtGraphicalEffects 1.15

Item {
    property alias harley_jeans: harley_jeans
    property alias harley_shirt: harley_shirt
    property alias left_boot: left_boot
    property alias right_boot: right_boot
    property alias hitbox: hitbox
    property alias harley_face: harley_face
    readonly property bool finished: false
    readonly property string name: "???"
    readonly property bool inRange: harley.inRange
    height: hitbox.height
    width: hitbox.width
    z: (way.height * 2 / 3 < y
        + hitbox.height) ? 3 : (way.height * 1 / 3 < y
                                + hitbox.height) ? 2 : (0 < y + hitbox.height) ? 1 : 0

    function keyJ() {
        return harley.prevState == 0 ? [punching2.running = true, harley.prevState
                                        = 1] : [punching1.running = true, harley.prevState = 0]
    }
    function keyD() {
        return harley.harleySideRot == 0 ? walking.running = true : sideChange.running = true
    }
    function keyS() {
        return harley.prevState == 0 ? [sitting.running = true, harley.prevState
                                        = 1] : [standup.running = true, harley.prevState = 0]
    }
    function keyA() {
        return harley.harleySideRot == -180 ? walking.running = true : sideChange.running = true
    }
    function keyF() {
        return !blinking.running ? standup.running = true : dying.running = true
    }
    function keyQ() {
        return !speaking.running ? speaking.running = true : speaking.running = false
    }
    function keyP() {
        whoIsTheBoss.running = true
    }
    function keyC() {
        smoking.running = true
    }
    Item {
        id: harley
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
        property double smokeRot: 0
        property int prevState: 0
        //    property double harleyRot: 0
        property double harleySideRot: 0
        property double harleyRot: 0
        readonly property bool inRange: ((mainHero.x + mainHero.hitbox.width
                                          >= parent.x - parent.hitbox.width / 2)
                                         && (mainHero.x <= parent.x + parent.hitbox.width * 1.5))
                                        && mainHero.z == parent.z

        //        scale: pageLoader.height / 1080 * 0.25
        x: hitbox.width / 2
        y: -hitbox.height * 0.055
        scale: pageLoader.height / 1080 * 0.25
        transformOrigin: Item.Bottom

        //        layer.enabled: true
        //        layer.sourceRect: childrenRect
        transform: [
            Rotation {
                origin.x: harley.width / 2
                origin.y: harley.height
                axis {
                    x: 0
                    y: 1
                    z: 0
                }
                angle: harley.harleySideRot
            },
            Rotation {
                origin.x: mainHero.width / 2
                origin.y: mainHero.height
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: harley.harleyRot
            }
            //        Rotation { origin.x: harley.width/2; origin.y: harley.height; axis { x: 0; y: 0; z: 1 } angle: harleyRot }
        ]

        SequentialAnimation {
            id: smoking
            loops: Animation.Infinite
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "slhu1AngleRot"
                    easing.bezierCurve: [0.428, 0.00516, 0.159, 0.987, 1, 1]
                    to: 45
                    duration: 500
                }
                PropertyAnimation {
                    target: harley
                    property: "slh1AngleRot"
                    easing.bezierCurve: [0.955, 0.00284, 0.787, 0.994, 1, 1]
                    to: 120
                    duration: 500
                }
                PropertyAction {
                    target: harley_left_hand1
                    property: "visible"
                    value: false
                }
                PropertyAction {
                    target: cigarette
                    property: "visible"
                    value: true
                }
                PropertyAction {
                    target: harley_left_hand_upper1
                    property: "z"
                    value: harley_left_hand_upper.z + 1
                }
                PropertyAction {
                    target: harley_left_hand_upper21
                    property: "z"
                    value: harley_left_hand_upper.z + 2
                }
            }
            PropertyAction {
                target: harley_speak2
                property: "visible"
                value: true
            }
            PropertyAction {
                target: cigarette
                property: "source"
                value: "Harley/Cigarette2.png"
            }
            ScriptAction {
                script: cigaretteSmoke.running = true
            }
            SequentialAnimation {

                PauseAnimation {
                    duration: 2500
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: harley
                        property: "slhu1AngleRot"
                        //                easing.bezierCurve: [0.428, 0.00516, 0.159, 0.987, 1, 1]
                        to: 30
                        duration: 250
                    }
                    PropertyAnimation {
                        target: harley
                        property: "slh1AngleRot"
                        easing.bezierCurve: [0.955, 0.00284, 0.787, 0.994, 1, 1]
                        to: 75
                        duration: 350
                    }
                }
            }

            PauseAnimation {
                duration: 3000
            }
        }

        SequentialAnimation {
            id: cigaretteSmoke
            loops: Animation.Infinite
            ParallelAnimation {
                PropertyAnimation {
                    target: smoke
                    property: "opacity"
                    to: 1
                    duration: 200
                }
                PropertyAnimation {
                    target: harley
                    property: "smokeRot"
                    to: 180
                    duration: 2000
                }
                PropertyAnimation {
                    target: smoke.anchors
                    property: "bottomMargin"
                    to: 300
                    duration: 2000
                }
                SequentialAnimation {

                    PauseAnimation {
                        duration: 1800
                    }
                    PropertyAnimation {
                        target: smoke
                        property: "opacity"
                        to: 0
                        duration: 200
                    }
                }
            }
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
                    target: harley_pupils
                    property: "height"
                    to: 10
                    duration: 150
                }
                //            PropertyAnimation { target: harley_pupils; property: "anchors.bottomMargin"; to: 180; duration: 150}
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: harley_pupils
                    property: "height"
                    to: 30
                    duration: 150
                }
                //            PropertyAnimation { target: harley_pupils; property: "anchors.bottomMargin"; to: 170; duration: 150}
            }
        }

        SequentialAnimation {
            id: walking
            running: false
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "slu1AngleRot"
                    to: -30
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
                    property: "sl1AngleRot"
                    to: 45
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
                    property: "slhuAngleRot"
                    to: -2
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
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
                                target: harley
                                property: "slu1AngleRot"
                                to: harley.slu1AngleRotDef
                                duration: 250
                            }
                            PropertyAnimation {
                                target: harley
                                property: "sl1AngleRot"
                                to: harley.sl1AngleRotDef
                                duration: 250
                            }
                            PropertyAnimation {
                                target: harley
                                property: "slhuAngleRot"
                                to: harley.slhuAngleRotDef
                                duration: 250
                            }
                            PropertyAnimation {
                                target: harley
                                property: "slhAngleRot"
                                to: harley.slhAngleRotDef
                                duration: 250
                            }
                            PropertyAnimation {
                                target: harley
                                property: "sfAngleRot"
                                to: 2
                                duration: 250
                            }
                        }
                        SequentialAnimation {
                            ParallelAnimation {
                                PropertyAnimation {
                                    target: harley
                                    property: "sluAngleRot"
                                    to: -30
                                    duration: 250
                                }
                                PropertyAnimation {
                                    target: harley
                                    property: "slAngleRot"
                                    to: 45
                                    duration: 250
                                }
                                PropertyAnimation {
                                    target: harley
                                    property: "slhu1AngleRot"
                                    to: 2
                                    duration: 250
                                }
                                PropertyAnimation {
                                    target: harley
                                    property: "slh1AngleRot"
                                    to: 2
                                    duration: 250
                                }
                            }
                            ParallelAnimation {
                                PropertyAnimation {
                                    target: harley
                                    property: "sluAngleRot"
                                    to: harley.slu1AngleRotDef
                                    duration: 250
                                }
                                PropertyAnimation {
                                    target: harley
                                    property: "slAngleRot"
                                    to: harley.slAngleRotDef
                                    duration: 250
                                }
                                PropertyAnimation {
                                    target: harley
                                    property: "slhu1AngleRot"
                                    to: harley.slhu1AngleRotDef
                                    duration: 250
                                }
                                PropertyAnimation {
                                    target: harley
                                    property: "slh1AngleRot"
                                    to: harley.slh1AngleRotDef
                                    duration: 250
                                }
                                PropertyAnimation {
                                    target: harley
                                    property: "sfAngleRot"
                                    to: harley.sfAngleRotDef
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
                target: harley
                property: "slhAngleRot"
                to: -30
                duration: 150
            }
            PropertyAction {
                target: harley_left_hand
                property: "visible"
                value: false
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "slhuAngleRot"
                    to: -30
                    duration: 150
                    easing.type: Easing.InExpo
                }
                PropertyAnimation {
                    target: harley
                    property: "slhAngleRot"
                    to: -35
                    duration: 150
                    easing.type: Easing.InExpo
                }
                PropertyAnimation {
                    target: harley
                    property: "sfAngleRot"
                    to: 2
                    duration: 150
                }
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "sfAngleRot"
                    to: harley.sfAngleRotDef
                    duration: 150
                }
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "slhuAngleRot"
                    to: harley.slhuAngleRotDef
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
                    property: "slhAngleRot"
                    to: harley.slhAngleRotDef
                    duration: 250
                }
                SequentialAnimation {
                    PauseAnimation {
                        duration: 100
                    }
                    PropertyAction {
                        target: harley_left_hand
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
                target: harley
                property: "slh1AngleRot"
                to: -30
                duration: 150
            }
            PropertyAction {
                target: harley_left_hand1
                property: "visible"
                value: false
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "slhu1AngleRot"
                    to: -20
                    duration: 150
                }
                PropertyAnimation {
                    target: harley
                    property: "slh1AngleRot"
                    to: -155
                    duration: 150
                    easing.type: Easing.InExpo
                }
                PropertyAnimation {
                    target: harley
                    property: "sfAngleRot"
                    to: 2
                    duration: 150
                }
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "sfAngleRot"
                    to: harley.sfAngleRotDef
                    duration: 150
                }
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "slhu1AngleRot"
                    to: harley.slhu1AngleRotDef
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
                    property: "slh1AngleRot"
                    to: harley.slh1AngleRotDef
                    duration: 250
                }
                SequentialAnimation {
                    PauseAnimation {
                        duration: 100
                    }
                    PropertyAction {
                        target: harley_left_hand1
                        property: "visible"
                        value: true
                    }
                }
            }
        }

        SequentialAnimation {
            id: sitting
            running: false
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "slh1AngleRot"
                    to: 10
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
                    property: "slhAngleRot"
                    to: -10
                    duration: 250
                }
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "sluAngleRot"
                    to: -65
                    duration: 300
                }
                PropertyAnimation {
                    target: harley
                    property: "slAngleRot"
                    to: 45
                    duration: 300
                }

                PropertyAnimation {
                    target: harley
                    property: "slu1AngleRot"
                    to: -65
                    duration: 300
                }
                PropertyAnimation {
                    target: harley
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
                    target: harley_pupils
                    property: "height"
                    to: 30
                    duration: 150
                }
                PropertyAnimation {
                    target: harley
                    property: "slh1AngleRot"
                    to: harley.slh1AngleRotDef
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
                    property: "slhAngleRot"
                    to: harley.slhAngleRotDef
                    duration: 250
                }
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "sluAngleRot"
                    to: harley.sluAngleRotDef
                    duration: 300
                }
                PropertyAnimation {
                    target: harley
                    property: "slAngleRot"
                    to: harley.slAngleRotDef
                    duration: 300
                }

                PropertyAnimation {
                    target: harley
                    property: "slu1AngleRot"
                    to: harley.slu1AngleRotDef
                    duration: 300
                }
                PropertyAnimation {
                    target: harley
                    property: "sl1AngleRot"
                    to: harley.sl1AngleRotDef
                    duration: 300
                }

                PropertyAnimation {
                    target: harley
                    property: "slhu1AngleRot"
                    to: harley.slhu1AngleRotDef
                    duration: 300
                }
                PropertyAnimation {
                    target: harley
                    property: "slh1AngleRot"
                    to: harley.slh1AngleRotDef
                    duration: 300
                }
                PropertyAnimation {
                    target: harley
                    property: "slhuAngleRot"
                    to: harley.slhuAngleRotDef
                    duration: 300
                }
                PropertyAnimation {
                    target: harley
                    property: "slhAngleRot"
                    to: harley.slhAngleRotDef
                    duration: 300
                }
                PropertyAnimation {
                    target: harley
                    property: "sfAngleRot"
                    to: harley.sfAngleRotDef
                    duration: 300
                }

                //            PropertyAnimation {target: harley; property: "harleyRot"; to: 0; duration: 300}

                //                PropertyAnimation { target: harley_nude_body; property: "y"; to: 297; duration: 300; easing.type: Easing.OutCubic}
                ScriptAction {
                    script: blinking.running = true
                }
            }

            //            PauseAnimation {duration: 100}
            //            ScriptAction {script: [picture.rotY = 1, picture.rotZ = 0]}
        }

        SequentialAnimation {
            id: sideChange
            running: false
            PropertyAnimation {
                target: harley
                property: "harleySideRot"
                to: harley.harleySideRot === 0 ? -180 : 0
                duration: 500
            }
        }

        SequentialAnimation {
            id: dying
            running: false
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "slhuAngleRot"
                    to: -10
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
                    property: "slhAngleRot"
                    to: -65
                    duration: 250
                }

                PropertyAnimation {
                    target: harley
                    property: "slhu1AngleRot"
                    to: 10
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
                    property: "slh1AngleRot"
                    to: 65
                    duration: 250
                }

                PropertyAnimation {
                    target: harley_pupils
                    property: "height"
                    to: 10
                    duration: 150
                }
                PropertyAnimation {
                    target: harley_pupils
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
                    target: harley
                    property: "sfAngleRot"
                    to: 10
                    duration: 150
                }
            }
            ParallelAnimation {

                //            PropertyAnimation {target: harley; property: "harleyRot"; to: -90; duration: 250}
                PropertyAnimation {
                    target: harley
                    property: "sluAngleRot"
                    to: -15
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
                    property: "slAngleRot"
                    to: 30
                    duration: 250
                }

                PropertyAnimation {
                    target: harley
                    property: "slu1AngleRot"
                    to: -15
                    duration: 250
                }
                PropertyAnimation {
                    target: harley
                    property: "sl1AngleRot"
                    to: 30
                    duration: 250
                }
            }
            //            PauseAnimation {duration: 100}
            //            ScriptAction {script: [picture.rotY = 1, picture.rotZ = 0]}
        }

        SequentialAnimation {
            id: speaking
            alwaysRunToEnd: true
            loops: Animation.Infinite
            running: (((_dialogue.item.visible === true
                        && name === levelText[_dialogue.item.indexId * 2])
                       || (_dialogue.visible === true
                           && name === levelText[_dialogue.indexId * 2]))) ? true : false
            //        running: (((_dialogue.item.visible===true && name===levelText[_dialogue.item.indexId*2]) || (_dialogue.visible===true && name===levelText[_dialogue.indexId*2])))?true:false
            PropertyAction {
                target: harley_speak
                property: "visible"
                value: true
            }
            PauseAnimation {
                duration: 200
            }
            ParallelAnimation {
                PropertyAction {
                    target: harley_speak
                    property: "visible"
                    value: false
                }
                PropertyAction {
                    target: harley_speak2
                    property: "visible"
                    value: true
                }
            }
            PauseAnimation {
                duration: 200
            }
            PropertyAction {
                target: harley_speak2
                property: "visible"
                value: false
            }
        }
        SequentialAnimation {
            id: whoIsTheBoss
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "slhuAngleRot"
                    to: -30
                    duration: 350
                }
                PropertyAnimation {
                    target: harley
                    property: "slhAngleRot"
                    to: 0
                    duration: 350
                }
            }
            PropertyAction {
                target: harley_left_hand
                property: "visible"
                value: false
            }
            PropertyAnimation {
                target: harley
                property: "slhAngleRot"
                to: -10
                duration: 300
            }
            PropertyAction {
                target: harley_left_hand
                property: "visible"
                value: true
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: harley
                    property: "slhuAngleRot"
                    to: 0
                    duration: 450
                }
                PropertyAnimation {
                    target: harley
                    property: "slhAngleRot"
                    to: 15
                    duration: 450
                }
            }
            ParallelAnimation {
                ParallelAnimation {
                    PropertyAnimation {
                        target: harley
                        property: "slhuAngleRot"
                        to: -30
                        duration: 350
                    }
                    PropertyAnimation {
                        target: harley
                        property: "slhAngleRot"
                        to: -45
                        duration: 350
                    }
                    SequentialAnimation {
                        PauseAnimation {
                            duration: 200
                        }
                        PropertyAction {
                            target: harley_left_hand
                            property: "visible"
                            value: false
                        }
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: harley
                        property: "slhu1AngleRot"
                        to: -10
                        duration: 350
                    }
                    PropertyAnimation {
                        target: harley
                        property: "slh1AngleRot"
                        to: -135
                        duration: 350
                    }
                    SequentialAnimation {
                        PauseAnimation {
                            duration: 200
                        }
                        PropertyAction {
                            target: harley_left_hand1
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
                        target: harley
                        property: "slhuAngleRot"
                        to: harley.slhuAngleRotDef
                        duration: 300
                    }
                    PropertyAnimation {
                        target: harley
                        property: "slhAngleRot"
                        to: harley.slhAngleRotDef
                        duration: 300
                    }
                    SequentialAnimation {
                        PauseAnimation {
                            duration: 150
                        }
                        PropertyAction {
                            target: harley_left_hand
                            property: "visible"
                            value: true
                        }
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: harley
                        property: "slhu1AngleRot"
                        to: harley.slhu1AngleRotDef
                        duration: 300
                    }
                    PropertyAnimation {
                        target: harley
                        property: "slh1AngleRot"
                        to: harley.slh1AngleRotDef
                        duration: 300
                    }
                    SequentialAnimation {
                        PauseAnimation {
                            duration: 150
                        }
                        PropertyAction {
                            target: harley_left_hand1
                            property: "visible"
                            value: true
                        }
                    }
                }
            }
        }

        Image {
            id: harley_nude_body
            y: 297
            anchors.horizontalCenter: parent.horizontalCenter
            source: "Harley/Harley_nude_body.png"
            fillMode: Image.PreserveAspectFit

            Image {
                id: harley_face
                x: 30
                y: -205
                anchors.bottom: harley_nude_body.top
                anchors.bottomMargin: -135
                anchors.left: harley_nude_body.left
                anchors.leftMargin: 30
                source: "Harley/Harley_face.png"
                transformOrigin: Item.Bottom
                fillMode: Image.PreserveAspectFit
                transform: Rotation {
                    origin.x: harley_face.width / 2
                    origin.y: harley_face.height * 0.60
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: harley.sfAngleRot
                }

                Image {
                    id: harley_pupils
                    height: 30
                    anchors.verticalCenter: harley_face.verticalCenter
                    anchors.verticalCenterOffset: -harley_face.height * 0.025
                    x: harley_face.width * 0.41
                    width: 120
                    source: "Harley/Harley_pupils.png"
                    transformOrigin: Item.Center
                }
                Image {
                    id: harley_mouth
                    x: 133
                    y: 274
                    source: "Harley/Harley_mouth.png"
                    fillMode: Image.PreserveAspectFit
                    visible: (!harley_speak.visible && !harley_speak2.visible)
                }

                Image {
                    id: harley_speak
                    x: 133
                    y: 274
                    source: "Harley/Harley_speak.png"
                    fillMode: Image.PreserveAspectFit
                    visible: false
                }

                Image {
                    id: harley_speak2
                    x: 145
                    y: 274
                    source: "Harley/Harley_speak2.png"
                    fillMode: Image.PreserveAspectFit
                    visible: false
                }
            }
        }

        Image {
            id: harley_jeans
            x: 325
            y: 1041
            width: 450
            height: 180
            anchors.left: harley_shorts.left
            anchors.bottom: harley_shorts.bottom
            source: "Harley/Harley_jeans.png"
            //        anchors.bottomMargin: 0
            anchors.leftMargin: -10
            fillMode: Image.Stretch
        }

        Image {
            id: harley_leg_upper1
            x: 345
            y: 1021
            anchors.right: harley_belt.right
            anchors.top: harley_belt.bottom
            anchors.rightMargin: 12
            anchors.topMargin: -9
            source: "Harley/Harley_leg_upper.png"
            transform: Rotation {
                origin.x: harley_leg_upper1.width / 2
                origin.y: harley_leg_upper1.height * 0.1
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: harley.slu1AngleRot
            }

            Image {
                id: harley_leg1
                x: 44
                y: 422
                source: "Harley/Harley_leg.png"
                z: harley_leg_upper1.z + 1
                transform: Rotation {
                    origin.x: harley_leg1.width / 3
                    origin.y: harley_leg1.height * 0.05
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: harley.sl1AngleRot
                }
                Image {
                    id: right_boot
                    source: "Harley/Harley_boot.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                }
            }
        }

        Image {
            id: harley_leg_upper21
            //        x: 329
            //        y: 996
            anchors.left: harley_leg_upper1.left
            anchors.top: harley_leg_upper1.top
            anchors.right: harley_leg_upper1.right
            anchors.topMargin: -25
            anchors.rightMargin: -16
            anchors.leftMargin: -5
            source: "Harley/Harley_leg_upper2.png"
            mirror: false
            visible: harley_jeans.visible
            transform: Rotation {
                origin.x: harley_leg_upper.width / 1.75
                origin.y: harley_leg_upper.height * 0.165
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: harley.slu1AngleRot
            }
        }

        Image {
            id: harley_leg_upper
            x: 121
            y: 1021
            anchors.left: harley_belt.left
            anchors.top: harley_belt.bottom
            anchors.topMargin: -9
            anchors.leftMargin: 12
            source: "Harley/Harley_leg_upper.png"
            transform: Rotation {
                origin.x: harley_leg_upper.width / 2
                origin.y: harley_leg_upper.height * 0.1
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: harley.sluAngleRot
            }

            Image {
                id: harley_leg
                x: 44
                y: 422
                source: "Harley/Harley_leg.png"
                z: harley_leg_upper.z + 1
                transform: Rotation {
                    origin.x: harley_leg.width / 3
                    origin.y: harley_leg.height * 0.05
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: harley.slAngleRot
                }

                Image {
                    id: left_boot
                    source: "Harley/Harley_boot.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                }
            }
        }

        Image {
            id: harley_leg_upper2
            //        x: 101
            //        y: 996
            anchors.left: harley_leg_upper.left
            anchors.top: harley_leg_upper.top
            anchors.topMargin: -25
            anchors.right: harley_leg_upper.right
            anchors.leftMargin: -16
            anchors.rightMargin: -5
            source: "Harley/Harley_leg_upper2.png"
            visible: harley_jeans.visible
            transform: [
                Rotation {
                    origin.x: harley_leg_upper.width / 1.65
                    origin.y: harley_leg_upper.height * 0.155
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: harley.sluAngleRot
                }
            ]
        }

        Image {
            id: harley_shorts
            anchors.horizontalCenter: harley_nude_body.horizontalCenter
            anchors.top: harley_nude_body.bottom
            anchors.topMargin: -height / 3.5
            source: "Harley/Harley_shorts.png"
            fillMode: Image.PreserveAspectFit
            visible: !harley_jeans.visible
        }

        Image {
            id: harley_right_shoulder
            x: 409
            y: 419
            //            y: 135
            anchors.left: harley_nude_body.right
            anchors.top: harley_nude_body.top
            anchors.topMargin: 122
            anchors.leftMargin: -110
            source: "../MainHero/Semen/Semen_right_shoulder.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: harley_left_shoulder
            x: -19
            y: 415
            //            y: 135
            anchors.right: harley_nude_body.left
            anchors.top: harley_nude_body.top
            anchors.topMargin: 118
            anchors.rightMargin: -60
            source: "Harley/Harley_left_shoulder.png"
            fillMode: Image.PreserveAspectCrop
        }

        Image {
            id: harley_shirt
            anchors.horizontalCenter: harley_nude_body.horizontalCenter
            anchors.verticalCenter: harley_nude_body.verticalCenter
            anchors.verticalCenterOffset: 60
            anchors.horizontalCenterOffset: -34
            source: "Harley/Harley_shirt.png"
            fillMode: Image.PreserveAspectFit
            //        visible: false
        }

        Image {
            id: harley_belt
            x: 105
            y: 988
            anchors.left: harley_shorts.left
            anchors.top: harley_nude_body.bottom
            anchors.topMargin: -20
            source: "Harley/Harley_belt.png"
            fillMode: Image.PreserveAspectFit
            visible: harley_jeans.visible
        }

        Image {
            id: harley_left_hand_upper1
            //        x: 484
            anchors.right: harley_right_shoulder.right
            anchors.rightMargin: -37
            y: 419
            source: "Harley/Harley_left_hand_upper.png"
            mirror: true
            fillMode: Image.PreserveAspectFit
            transform: Rotation {
                origin.x: harley_left_hand_upper1.width / 2
                origin.y: harley_left_hand_upper1.height * 0.1
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: harley.slhu1AngleRot
            }

            //            z: harley_right_shoulder.z - 2
            Image {
                id: harley_left_hand1
                x: -67
                y: 402
                source: "Harley/Harley_left_hand.png"
                mirror: true
                fillMode: Image.PreserveAspectFit
                //                z: harley_shirt.z+1
                transform: Rotation {
                    origin.x: harley_left_hand1.width * 0.8
                    //                origin.y: harley_left_hand1.height * 0
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: harley.slh1AngleRot
                }
            }

            Image {
                id: harley_left_hand21
                //                    x: -112
                //                    y: 401
                anchors.fill: harley_left_hand1
                source: "Harley/Harley_left_hand2.png"
                mirror: true
                fillMode: Image.PreserveAspectFit
                //                z: harley_left_hand1.z
                visible: !harley_left_hand1.visible
                transform: Rotation {
                    origin.x: harley_left_hand1.width * 0.8
                    //                origin.y: harley_left_hand1.height * 0
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: harley.slh1AngleRot
                }
                Image {
                    id: cigarette
                    x: -74
                    y: 307
                    source: "Harley/Cigarette.png"
                    rotation: -161.104
                    scale: 0.7
                    fillMode: Image.PreserveAspectFit
                    visible: false
                    Image {
                        id: smoke
                        source: "Harley/Smoke.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.right: cigarette.right
                        //                    rotation: -cigarette.rotation
                        opacity: 0
                        anchors.bottom: cigarette.top
                        transform: [
                            Rotation {
                                origin.x: smoke.width / 2
                                origin.y: smoke.height / 2
                                angle: harley.smokeRot
                                axis {
                                    x: 0
                                    y: 1
                                    z: 0
                                }
                            }
                        ]
                    }
                }
            }
        }

        Image {
            id: harley_left_hand_upper
            //        x: -37
            anchors.left: harley_left_shoulder.left
            anchors.leftMargin: -20
            //        anchors.leftMargin: 30
            y: 427
            source: "Harley/Harley_left_hand_upper.png"
            //            z: harley_left_shoulder.z - 2
            fillMode: Image.PreserveAspectFit
            transform: Rotation {
                origin.x: harley_left_hand_upper.width / 2
                origin.y: harley_left_hand_upper.height * 0.1
                axis {
                    x: 0
                    y: 0
                    z: 1
                }
                angle: harley.slhuAngleRot
            }

            Image {
                id: harley_left_hand
                x: 27
                y: 378
                source: "Harley/Harley_left_hand.png"
                rotation: 0
                fillMode: Image.PreserveAspectFit
                transform: Rotation {
                    origin.x: harley_left_hand.width * 0.1
                    origin.y: harley_left_hand.height * 0.1
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: harley.slhAngleRot
                }
            }

            Image {
                id: harley_left_hand2
                anchors.fill: harley_left_hand
                source: "Harley/Harley_left_hand2.png"
                fillMode: Image.PreserveAspectFit
                //                z: harley_left_hand.z
                visible: !harley_left_hand.visible
                transform: Rotation {
                    origin.x: harley_left_hand.width * 0.1
                    origin.y: harley_left_hand.height * 0.1
                    axis {
                        x: 0
                        y: 0
                        z: 1
                    }
                    angle: harley.slhAngleRot
                }
            }
        }

        Image {
            id: harley_left_hand_upper21
            anchors.verticalCenter: harley_right_shoulder.verticalCenter
            anchors.horizontalCenter: harley_right_shoulder.horizontalCenter
            anchors.horizontalCenterOffset: 54
            anchors.verticalCenterOffset: 10
            visible: harley_shirt.visible
            source: "Harley/Harley_left_hand_upper2.png"
            fillMode: Image.PreserveAspectFit
            transform: [
                Rotation {
                    axis.y: 0
                    origin.x: harley_left_hand_upper21.width / 2
                    angle: harley.slhu1AngleRot
                    origin.y: harley_left_hand_upper21.height * 0.2
                    axis.z: 1
                    axis.x: 0
                }
            ]
            mirror: true
            rotation: -1
        }

        Image {
            id: harley_left_hand_upper2
            anchors.verticalCenter: harley_left_shoulder.verticalCenter
            anchors.horizontalCenter: harley_left_shoulder.horizontalCenter
            anchors.horizontalCenterOffset: -45
            anchors.verticalCenterOffset: 10
            visible: harley_shirt.visible
            source: "Harley/Harley_left_hand_upper2.png"
            fillMode: Image.PreserveAspectFit
            transform: [
                Rotation {
                    axis.y: 0
                    origin.x: harley_left_hand_upper2.width / 2
                    angle: harley.slhuAngleRot
                    origin.y: harley_left_hand_upper2.height * 0.25
                    axis.z: 1
                    axis.x: 0
                }
            ]
        }
    }
    Rectangle {
        id: hitbox
        height: harley.childrenRect.height * 0.59 * harley.scale / 0.4
        width: harley.childrenRect.width * 0.7 * harley.scale / 0.4
        border.width: saver.settingsSave.hitboxVisible === true ? 2 : 0
        border.color: "black"
        color: "transparent"
        anchors.centerIn: harley.Center
    }

    Glow {
        anchors.fill: hitbox
        radius: 8
        samples: 17
        color: harley.inRange ? "white" : "transparent"
        source: hitbox
    }
    //    Glow {
    //        id: glow
    //        radius: (harley.inRange && levelFinished === finished
    //                 && mainHero.state !== "use"
    //                 && levelName.state !== "dialogue") ? 4 : 0
    //        spread: (harley.inRange && levelFinished === finished
    //                 && mainHero.state !== "use"
    //                 && levelName.state !== "dialogue") ? 0.6 : 0
    //        visible: _dialogue.item.indexId
    //                 === 11 ? (harley.inRange && levelFinished === finished
    //                           && mainHero.state !== "use"
    //                           && levelName.state !== "dialogue") ? true : false : false
    //        onVisibleChanged: {
    //            typeof (buttonIcon) !== 'undefined' ? [buttonIcon.visible
    //                                                   = visible, buttonIcon.text = "E"] : {}
    //            harley.inRange
    //                    && mainHero.state == "use" ? [_dialogue.item.visible
    //                                                  = true, _dialogue.item.enabled = true] : {}
    //        }
    //        source: hitbox
    //        anchors.fill: hitbox
    //        //        scale: interact.scaling
    //    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.33;height:1920;width:1080}
}
##^##*/

