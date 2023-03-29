import QtQuick 2.0
import QtGraphicalEffects 1.15
import "../"

Item {
    id: interact
    property bool finished: false
    property alias glow: glow
    property alias hitbox: hitbox
    //    property string source: ""
    property double imageHeight: picture.sourceSize.height
    property double imageWidth: picture.sourceSize.width
    property bool opened: false
    property string type: ""
    property string roomChange: "next"
    property real door_angle: 0
    //    property int doorSubLevelNumber: 0
    property string message: ""
    property bool inRange: ((mainHero.x + mainHero.hitbox.width >= interact.x
                             - picture.paintedWidth)
                            && (mainHero.x <= interact.x + picture.paintedWidth * 1.5))
                           && mainHero.z == interact.z
    property double scaling: 1
    z: (way.height * 2 / 3 < y + picture.height) ? 2 : (way.height * 1 / 3 < y
                                                        + picture.height) ? 1 : 0

    function specificRoom(room = saver.localSave.currentRoom) {
        var currentRoom = room
        roomSwap(currentRoom)
    }
    function nextRoom() {
        var currentRoom = saver.localSave.currentRoom + 1
        roomSwap(currentRoom)
    }
    function prevRoom() {
        var currentRoom = saver.localSave.currentRoom - 1
        roomSwap(currentRoom)
    }
    function roomSwap(currentRoom) {
        saver.localSave.currentRoom = -1
        saver.localSave.currentRoom = currentRoom
    }

    Behavior on door_angle {
        ParallelAnimation {
            SequentialAnimation {
                ScriptAction {
                    script: mainHero.whoIsTheBoss.running = mainHero.state === "use"
                }

                PauseAnimation {
                    duration: 650
                }
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: 350
                }
                PropertyAnimation {
                    target: interact
                    property: "door_angle"
                    duration: 300
                }
            }
        }
    }

    Image {
        id: picture
        fillMode: Image.PreserveAspectFit
        height: imageHeight
        scale: interact.scaling
        transform: Rotation {
            origin.x: interact.type === "door right" ? picture.width / 7.9 : interact.type
                                                       === "door left" ? picture.width / 1.16 : 0
            origin.y: 0
            axis {
                x: 0
                y: 1
                z: 0
            }
            angle: door_angle
        }
        Rectangle {
            id: hitbox
            anchors.fill: parent
            border.width: saver.settingsSave.hitboxVisible === true ? 2 / interact.scaling : 0
            border.color: opened ? "red" : "black"
            color: "transparent"
        }
        Component {
            id: _bench
            Bench {}
        }
        Component {
            id: _stairs
            Stairs {}
        }
        Component {
            id: _door
            Door {}
        }

        Loader {
            id: interactLoader
            sourceComponent: type === "bench" ? _bench : (type === "stairs left"
                                                          || type === "stairs right") ? _stairs : (type === "door left" || type === "door right") ? _door : undefined
        }
    }
    Glow {
        id: glow
        radius: (inRange && levelFinished === finished
                 && mainHero.state !== "use"
                 && levelName.state !== "dialogue") ? 4 : 0
        spread: (inRange && levelFinished === finished
                 && mainHero.state !== "use"
                 && levelName.state !== "dialogue") ? 0.6 : 0
        visible: (inRange && levelFinished === finished
                  && mainHero.state !== "use"
                  && levelName.state !== "dialogue") ? true : false
        onVisibleChanged: {
            attention.text = message
            attention.text !== "" && levelFinished == finished
                    && mainHero.state === "use" ? attention.opacity = 1 : attention.opacity = 0
            typeof (buttonIcon) !== 'undefined' ? [buttonIcon.visible
                                                   = visible, buttonIcon.text = "E"] : {}
        }
        source: picture
        anchors.fill: picture
        scale: interact.scaling
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:720;width:1280}
}
##^##*/

