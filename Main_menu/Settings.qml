import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Controls.Imagine 2.12
import "../"
import "../Controls"

Item {
    id: settings
    focus: pageLoader.type !== "level"
    property alias intensity: nySlider.value
    property var screenDensity: ["1280x720", "1600x900", "1920x1080", "2560x1440"]
    property int w: saver.settingsSave.windowWidth
    property int h: saver.settingsSave.windowHeight
    function resolution() {
        main.windowWidth = w
        main.windowHeight = h
        main.x = (main.screen.width - w) / 2
        main.y = (main.screen.height - h) / 2
        main.showNormal()
        saver.settingsSave.fullScreen = false
    }
    function resolutionFull() {
        main.showFullScreen()
        main.windowWidth = main.screen.width
        main.windowHeight = main.screen.height
        saver.settingsSave.fullScreen = true
        w = main.windowWidth
        h = main.windowHeight
    }
    function menu() {
        if (pageLoader.type === "level") {
            settingsRect.x = -settingsRect.width
        } else {
            settings.opacity = 0
            settings.enabled = false
            mainMenu.container.opacity = 1
            mainMenu.container.enabled = true
            bg.bgFace.visible = true
            bg.bgFace.enabled = true
            logo.opacity = 1
            logo.enabled = true
        }
        saver.jsonData.writeSettings("settingsSave2.json",
                                     saver.settingsSave.shOn,
                                     saver.settingsSave.fullScreen,
                                     main.windowWidth, main.windowHeight)
    }
    Component.onCompleted: {
        saver.settingsSave.fullScreen === true ? [resolutionFull(
                                                      ), switch1.checked = true] : resolution()
    }
    Keys.onPressed: event => {
                        if (event.key === Qt.Key_Escape) {
                            menu()
                        }
                    }

    Rectangle {
        id: container
        color: "transparent"
        anchors.fill: parent
        Column {
            //            anchors.horizontalCenter: parent.horizontalCenter
            x: (container.width - childrenRect.width)
               / 2 // pageLoader.type === "level" ? -childrenRect.width
            // / 2 : (container.width - childrenRect.width) / 2
            spacing: 0.05 * main.windowHeight
            anchors.top: parent.top
            anchors.topMargin: 0.05 * main.windowHeight
            Text {
                text: "Роздільна здатність"
                anchors.horizontalCenter: parent.horizontalCenter
                height: 0.06 * main.windowHeight
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.DemiBold
                font.family: "Comfortaa"
                font.pointSize: 72
                fontSizeMode: Text.Fit
            }
            Row {
                visible: pageLoader.type !== "level"
                enabled: visible
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.05 * main.windowWidth
                Repeater {
                    model: 4
                    Button1 {
                        text: screenDensity[index]
                        enabled: !switch1.checked
                        buttonArea.onClicked: {
                            switch1.checked ? [attention.text = "Зміни доступні в віконному режимі", attention.opacity = 1, attention.timer = 5000] : index === 0 ? [w = 1280, h = 720, resolution()] : index === 1 ? [w = 1600, h = 900, resolution()] : index === 2 ? [w = 1920, h = 1080, resolution()] : [w = 2560, h = 1440, resolution()]
                        }
                    }
                }
            }

            Column {
                visible: pageLoader.type === "level"
                enabled: visible
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.05 * main.windowHeight
                Repeater {
                    model: 4
                    Button1 {
                        text: screenDensity[index]
                        enabled: !switch1.checked
                        buttonArea.onClicked: {
                            switch1.checked ? [attention.text = "Зміни доступні в віконному режимі", attention.opacity = 1, attention.timer = 5000] : index === 0 ? [w = 1280, h = 720, resolution()] : index === 1 ? [w = 1600, h = 900, resolution()] : index === 2 ? [w = 1920, h = 1080, resolution()] : [w = 2560, h = 1440, resolution()]
                        }
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.02 * main.windowHeight
                Text {
                    id: fullScreenText
                    text: "Повноекранний режим"
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: "Comfortaa"
                    font.pointSize: 72
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.VerticalFit
                    font.weight: Font.DemiBold
                    height: 0.06 * main.windowHeight
                    width: paintedWidth
                    color: "white"
                }
                Switch {
                    id: switch1
                    anchors.verticalCenter: parent.verticalCenter
                    Component.onCompleted: main.visibility === 2 ? checked = false : checked = true
                    onPositionChanged: checked ? resolutionFull() : resolution()
                }
            }

            Repeater {
                model: 2
                Button1 {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: index === 0 ? saver.settingsSave.shOn === true ? "Тіні увімкнені" : "Тіні виключені" : pageLoader.type === "level" ? "Зберегти" : "Головне меню"
                    buttonArea.onClicked: {
                        index === 0 ? saver.settingsSave.shOn
                                      === true ? saver.settingsSave.shOn
                                                 = false : saver.settingsSave.shOn = true : menu()
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                visible: pageLoader.type === "level" ? false : bg.newYear
                spacing: 0.02 * main.windowHeight
                Text {
                    text: "Інтенсивність опадів"
                    anchors.verticalCenter: parent.verticalCenter
                    height: 0.06 * main.windowHeight
                    width: paintedWidth
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.DemiBold
                    font.family: "Comfortaa"
                    font.pointSize: 72
                    fontSizeMode: Text.VerticalFit
                }
                Slider {
                    anchors.verticalCenter: parent.verticalCenter
                    id: nySlider
                    from: 0
                    to: 1000
                    value: 100
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

