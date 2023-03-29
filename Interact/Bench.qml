import QtQuick 2.0

Item {

    Component.onCompleted: {
        picture.source = "../Level1/Objects/bench.png"
        message = qsTr(mainHero.name + " сів")
    }
    //    SequentialAnimation {
    //        PropertyAction { target: picture; property: "source"; value: "../Level1/Objects/bench.png"}
    //        ScriptAction {script: message=qsTr(mainHero.name + " сів")}
    //    }
    SequentialAnimation {
        alwaysRunToEnd: true
        running: (inRange && interact.type === "bench"
                  && (levelFinished == finished
                      && mainHero.state === "use")) ? true : false
        ScriptAction {
            script: {
                mainHero.x = (interact.x + interact.hitbox.width) / 2
                mainHero.y = interact.y - mainHero.hitbox.height * 0.57
            }
        }

        PauseAnimation {
            duration: 500
        }
        ScriptAction {
            script: {
                mainHero.state = "sit"
            }
        }
    }
}
