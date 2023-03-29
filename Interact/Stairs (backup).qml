import QtQuick 2.0

Item {

    Component.onCompleted: {
        picture.mirror = interact.type === "stairs left" ? true : false
        picture.source = interact.type === "stairs left" ? "../Level1/Objects/Stairs1.png" : "../Level1/Objects/Stairs2.png"
        inRange = Qt.binding(function () {
            return (interact.type === "stairs left") ? ((((mainHero.x + mainHero.hitbox.width / 2 >= picture.paintedWidth * 0.7 + interact.x) && (mainHero.x + mainHero.hitbox.width / 2 <= picture.paintedWidth + interact.x)) && ((mainHero.y + mainHero.hitbox.height + way.y <= interact.y + picture.paintedHeight * 0.08) && (mainHero.y + mainHero.hitbox.height + way.y >= interact.y))) || (((mainHero.x + mainHero.hitbox.width / 2 <= picture.paintedWidth * 0.15 + interact.x) && (mainHero.x + mainHero.hitbox.width / 2 >= interact.x)) && ((mainHero.y + mainHero.hitbox.height + way.y >= interact.y + picture.paintedHeight * 0.92) && (mainHero.y + mainHero.hitbox.height + way.y <= interact.y + picture.paintedHeight)))) : //stairs right
                                                       ((((mainHero.x + mainHero.hitbox.width / 2 >= picture.paintedWidth * 0.7 + interact.x) && (mainHero.x + mainHero.hitbox.width / 2 <= picture.paintedWidth + interact.x)) && ((mainHero.y + mainHero.hitbox.height + way.y >= interact.y + picture.paintedHeight * 0.92) && (mainHero.y + mainHero.hitbox.height + way.y <= interact.y + picture.paintedHeight))) || (((mainHero.x + mainHero.hitbox.width / 2 > picture.paintedWidth * 0.15 + interact.x) && (mainHero.x + mainHero.hitbox.width / 2 <= picture.paintedWidth * 0.3 + interact.x)) && ((mainHero.y + mainHero.hitbox.height + way.y <= interact.y + picture.paintedHeight * 0.08) && (mainHero.y + mainHero.hitbox.height + way.y >= interact.y))))
        })
    }

    //    SequentialAnimation {
    //        PropertyAction { target: picture; property: "mirror"; value: interact.type==="stairs left"?true:false}
    //        PropertyAction { target: picture; property: "source"; value: interact.type==="stairs left"?"../Level1/Objects/Stairs1.png":"../Level1/Objects/Stairs2.png"}
    //    }
    //STAIRS
    SequentialAnimation {
        //to left down
        alwaysRunToEnd: true
        running: ((((mainHero.x + mainHero.hitbox.width / 2 >= picture.paintedWidth * 0.7
                     + interact.x) && (mainHero.x + mainHero.hitbox.width / 2
                                       <= picture.paintedWidth + interact.x))
                   && ((mainHero.y + mainHero.hitbox.height
                        + way.y <= interact.y + picture.paintedHeight * 0.08)
                       && (mainHero.y + mainHero.hitbox.height + way.y >= interact.y)))
                  && interact.type === "stairs left"
                  && mainHero.state === "use") ? true : false
        ScriptAction {
            script: {
                levelName.state = "dialogue"
                if (mainHero.semenSideRot == 0) {
                    mainHero.sideChange.running = true
                }
                image_front.opacity = 0.3
                mainHero.x = picture.paintedWidth * 0.85 + interact.x - mainHero.hitbox.width / 2
                mainHero.y = interact.y - mainHero.hitbox.height - way.y
                        + picture.paintedHeight * 0.08
            }
        }
        PauseAnimation {
            duration: 320
        }
        SequentialAnimation {
            loops: ((picture.paintedHeight + pageLoader.height) / 4 / mainHero.moveV)
            ScriptAction {
                script: {
                    mainHero.x -= mainHero.moveH /*mainHero*/
                    //                    mainHero.y += mainHero.moveV * 1.7
                    way.y += mainHero.moveV * 1.7
                    levelName.y -= mainHero.moveV * 1.7
                }
            }
            PauseAnimation {
                duration: 320
            }
        }
        ScriptAction {
            script: {
                image_front.opacity = 1
            }
        }
        PropertyAction {
            target: way
            property: "y"
            value: 0.78 * pageLoader.height - way.height + (3 - 2) * (levelName.height / 1.44)
        }
        //        PauseAnimation {
        //            duration: 50
        //        }
        //        PropertyAction {
        //            target: mainHero
        //            property: "y"
        //            value: -mainHero.height + way.height / 2
        //        }
        PauseAnimation {
            duration: 200
        }
        ScriptAction {
            script: {
                levelName.state = Qt.binding(function () {
                    return subMenu.item.opacity > 0 ? "stopGame" : _dialogue.item.visible
                                                      === true ? "dialogue" : ""
                })
                saver.localSave.floor--
            }
        }
    }

    SequentialAnimation {
        //to right up
        alwaysRunToEnd: true
        running: ((((mainHero.x + mainHero.hitbox.width / 2 <= picture.paintedWidth * 0.15
                     + interact.x) && (mainHero.x + mainHero.hitbox.width / 2
                                       >= interact.x)) && ((mainHero.y + mainHero.hitbox.height + way.y >= interact.y + picture.paintedHeight * 0.92) && (mainHero.y + mainHero.hitbox.height + way.y <= interact.y + picture.paintedHeight)))
                  && interact.type === "stairs left"
                  && mainHero.state === "use") ? true : false
        ScriptAction {
            script: {
                levelName.state = "dialogue"
                if (mainHero.semenSideRot == -180) {
                    mainHero.sideChange.running = true
                }
                image_front.opacity = 0.3
                mainHero.x = picture.paintedWidth * 0.15 + interact.x - mainHero.hitbox.width / 2
                mainHero.y = interact.y + picture.paintedHeight * 0.92
                        - mainHero.hitbox.height - way.y
            }
        }
        PauseAnimation {
            duration: 320
        }
        SequentialAnimation {
            loops: ((picture.paintedHeight + pageLoader.height) / 4 / mainHero.moveV)
            ScriptAction {
                script: {
                    mainHero.x += mainHero.moveH /*mainHero*/
                    //                    mainHero.y -= mainHero.moveV * 1.6
                    way.y -= mainHero.moveV * 1.7
                    levelName.y += mainHero.moveV * 1.7
                }
            }
            PauseAnimation {
                duration: 320
            }
        }
        ScriptAction {
            script: {
                image_front.opacity = 1
            }
        }
        PropertyAction {
            target: way
            property: "y"
            value: 0.78 * pageLoader.height - way.height + (3 - 3) * (levelName.height / 1.44)
        }
        //        PauseAnimation {
        //            duration: 50
        //        }
        //        PropertyAction {
        //            target: mainHero
        //            property: "y"
        //            value: -mainHero.height + way.height / 2
        //        }
        PauseAnimation {
            duration: 200
        }
        ScriptAction {
            script: {
                levelName.state = Qt.binding(function () {
                    return subMenu.item.opacity > 0 ? "stopGame" : _dialogue.item.visible
                                                      === true ? "dialogue" : ""
                })
                saver.localSave.floor++
            }
        }
    }

    SequentialAnimation {
        //to left up
        alwaysRunToEnd: true
        running: ((((mainHero.x + mainHero.hitbox.width / 2 >= picture.paintedWidth * 0.7
                     + interact.x) && (mainHero.x + mainHero.hitbox.width / 2
                                       <= picture.paintedWidth + interact.x)) && ((mainHero.y + mainHero.hitbox.height + way.y >= interact.y + picture.paintedHeight * 0.92) && (mainHero.y + mainHero.hitbox.height + way.y <= interact.y + picture.paintedHeight))) && interact.type === "stairs right" && mainHero.state === "use") ? true : false
        ScriptAction {
            script: {
                levelName.state = "dialogue"
                if (mainHero.semenSideRot == 0) {
                    mainHero.sideChange.running = true
                }
                image_front.opacity = 0.3
                mainHero.x = picture.paintedWidth * 0.85 + interact.x - mainHero.hitbox.width / 2
                mainHero.y = interact.y + picture.paintedHeight * 0.92
                        - mainHero.hitbox.height - way.y
            }
        }
        PauseAnimation {
            duration: 320
        }
        SequentialAnimation {
            loops: ((picture.paintedHeight + pageLoader.height) / 4 / mainHero.moveV)
            ScriptAction {
                script: {
                    mainHero.x -= mainHero.moveH
                    //                    mainHero.y -= mainHero.moveV * 1.7
                    way.y -= mainHero.moveV * 1.7
                    levelName.y += mainHero.moveV * 1.7
                }
            }
            PauseAnimation {
                duration: 320
            }
        }
        ScriptAction {
            script: {
                image_front.opacity = 1
            }
        }
        PropertyAction {
            target: way
            property: "y"
            value: 0.78 * pageLoader.height - way.height + (3 - 2) * (levelName.height / 1.44)
        }
        //        PauseAnimation {
        //            duration: 50
        //        }
        //        PropertyAction {
        //            target: mainHero
        //            property: "y"
        //            value: -mainHero.height + way.height / 2
        //        }
        PauseAnimation {
            duration: 200
        }
        ScriptAction {
            script: {
                levelName.state = Qt.binding(function () {
                    return subMenu.item.opacity > 0 ? "stopGame" : _dialogue.item.visible
                                                      === true ? "dialogue" : ""
                })
                saver.localSave.floor++
            }
        }
    }
    SequentialAnimation {
        //to right down
        alwaysRunToEnd: true
        running: ((((mainHero.x + mainHero.hitbox.width / 2 > picture.paintedWidth * 0.15
                     + interact.x) && (mainHero.x + mainHero.hitbox.width / 2
                                       <= picture.paintedWidth * 0.3 + interact.x)) && ((mainHero.y + mainHero.hitbox.height + way.y <= interact.y + picture.paintedHeight * 0.08) && (mainHero.y + mainHero.hitbox.height + way.y >= interact.y))) && interact.type === "stairs right" && mainHero.state === "use") ? true : false
        ScriptAction {
            script: {
                levelName.state = "dialogue"
                if (mainHero.semenSideRot == -180) {
                    mainHero.sideChange.running = true
                }
                image_front.opacity = 0.3
                mainHero.x = picture.paintedWidth * 0.15 + interact.x - mainHero.hitbox.width / 2
                mainHero.y = interact.y + picture.paintedHeight * 0.08
                        - mainHero.hitbox.height - way.y
            }
        }
        PauseAnimation {
            duration: 320
        }
        SequentialAnimation {
            loops: ((picture.paintedHeight + pageLoader.height) / 4 / mainHero.moveV)
            ScriptAction {
                script: {
                    mainHero.x += mainHero.moveH /*mainHero*/
                    //                    mainHero.y += mainHero.moveV * 1.6
                    way.y += mainHero.moveV * 1.7
                    levelName.y -= mainHero.moveV * 1.7
                }
            }
            PauseAnimation {
                duration: 320
            }
        }
        ScriptAction {
            script: {
                image_front.opacity = 1
            }
        }
        PropertyAction {
            target: way
            property: "y"
            value: 0.78 * pageLoader.height - way.height + (3 - 1) * (levelName.height / 1.44)
        }
        //        PauseAnimation {
        //            duration: 50
        //        }
        //        PropertyAction {
        //            target: mainHero
        //            property: "y"
        //            value: -mainHero.height + way.height / 2
        //        }
        PauseAnimation {
            duration: 200
        }
        ScriptAction {
            script: {
                levelName.state = Qt.binding(function () {
                    return subMenu.item.opacity > 0 ? "stopGame" : _dialogue.item.visible
                                                      === true ? "dialogue" : ""
                })
                saver.localSave.floor--
            }
        }
    }
}
