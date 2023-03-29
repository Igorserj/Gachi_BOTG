import QtQuick 2.0
import "../Controls"

Item {
    id: gui
    property string name1: typeof (mainHero) !== 'undefined' ? mainHero.name : ""
    property double maxHealth1: typeof (mainHero) !== 'undefined' ? mainHero.maxHealth : 0
    property double health1: typeof (mainHero) !== 'undefined' ? mainHero.health : 0

    property string name2: !!_hostile.itemAt(
                               0) ? typeof (_hostile.itemAt(mainHero.targetId))
                                    !== 'null' ? _hostile.itemAt(
                                                     mainHero.targetId).name : "" : ""
    property double maxHealth2: !!_hostile.itemAt(
                                    0) ? typeof (_hostile.itemAt(
                                                     mainHero.targetId))
                                         !== 'null' ? _hostile.itemAt(
                                                          mainHero.targetId).maxHealth : 0 : 0
    property double health2: !!_hostile.itemAt(
                                 0) ? typeof (_hostile.itemAt(
                                                  mainHero.targetId))
                                      !== 'null' ? _hostile.itemAt(
                                                       mainHero.targetId).health : 0 : 0
    visible: !!_dialogue.item ? !_dialogue.item.enabled : true

    HeartContainer {
        maxHealth: maxHealth1
        health: health1
        name: name1
        x: -levelName.x
        y: -levelName.y
    }
    HeartContainer {
        visible: !levelFinished
        maxHealth: maxHealth2
        health: health2
        name: name2
        nameText.anchors.right: right
        nameText.anchors.rightMargin: -containerWidth
        x: (levelName.width - levelName.x - containerWidth)
        y: -levelName.y
    }

    Joystick {
        id: joy
        x: -levelName.x + width / 4
        y: -levelName.y + levelName.height - width / 4 - height
        enabled: levelName.state !== "dialogue"
        onMovingChanged: {
            moving ? posX < 0 ? mainHero.keyA() : posX > 0 ? mainHero.keyD(
                                                                 ) : {} : {}
            moving ? posY < 0 ? mainHero.keyW() : posY > 0 ? mainHero.keyS(
                                                                 ) : {} : {}
        }
    }

    Row {
        x: (levelName.width - levelName.x - childrenRect.width) - joy.width / 2
        y: -levelName.y + levelName.height - joy.width / 2 - childrenRect.height
        spacing: joy.width / 6
        Button1 {
            text: "J"
            width: height
            height: joy.height / 4
            enabled: levelName.state !== "dialogue"
            buttonArea.onClicked: mainHero.keyJ()
        }
        Button1 {
            text: "F"
            width: height
            height: joy.height / 4
            enabled: levelName.state !== "dialogue"
            buttonArea.onClicked: mainHero.keyF()
        }
    }

    Row {
        x: levelName.width / 2 - levelName.x - childrenRect.width / 2
        y: -levelName.y + levelName.height - childrenRect.height - joy.width / 4
        spacing: joy.width / 6
        Button1 {
            text: "▮▮"
            width: height
            height: joy.height / 4
            enabled: levelName.state !== "dialogue"
            buttonArea.onClicked: mainHero.keyEscape()
        }
        Button1 {
            text: "I"
            width: height
            height: joy.height / 4
            enabled: levelName.state !== "dialogue"
            buttonArea.onClicked: mainHero.keyI()
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

