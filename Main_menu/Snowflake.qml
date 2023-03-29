import QtQuick 2.15

Item {
    Rectangle {
        id: snowflake
        height: 20 * Math.random()
        width: height
        radius: height / 2
        x: Math.random() * main.windowWidth
        color: "white"
        SequentialAnimation {
            running: true
            loops: Animation.Infinite
            NumberAnimation {
                target: repeater.itemAt(index)
                property: "y"
                duration: (Math.random() + 0.5) * 0.5 * 10000
                from: 0
                to: main.windowHeight + repeater.itemAt(index).height
            }
        }
    }
}
