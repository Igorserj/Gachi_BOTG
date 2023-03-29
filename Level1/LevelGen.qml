import QtQuick 2.0
import Qt.labs.qmlmodels 1.0

Item {
    id: levelGen
    property alias levelGenLoader: levelGenLoader
    property string type: "level"
    property int w: parseInt(saver.localSave.seed.charAt(0))
    property int f: parseInt(saver.localSave.seed.charAt(1))
    property int v: parseInt(saver.localSave.seed.charAt(2))
    property int g: parseInt(saver.localSave.seed.charAt(3))
    property int q: Math.floor((9 - w) / 2) + 2
    property var doorPool: [0, 1, 2, 3, 4, 5]
    property var roomQ: [1]
    property var doorQ: [0]
    property var roomPool: [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
    property var doorSides: ["door left", "door right", "door left", "door right", "door left", "door right"]

    //    onRoomQChanged: console.log("Rooms " + roomQ)
    //    onDoorQChanged: console.log("Doors " + doorQ)
    Loader {
        id: levelGenLoader
        focus: true
        asynchronous: true
        anchors.fill: parent
        onLoaded: {
            bg.loadingAnimation.running = true
        }
        visible: status == Loader.Ready
        onStatusChanged: {
            if (status !== Loader.Ready) {
                bg.loadingAnimation2.running = true
            }
        }
        Component.onCompleted: {
            doorSequence()
            roomSequence()
            roomPool[0] = 0
            roomPool[roomQ[0]] = 1

            sourceComponent = Qt.binding(function () {
                return roomPool[saver.localSave.currentRoom]
                        === 0 ? level1Item : roomPool[saver.localSave.currentRoom]
                                === 1 ? bridgeItem : roomPool[saver.localSave.currentRoom]
                                        === 2 ? room1Item : undefined
            })
            //        console.log("Doors " + doorQ + ". " + "Rooms " + roomQ + ".")
        }
        //        onLoaded: {
        //            pageLoader.loadingAnimation.running = true
        //        }
        //        onStatusChanged: {
        //            if (pageLoader.status !== Loader.Ready) {
        //                pageLoader.loadingAnimation2.running = true
        //            }
        //        }
    }
    LevelGenBg {
        id: bg
    }

    Component {
        id: room1Item
        Room1 {}
    }
    Component {
        id: bridgeItem
        Bridge {}
    }
    Component {
        id: level1Item
        Level1Pattern {
            anchors.fill: parent
        }
    }

    function doorSequence() {
        var leftSide = [4, Math.floor(f / 2), Math.floor(
                            (w + f) / 5), Math.floor(
                            (f + v + 2) / 7), Math.ceil(g / 9), doorPool[0]]
        for (var i = 0; i < q; i++) {
            doorQ[i] = doorPool[leftSide[i]]
            if (i !== q - 1) {
                doorPool.splice(leftSide[i], 1)
            } else if (i === q - 1) {
                doorQ[i] = doorPool[0]
            }
        }
    }
    function roomSequence() {
        for (var i = 0; i < q; i++) {
            var rooms = 0
            var leftSide = [((v + 1) / 10), ((g + 1) / 10), ((w + 1) / 10), ((f + 1) / 10), ((f + w + 2) / 20)]
            for (var j = 0; j < i; j++) {
                rooms += roomQ[j]
            }
            if (i == q - 1) {
                roomQ[i] = Math.ceil((10 - (q - 1) + 1 * i - rooms))
            } else {
                roomQ[i] = Math.ceil(
                            leftSide[i] * (10 - (q - 1) + 1 * i - rooms))
            }
        }
    }
}
