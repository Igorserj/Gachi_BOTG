import QtQuick 2.15

QtObject {
    id: semen
    property string name: "Семен"
    //    property real maxHealth: 100
    //    property real health: 100
    property real strength: 7
    property double defense: 0
    property double speed: 1
    property var move1: ["Semen/move1/Semen_move1.1.png", "Semen/Semen.png", "Semen/move1/Semen_move1.2.png"]
    //    property var move2: ["Semen/move2/Semen_move2.1.png","Semen/move2/Semen_move2.2.png","Semen/move2/Semen_move2.3.png"]
    property var attack1: ["Semen/attack1/Semen_attack1.1.png", "Semen/attack1/Semen_attack1.2.png", "Semen/attack1/Semen_attack1.3.png", "Semen/attack1/Semen_attack1.4.png", "Semen/attack1/Semen_attack1.5.png"]
    property var attack2: ["Semen/attack2/Semen_attack2.1.png", "Semen/attack2/Semen_attack2.2.png", "Semen/attack2/Semen_attack2.3.png", "Semen/attack2/Semen_attack2.4.png", "Semen/attack2/Semen_attack2.5.png"]
    property var died: ["Semen/died/Semen_died1.png", "Semen/died/Semen_died2.png", "Semen/died/Semen_died3.png"]
    property var sitting: ["Semen/sitting/Semen_sitting.png", "Semen/sitting/Semen_sitting_blinking.png", "Semen/sitting/Semen_sitting_speaking1.png", "Semen/sitting/Semen_sitting_speaking2.png"]
    property var idle: ["Semen/idle/Semen_blinking.png", "Semen/idle/Semen_speaking.png", "Semen/idle/Semen_speaking2.png", imageSource]
    property var block: ["Semen/block/Semen_block1.png", "Semen/block/Semen_block2.png"]
    property string imageSource: "Semen/Semen.png"
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

