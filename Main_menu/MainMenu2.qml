import QtQuick 2.15
import ".."
import "../Controls"

Item {
    id: mainMenu2
    //    property alias mainMenu2: mainMenu2
    property var menuButtonScript
    property var buttonText: ["Нова гра", "Продовжити" /*, "Кімната 1", "Міст", "Тестовий рівень"*/
        , "Назад"]
    property alias container: container
    /*: [,cont(),,exit()]*/ /*mainMenu.z =-1; level1.z=0; mainMenu.enabled=false*/
    function back() {
        //        mainMenu2.visible = false
        mainMenu2.opacity = 0
        mainMenu2.enabled = false
        //        mainMenu.container.visible = true
        mainMenu.container.opacity = 1
        mainMenu.container.enabled = true
    }
    function newGame() {
        pageLoader.source = "../Level1/LevelGen.qml"
        generateSeed()
        saver.localSave.side = "left"
        saver.localSave.floor = 1
        saver.localSave.level1Finished
                = [false, false, false, false, false, false, false, false, false, false, false]
        saver.localSave.currentRoom = 0
        saver.localSave.playerHealth = 100
        saver.localSave.playerMaxHealth = 100
        saver.jsonData.writeLocal("localSave2.json", saver.localSave.seed,
                                  saver.localSave.side, saver.localSave.floor,
                                  saver.localSave.level1Finished,
                                  saver.localSave.currentRoom,
                                  saver.localSave.playerHealth,
                                  saver.localSave.playerMaxHealth)
    }
    function cont() {
        pageLoader.source = "../Level1/LevelGen.qml"
    }

    function room1() {
        pageLoader.source = "../Level1/Room1.qml"
        return saver.localSave.seed === "" ? generateSeed() : {}
    }
    function bridge() {
        pageLoader.source = "../Level1/Bridge.qml"
        return saver.localSave.seed === "" ? generateSeed() : {}
    }
    function test() {
        pageLoader.source = "../Test/TestLevel.qml"
        return saver.localSave.seed === "" ? generateSeed() : {}
    }
    function generateSeed() {
        saver.localSave.seed = ""
        for (var i = 0; i < 4; i++) {
            saver.localSave.seed += Math.floor(Math.random() * 9).toString()
        }
        console.log(saver.localSave.seed)
    }

    Rectangle {
        id: container
        color: "transparent"
        width: mainMenu.container.width
        height: mainMenu.container.height
        x: mainMenu.container.x
        y: mainMenu.container.y

        Column {
            anchors.fill: parent
            z: 2
            Repeater {
                id: button
                model: buttonText
                //                Rectangle {
                //                    height: container.height / 3
                //                    width: container.width
                //                    color: "transparent"
                //                    Text {
                //                        text: modelData
                //                        height: parent.height * 0.9
                //                        width: parent.width * 0.9
                //                        color: mouseArea.enabled ? mouseArea.containsMouse ? "#888888" : "white" : "#AAAAAA"
                //                        horizontalAlignment: Text.AlignRight
                //                        verticalAlignment: Text.AlignVCenter
                //                        padding: 10
                //                        font.weight: Font.DemiBold
                //                        font.family: "Comfortaa"
                //                        fontSizeMode: Text.VerticalFit
                //                        minimumPixelSize: 10
                //                        font.pixelSize: 72
                //                    }
                //                    MouseArea {
                //                        id: mouseArea
                //                        anchors.fill: parent
                //                        hoverEnabled: true
                //                        enabled: index === 1 ? saver.localSave.seed !== "" ? true : false : true
                //                        onClicked: {
                //                            index === 0 ? newGame(
                //                                              ) : index === 1 ? cont() : /*index === 2 ? room1() : index === 3 ? bridge() : index === 4 ? test() :*/ back()
                //                        }
                //                    }
                //                }
                Button3 {
                    text: modelData
                    enabled: index === 1 ? saver.localSave.seed !== "" ? true : false : true
                    alignment: "right"
                    anchors.right: parent.right
                    buttonArea.onClicked: {
                        index === 0 ? newGame(
                                          ) : index === 1 ? cont() : /*index === 2 ? room1() : index === 3 ? bridge() : index === 4 ? test() :*/ back()
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:720;width:1280}
}
##^##*/

