import QtQuick 2.15

QtObject {
    id: van
    property real maxHealth: 200
    property real health: 200
    property real strength: 15
    property double defense: 0.25
    property double speed: 1
    property string name: "Іван Чорнозем"
    property string imageSource: "Van/Van.png"
    property var move1: ["Van/move1/Van_move1.1.png", "Van/Van.png", "Van/move1/Van_move1.2.png"]
    property var attack1: ["Van/attack1/Van_attack1.1.png", "Van/attack1/Van_attack1.2.png", "Van/attack1/Van_attack1.3.png", "Van/attack1/Van_attack1.4.png", "Van/attack1/Van_attack1.5.png"]
    property var attack2: ["Van/attack2/Van_attack2.1.png", "Van/attack2/Van_attack2.2.png", "Van/attack2/Van_attack2.3.png", "Van/attack2/Van_attack2.4.png", "Van/attack2/Van_attack2.5.png"]
    property var died: ["Van/died/Van_died1.png", "Van/died/Van_died2.png", "Van/died/Van_died3.png", "Van/died/Van_died4.png", "Van/died/Van_died4.png"]
    property var idle: ["Van/idle/Van_blinking.png", "Van/idle/Van_speaking.png", "Van/idle/Van_speaking2.png", imageSource]
    property var skill1: ["Van/skill1/skill1.1.png", "Van/skill1/skill1.2.png", "Van/skill1/skill1.3.png", "Van/skill1/skill1.3.png"]
}
