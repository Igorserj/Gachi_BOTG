import QtQuick 2.15

Item {
    Loader {
        id: loader
        sourceComponent: typeof (type2) !== 'undefined' ? type2 == "intro" ? saver.localSave.level1Finished[0] ? introLevel12 : introLevel1 : undefined : undefined
    }
    Component {
        id: introLevel1
        Item {
            Component.onCompleted: {
                //        pos1 = [0, -mainHero.hitbox.height+way.height/2]
                //        pos2 = [way.width-mainHero.hitbox.width, -mainHero.hitbox.height+way.height/2]
                //        pos3 = [bench.x, parent.height/2-mainHero.picture.paintedHeight+bench.height*0.9]
                //        pos4 = [0, -(_hostile.itemAt(0).hitbox.height)]
                levelName.state = Qt.binding(function () {
                    return subMenu.item.opacity === 1 ? "stopGame" : "dialogue"
                })
                name1 = mainHero.name
                _dialogue.item.indexId = 0
                //        _dialogue.item.onIndexIdChanged = Qt.binding(function() {return indexId===2?[mainHero.picture.source=semen.imageSource]:indexId===3?mainHero.x=bench.x+90*main.width/1280:indexId===10?dialogueAnimation.running=true:{}})
                mainHero.state = "sit"
                _hostile.itemAt(0).state = "sit"
                _hostile.itemAt(0).state = "idle"

                _hostile.itemAt(0).name = Qt.binding(function () {
                    return _dialogue.item.indexId < 4 ? "???" : "Шкіряний чоловік"
                })
                name2 = Qt.binding(function () {
                    return _hostile.itemAt(0).name
                })

                levelText = Qt.binding(function () {
                    return [name1, "Гей, друже, гадаю, ти помилився дверима. Шкіряний клуб двома поверхами нижче", name2, "Іди нахуй", name1, "Гаа, нахуй тебе, Шкіряний чоловіче", name1, "Я гадаю, нам потрібно вирішити це питання прямо тут, якщо ти вважаєш себе таким крутим", name2, "Та я ж надеру тобі дупу", name1, "Ха, дійсно? Ну давай тоді знімай свої шкіряні іграшки, і я зніму своє лахміття, і ми вирішимо тут на ринзі, згоден?", name2, "Авжеж, начувайся!", name1, "Ну от і добре. А тепер знімай своє кляте вбрання", name2, "Ага, розумна срако", name1, "Я покажу тобі, хто бос цієї качалки", name2, "Тепер ти офіційно в моєму рабстві. Я тут поруч залишу візитівку", name2, "О, і це мені знадобиться, у якості подяки від тебе. *Поцупив гаманець*", name1, "Оце так мені жах наснився", "", "*засунув руку у кишеню*", name1, "Стоп, а це що таке?", "", "*перевернув на іншу сторону*", name1, "Отакої, це був не сон. Дідько, в гаманці були документи", "", ""]
                })
            }

            ParallelAnimation {
                running: true
                paused: (levelName.state === "stopGame"
                         && running) ? true : false
                PropertyAction {
                    target: mainHero
                    property: "x"
                    value: (bench.x + bench.hitbox.width) / 2
                }
                PropertyAction {
                    target: mainHero
                    property: "y"
                    value: bench.y - mainHero.hitbox.height * 0.57 /*+bench.hitbox.height*0.1*/
                }
                PropertyAction {
                    target: _hostile.itemAt(0)
                    property: "x"
                    value: 0
                }
                PropertyAction {
                    target: _hostile.itemAt(0)
                    property: "y"
                    value: -(_hostile.itemAt(0).hitbox.height)
                }

                SequentialAnimation {
                    loops: 6
                    ScriptAction {
                        script: {
                            _hostile.itemAt(0).x += _hostile.itemAt(0).moveH
                            _hostile.itemAt(0).isMirrored = true
                        }
                    }
                    PauseAnimation {
                        duration: 320
                    }
                }
                SequentialAnimation {
                    PauseAnimation {
                        duration: 320 * 4
                    }
                    ScriptAction {
                        script: {
                            _hostile.itemAt(0).y += _hostile.itemAt(0).moveV
                        }
                    }
                    PauseAnimation {
                        duration: 320 * 2 + 200
                    }
                    ScriptAction {
                        script: {
                            shelf3.source = "Objects/shelf_opened.png"
                            _dialogue.item.visible = true
                            _dialogue.item.enabled = true
                        }
                    }
                    PauseAnimation {
                        duration: 500
                    }
                    ScriptAction {
                        script: {
                            _hostile.itemAt(0).isMirrored = false
                        }
                    }
                }
            }

            ParallelAnimation {
                running: _dialogue.item.indexId === 3 ? true : false
                paused: (levelName.state === "stopGame"
                         && running) ? true : false
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            _hostile.itemAt(0).x -= _hostile.itemAt(0).moveH
                            mainHero.x = bench.x + mainHero.moveH
                        }
                    }
                    PauseAnimation {
                        duration: 320
                    }
                }
                SequentialAnimation {
                    ScriptAction {
                        script: _hostile.itemAt(0).y = mainHero.y
                    }
                    PauseAnimation {
                        duration: 320
                    }
                }
            }

            ParallelAnimation {
                running: _dialogue.item.indexId === 8 ? true : false
                paused: (levelName.state === "stopGame"
                         && running) ? true : false
                SequentialAnimation {
                    ScriptAction {
                        script: [_hostile.itemAt(0).x += _hostile.itemAt(
                                0).moveH, _hostile.itemAt(
                                0).isMirrored = true, mainHero.sideChange.running = true]
                    }
                    PauseAnimation {
                        duration: 320
                    }
                }
                SequentialAnimation {
                    loops: 2
                    ScriptAction {
                        script: _hostile.itemAt(0).y -= _hostile.itemAt(0).moveV
                    }
                    PauseAnimation {
                        duration: 320
                    }
                }
                SequentialAnimation {
                    loops: 3
                    ScriptAction {
                        script: [mainHero.x -= mainHero.moveH /*, mainHero.state="idle"*/
                        ]
                    }
                    PauseAnimation {
                        duration: 320
                    }
                }
                SequentialAnimation {
                    loops: 2
                    ScriptAction {
                        script: mainHero.y -= mainHero.moveV
                    }
                    PauseAnimation {
                        duration: 320
                    }
                }
            }

            SequentialAnimation {
                //        id: dialogueAnimation
                running: _dialogue.item.indexId === 10 ? true : false
                ScriptAction {
                    script: {
                        timeSkipRect.text = qsTr("Пройшло декілька хвилин")
                        _dialogue.item.enabled = false
                        _dialogue.item.visible = false
                    }
                }
                OpacityAnimator {
                    target: timeSkipRect
                    duration: 1000
                    to: 1
                }
                ScriptAction {
                    script: {
                        inventory.item.topVisible = false
                        inventory.item.midVisible = false
                        inventory.item.botVisible = false
                        //                        mainHero.x = 0
                        //                        mainHero.y = -mainHero.hitbox.height + way.height / 2
                        _hostile.itemAt(0).x = way.width - mainHero.hitbox.width
                        _hostile.itemAt(
                                    0).y = -mainHero.hitbox.height + way.height / 2
                        mainHero.state = "idle"
                        gui.visible = true
                        shelf.source = "Objects/shelf_opened.png"
                        _hostile.itemAt(0).isMirrored = false
                    }
                }

                PauseAnimation {
                    duration: 1000
                }
                OpacityAnimator {
                    target: timeSkipRect
                    duration: 1000
                    from: 1
                    to: 0
                }
                ParallelAnimation {
                    ScriptAction {
                        script: {
                            mainHero.whoIsTheBoss.running = true
                        }
                    }
                    SequentialAnimation {
                        PauseAnimation {
                            duration: 650
                        }
                        ScriptAction {
                            script: {
                                shelf.source = "Objects/shelf.png"
                            }
                        }

                        PauseAnimation {
                            duration: 1100
                        }
                        ScriptAction {
                            script: {
                                mainHero.sideChange.running = true
                                levelName.state = Qt.binding(function () {
                                    return subMenu.item.opacity
                                            === 1 ? "stopGame" : _dialogue.item.visible
                                                    === true ? "dialogue" : ""
                                })
                            }
                        }
                    }
                }
                ScriptAction {
                    script: {
                        _hostile.itemAt(0).off = false
                        _hostile.itemAt(0).isRun()
                    }
                }
            }

            SequentialAnimation {
                running: mainHero.state === "die" ? true : false
                PauseAnimation {
                    duration: 250
                }
                SequentialAnimation {
                    loops: Math.abs(
                               _hostile.itemAt(
                                   0).x - mainHero.x) / _hostile.itemAt(0).moveH
                    ScriptAction {
                        script: {
                            _hostile.itemAt(0).x
                                    < mainHero.x ? [_hostile.itemAt(
                                                        0).x += _hostile.itemAt(
                                                        0).moveH, _hostile.itemAt(
                                                        0).isMirrored
                                                    = true] : [_hostile.itemAt(
                                                                   0).x -= _hostile.itemAt(
                                                                   0).moveH, _hostile.itemAt(
                                                                   0).isMirrored = false]
                        }
                    }
                    PauseAnimation {
                        duration: 320
                    }
                }
                SequentialAnimation {
                    loops: Math.abs(_hostile.itemAt(0).z - mainHero.z)
                    ScriptAction {
                        script: {
                            _hostile.itemAt(0).z
                                    < mainHero.z ? [_hostile.itemAt(
                                                        0).y += _hostile.itemAt(
                                                        0).moveV] : _hostile.itemAt(
                                                       0).z
                                                   > mainHero.z ? [_hostile.itemAt(
                                                                       0).y -= _hostile.itemAt(
                                                                       0).moveV] : {}
                        }
                    }
                    PauseAnimation {
                        duration: 200
                    }
                }
                ScriptAction {
                    script: {
                        _dialogue.item.visible = true
                        _dialogue.item.enabled = true
                    }
                }
            }
            SequentialAnimation {
                alwaysRunToEnd: true
                running: _dialogue.item.indexId === 12 ? true : false
                ScriptAction {
                    script: {
                        _dialogue.item.visible = false
                        _dialogue.item.enabled = false
                    }
                }
                SequentialAnimation {
                    loops: (Math.abs(_hostile.itemAt(
                                         0).x - way.width) / _hostile.itemAt(
                                0).moveH) - 1
                    ScriptAction {
                        script: {
                            _hostile.itemAt(0).x += _hostile.itemAt(0).moveH
                            _hostile.itemAt(0).isMirrored = true
                        }
                    }
                    PauseAnimation {
                        duration: 320
                    }
                }
                SequentialAnimation {
                    loops: Math.abs(_hostile.itemAt(0).z - 2)
                    ScriptAction {
                        script: {
                            z < 2 ? [_hostile.itemAt(0).y += _hostile.itemAt(
                                         0).moveV] : [_hostile.itemAt(
                                                          0).y -= _hostile.itemAt(
                                                          0).moveV]
                        }
                    }
                    PauseAnimation {
                        duration: 200
                    }
                }
                ScriptAction {
                    script: {
                        door_right.door_angle = 180
                    }
                }
                PauseAnimation {
                    duration: 1000
                }
                ScriptAction {
                    script: {
                        _hostile.itemAt(0).opacity = 0
                        door_right.door_angle = 0
                        _hostile.itemAt(0).off = true
                        timeSkipRect.text = qsTr("Пройшло декілька годин")
                    }
                }
                OpacityAnimator {
                    target: timeSkipRect
                    duration: 1000
                    to: 1
                }
                ScriptAction {
                    script: {
                        mainHero.health = 50
                        mainHero.semenSideRot = 0
                        mainHero.state = "idle"
                    }
                }
                PropertyAction {
                    target: mainHero
                    property: "x"
                    value: (bench.x + bench.hitbox.width) / 2
                }
                PropertyAction {
                    target: mainHero
                    property: "y"
                    value: bench.y - mainHero.hitbox.height * 0.57
                }

                PauseAnimation {
                    duration: 500
                }
                ScriptAction {
                    script: {
                        mainHero.state = "sit"
                        _dialogue.item.monologue = true
                        _dialogue.item.visible = true
                        _dialogue.item.enabled = true
                    }
                }
                PauseAnimation {
                    duration: 500
                }
                OpacityAnimator {
                    target: timeSkipRect
                    duration: 1000
                    from: 1
                    to: 0
                }
            }
            SequentialAnimation {
                running: _dialogue.item.indexId === 14 ? true : false
                ScriptAction {
                    script: business_card.visible = true
                }
            }
            SequentialAnimation {
                running: _dialogue.item.indexId === 15 ? true : false
                ScriptAction {
                    script: business_card.source = "../Level1/Objects/Business_card2.png"
                }
            }
            SequentialAnimation {
                running: _dialogue.item.indexId === 16 ? true : false
                ScriptAction {
                    script: {
                        business_card.source = ""
                    }
                }
            }
            SequentialAnimation {
                running: _dialogue.item.indexId === 17 ? true : false
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
        id: introLevel12
        Item {
            Component.onCompleted: {
                gui.visible = true
                levelName.state = Qt.binding(function () {
                    return subMenu.item.opacity === 1 ? "stopGame" : _dialogue.item.visible
                                                        === true ? "dialogue" : ""
                })
                name1 = mainHero.name
                _dialogue.item.indexId = 0
                _hostile.itemAt(0).name = "Шкіряний чоловік"
                _hostile.itemAt(0).visible = false
                _hostile.itemAt(0).health = 0
                name2 = _hostile.itemAt(0).name
                levelFinished = true
                saver.localSave.level1Finished[10] ? door_left.opened = true : {}
                //                mainHero.health = 50
                //                inventory.item.topVisible = false
                //                inventory.item.botVisible = false
            }
            SequentialAnimation {
                running: true
                PropertyAction {
                    target: mainHero
                    property: "x"
                    value: saver.localSave.side === "left" ? 0 : way.width - mainHero.hitbox.width
                }
                PropertyAction {
                    target: mainHero
                    property: "y"
                    value: saver.localSave.side
                           === "left" ? -mainHero.hitbox.height + way.height
                                        / 2 : -mainHero.hitbox.height + way.height / 2
                }
                //                PropertyAction {
                //                    target: mainHero
                //                    property: "semenSideRot"
                //                    value: saver.localSave.side === "left" ? 0 : -180
                //                }
            }
        }
    }
}
