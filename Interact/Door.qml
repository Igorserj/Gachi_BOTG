import QtQuick 2.0

Item {

    Component.onCompleted: {
        picture.mirror = interact.type === "door right" ? true : false
        picture.source = "../Level1/Objects/door_left.png"
        interact.opened ? message = "Відчинено" : message = "Зачинено"
    }

    SequentialAnimation {
        alwaysRunToEnd: true
        running: ((inRange && (interact.type === "door left"
                               || interact.type === "door right"))
                  && (levelFinished == finished
                      && mainHero.state === "use")) /* ? true : false*/
        ScriptAction {
            script: {
                opened ? door_angle = -180 : door_angle = 0
                levelName.state = "dialogue"
            }
        }
        PauseAnimation {
            duration: 500
        }
        ScriptAction {
            script: {
                opened ? interact.roomChange
                         === "next" ? nextRoom() : interact.roomChange
                                      === "prev" ? prevRoom() : specificRoom(
                                                       parseInt(
                                                           roomChange)) : {}
                interact.type === "door left" ? saver.localSave.side
                                                = "right" : saver.localSave.side = "left"
            }
        }
        PauseAnimation {
            duration: 500
        }
        ScriptAction {
            script: {
                door_angle = 0
                levelName.state = subMenu.item.opacity
                        > 0 ? "stopGame" : _dialogue.item.visible ? "dialogue" : ""
            }
        }
    }
}
