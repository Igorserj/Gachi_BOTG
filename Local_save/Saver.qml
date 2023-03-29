import QtQuick 2.15
import com.dotwaves.api 1.0

Item {
    property alias settingsSave: settingsSave
    property alias localSave: localSave
    property alias jsonData: jsonData

    function localSaving() {
        jsonData.writeLocal("localSave2.json", saver.localSave.seed,
                            saver.localSave.side, saver.localSave.floor,
                            saver.localSave.level1Finished.join(' '),
                            saver.localSave.currentRoom,
                            saver.localSave.playerHealth,
                            saver.localSave.playerMaxHealth)
    }

    Item {
        id: settingsSave
        property bool shOn: false //shadows
        property bool fullScreen: false
        property int windowWidth: 640
        property int windowHeight: 360
        property bool hitboxVisible: false
        //        onShOnChanged: jsonData.write(":/Local_save/settingsSave.json", shOn, fullScreen)
        //        onFullScreenChanged: jsonData.write(":/Local_save/settingsSave.json", shOn, fullScreen)
    }
    Item {
        id: localSave
        property string seed: ""
        property string side: "left"
        property int floor: 1
        property var level1Finished: [false, false, false, false, false, false, false, false, false, false, false]
        property int currentRoom: 0
        property double playerHealth: 100
        property double playerMaxHealth: 100
        //        onCurrentRoomChanged: {
        //            while (pageLoader.item.levelGenLoader.item._dialogue.status !== Loader.Ready) {

        //            }
        //            pageLoader.item.levelGenLoader.item._dialogue.item.indexId = 0
        //        }
    }
    JsonData {
        id: jsonData
    }

    Component.onCompleted: {
        function settingsS() {
            var obj
            jsonData.parse("settingsSave2.json", "settings")
            if (jsonData.fileExists("settingsSave2.json")) {
                console.log("save")
                obj = jsonData.data[0]
                settingsSave.fullScreen = obj.fullScreen
                settingsSave.shOn = obj.shOn
                settingsSave.windowWidth = obj.windowWidth
                settingsSave.windowHeight = obj.windowHeight
            } else {
                jsonData.parse(":/Local_save/settingsSave.json", "settings")
                if (jsonData.result) {
                    console.log("default save")
                    obj = jsonData.data[0]
                    settingsSave.fullScreen = obj.fullScreen
                    settingsSave.shOn = obj.shOn
                    settingsSave.windowWidth = obj.windowWidth
                    settingsSave.windowHeight = obj.windowHeight
                } else {
                    console.warn("Any data has not found by enable status!")
                }
            }
        }
        function localS() {
            var obj2
            jsonData.parse("localSave2.json", "local")
            if (jsonData.fileExists("localSave2.json")) {
                console.log("save2")
                obj2 = jsonData.data[0]
                localSave.seed = obj2.seed
                localSave.side = obj2.side
                localSave.floor = obj2.floor
                //                localSave.level1Finished = obj2.level1Finished.split(' ')
                var level1Bool = []
                for (var i = 0; i < obj2.level1Finished.split(
                         ' ').length; i++) {
                    level1Bool.push(obj2.level1Finished.split(
                                        ' ')[i] === "true")
                }
                localSave.level1Finished = level1Bool
                localSave.currentRoom = obj2.currentRoom
                localSave.playerHealth = obj2.playerHealth
                localSave.playerMaxHealth = obj2.playerMaxHealth
            } else {
                jsonData.parse(":/Local_save/localSave.json", "local")
                if (jsonData.result) {
                    console.log("save default2")
                    obj2 = jsonData.data[0]
                    localSave.seed = obj2.seed
                    localSave.side = obj2.side
                    localSave.floor = obj2.floor
                    //                    localSave.level1Finished = obj2.level1Finished.split(' ')
                    var level1Bool = []
                    for (var i = 0; i < obj2.level1Finished.split(
                             ' ').length; i++) {
                        level1Bool.push(obj2.level1Finished.split(
                                            ' ')[i] === "true")
                    }
                    localSave.level1Finished = level1Bool
                    localSave.currentRoom = obj2.currentRoom
                    localSave.playerHealth = obj2.playerHealth
                    localSave.playerMaxHealth = obj2.playerMaxHealth
                } else {
                    console.warn("Any data has not found by enable status!")
                }
            }
        }
        settingsS()
        localS()
    }
}
