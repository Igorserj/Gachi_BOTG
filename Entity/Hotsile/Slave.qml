import QtQuick 2.15

QtObject {
    id: slave
    property real maxHealth: 25
    property real health: 25
    property real strength: 2
    property double defense: 0.05
    property double speed: 0.85
    property string name: "Раб"
    property string imageSource: "Slave/Slave.png"
    property var move1: ["Slave/move1/Slave_move1.1.png", imageSource, "Slave/move1/Slave_move1.2.png"]
    property var attack1: ["Slave/attack1/Slave_attack1.1.png", "Slave/attack1/Slave_attack1.2.png", "Slave/attack1/Slave_attack1.3.png", "Slave/attack1/Slave_attack1.4.png", "Slave/attack1/Slave_attack1.5.png"]
    property var attack2: ["Slave/attack2/Slave_attack2.1.png", "Slave/attack2/Slave_attack2.2.png", "Slave/attack2/Slave_attack2.3.png", "Slave/attack2/Slave_attack2.4.png", "Slave/attack2/Slave_attack2.5.png"]
    property var died: ["Slave/died/Slave_died1.png", "Slave/died/Slave_died2.png", "Slave/died/Slave_died3.png", "Slave/died/Slave_died4.png", "Slave/died/Slave_died4.png"]
    property var idle: [imageSource, imageSource, imageSource]
}
