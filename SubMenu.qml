import QtQuick 2.15
import QtQuick.Controls 2.12
import "Controls"
import "Main_menu"

Item {
    id: subMenu
    property var buttonName: ["Продовжити", "Налаштування", "Головне меню", "Вихід"]
    property var commandName: [!!pageLoader.item.levelGenLoader.item.mainHero ? "Heal MH by 20" : "", !!pageLoader.item.levelGenLoader.item.mainHero ? "Damage MH by 20" : "", /*!!pageLoader.item.levelGenLoader.item.mainHero ? pageLoader.item.levelGenLoader.item.mainHero.defense < 1 ? "Make MH invincible" : "Make MH vulnerable" : "",*/ !!pageLoader.item.levelGenLoader.item._hostile ? "Damage all H by 20" : "", !!pageLoader.item.levelGenLoader.item._hostile ? "Heal all H by 20" : "", !!pageLoader.item.levelGenLoader.item.mainHero ? "MH Sit" : "", !!pageLoader.item.levelGenLoader.item.mainHero ? "MH idle" : "", !!pageLoader.item.levelGenLoader.item.mainHero ? "MH attack1" : "", !!pageLoader.item.levelGenLoader.item.mainHero ? "MH attack2" : "", !!pageLoader.item.levelGenLoader.item.mainHero ? "MH die" : "", !!pageLoader.item.levelGenLoader.item._hostile ? "H Sit" : "", !!pageLoader.item.levelGenLoader.item._hostile ? "H idle" : "", !!pageLoader.item.levelGenLoader.item._hostile ? "H attack1" : "", !!pageLoader.item.levelGenLoader.item._hostile ? "H attack2" : "", !!pageLoader.item.levelGenLoader.item._hostile ? "H die" : "", !!pageLoader.item.levelGenLoader.item._hostile ? !!pageLoader.item.levelGenLoader.item._hostile.itemAt(0) ? pageLoader.item.levelGenLoader.item._hostile.itemAt(0).off === false ? "H Off" : "H On" : "" : "", attention.opacity
        === 0 ? "Attention show" : "Attention hide", "Hitbox visibility", "Finish room"]
    property int indexId: 0

    SequentialAnimation {
        id: fadeIn
        //        running: opacity===1?true:false
        PropertyAction {
            target: subMenu
            property: "visible"
            value: true
        }
        OpacityAnimator {
            target: subMenu
            from: 0
            to: 1
            duration: 250
        }
    }
    SequentialAnimation {
        id: fadeOut
        //        running: opacity===0?true:false
        OpacityAnimator {
            target: subMenu
            from: 1
            to: 0
            duration: 250
        }
        PropertyAction {
            target: subMenu
            property: "visible"
            value: false
        }
    }

    function action1() {
        subMenu.enabled = false
        subMenu.opacity = 0
        //        fadeOut.running = true
        if (!!pageLoader.item.levelGenLoader.item._hostile) {
            for (var indexId = 0; indexId
                 < pageLoader.item.levelGenLoader.item._hostile.model; indexId++) {
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).off = true
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).off = false
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).isRun()
            }
        }
    }
    function action2() {
        settingsRect.x = 0
    }
    function action3() {
        saver.localSaving()
        pageLoader.source = "Main_menu/MainMenu.qml"
        subMenu.enabled = false
        subMenu.visible = false
    }
    function action4() {
        saver.localSaving()
        Qt.callLater(Qt.quit)
    }

    function mhHeal() {
        pageLoader.item.levelGenLoader.item.mainHero.health += 20
        attention.text = pageLoader.item.levelGenLoader.item.mainHero.health
        attention.opacity = 1
    }
    function mhDamage() {
        pageLoader.item.levelGenLoader.item.mainHero.health -= 20
        attention.text = pageLoader.item.levelGenLoader.item.mainHero.health
        attention.opacity = 1
    }
    function invincible() {
        pageLoader.item.levelGenLoader.item.mainHero.defense
                == 1 ? [pageLoader.item.levelGenLoader.item.mainHero.defense
                        = pageLoader.item.levelGenLoader.item.mainHero.defense2, console.log(
                            "Ви тепер вразливий")] : [pageLoader.item.levelGenLoader.item.mainHero.defense2 = pageLoader.item.levelGenLoader.item.mainHero.defense, pageLoader.item.levelGenLoader.item.mainHero.defense = 1, console.log(
                                                          "Ви тепер непереможний")]
    }
    function hDamage() {
        if (typeof (pageLoader.item.levelGenLoader.item._hostile) !== 'undefined') {
            for (indexId = 0; indexId
                 < pageLoader.item.levelGenLoader.item._hostile.model; indexId++) {
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).health - 20
                        >= 0 ? pageLoader.item.levelGenLoader.item._hostile.itemAt(
                                   indexId).health
                               -= 20 : pageLoader.item.levelGenLoader.item._hostile.itemAt(
                                   indexId).health = 0
                attention.text = (indexId + " "
                                  + pageLoader.item.levelGenLoader.item._hostile.itemAt(
                                      indexId).health)
                attention.opacity = 1
            }
        } else {
            attention.text = "Цілі відсутні"
            attention.opacity = 1
        }
    }
    function hHeal() {
        if (typeof (pageLoader.item.levelGenLoader.item._hostile) !== 'undefined') {
            for (indexId = 0; indexId
                 < pageLoader.item.levelGenLoader.item._hostile.model; indexId++) {
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).health <= pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).maxHealth
                        + 20 ? pageLoader.item.levelGenLoader.item._hostile.itemAt(
                                   indexId).health
                               += 20 : pageLoader.item.levelGenLoader.item._hostile.itemAt(
                                   indexId).health
                               = pageLoader.item.levelGenLoader.item._hostile.itemAt(
                                   indexId).maxHealth
                attention.text = (indexId + " "
                                  + pageLoader.item.levelGenLoader.item._hostile.itemAt(
                                      indexId).health)
                attention.opacity = 1
            }
        } else {
            attention.text = "Цілі відсутні"
            attention.opacity = 1
        }
    }
    function mhSit() {
        pageLoader.item.levelGenLoader.item.mainHero.state = "sit"
    }
    function mhIdle() {
        pageLoader.item.levelGenLoader.item.mainHero.state = "idle"
    }
    function mhAttack1() {
        pageLoader.item.levelGenLoader.item.mainHero.latestActivity = "attack2"
        pageLoader.item.levelGenLoader.item.mainHero.state = "punch"
    }
    function mhAttack2() {
        pageLoader.item.levelGenLoader.item.mainHero.latestActivity = "attack1"
        pageLoader.item.levelGenLoader.item.mainHero.state = "punch"
    }
    function mhDie() {
        pageLoader.item.levelGenLoader.item.mainHero.state = "die"
    }

    function hSit() {
        if (typeof (pageLoader.item.levelGenLoader.item._hostile) !== 'undefined') {
            for (indexId = 0; indexId
                 < pageLoader.item.levelGenLoader.item._hostile.model; indexId++) {
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).state = "sit"
            }
        } else {
            attention.text = "Цілі відсутні"
            attention.opacity = 1
        }
    }
    function hIdle() {
        if (typeof (pageLoader.item.levelGenLoader.item._hostile) !== 'undefined') {
            for (indexId = 0; indexId
                 < pageLoader.item.levelGenLoader.item._hostile.model; indexId++) {
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).state = "idle"
            }
        } else {
            attention.text = "Цілі відсутні"
            attention.opacity = 1
        }
    }
    function hAttack1() {
        if (typeof (pageLoader.item.levelGenLoader.item._hostile) !== 'undefined') {
            for (indexId = 0; indexId
                 < pageLoader.item.levelGenLoader.item._hostile.model; indexId++) {
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).latestActivity = "attack2"
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).state = "punch"
            }
        } else {
            attention.text = "Цілі відсутні"
            attention.opacity = 1
        }
    }
    function hAttack2() {
        if (typeof (pageLoader.item.levelGenLoader.item._hostile) !== 'undefined') {
            for (indexId = 0; indexId
                 < pageLoader.item.levelGenLoader.item._hostile.model; indexId++) {
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).latestActivity = "attack1"
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).state = "punch"
            }
        } else {
            attention.text = "Цілі відсутні"
            attention.opacity = 1
        }
    }
    function hDie() {
        if (typeof (pageLoader.item.levelGenLoader.item._hostile) !== 'undefined') {
            for (indexId = 0; indexId
                 < pageLoader.item.levelGenLoader.item._hostile.model; indexId++) {
                pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).state = "die"
            }
        } else {
            attention.text = "Цілі відсутні"
            attention.opacity = 1
        }
    }
    function hOff() {
        if (typeof (pageLoader.item.levelGenLoader.item._hostile) !== 'undefined') {
            for (indexId = 0; indexId
                 < pageLoader.item.levelGenLoader.item._hostile.model; indexId++) {
                if (pageLoader.item.levelGenLoader.item._hostile.itemAt(
                            indexId).off === false) {
                    pageLoader.item.levelGenLoader.item._hostile.itemAt(
                                indexId).switchOff()
                    attention.text = ("AI Disabled")
                    attention.opacity = 1
                } else {
                    pageLoader.item.levelGenLoader.item._hostile.itemAt(
                                indexId).off = false
                    attention.text = ("AI Enabled")
                    attention.opacity = 1
                }
            }
        } else {
            attention.text = "Цілі відсутні"
            attention.opacity = 1
        }
    }
    function message() {
        if (attention.opacity === 0)
            attention.opacity = 1
        else
            attention.opacity = 0
    }
    function hitboxVisibility() {
        saver.settingsSave.hitboxVisible = !saver.settingsSave.hitboxVisible
    }
    function finish() {
        pageLoader.item.levelGenLoader.item.levelFinished = true
        var currentRoom = saver.localSave.currentRoom
        saver.localSave.currentRoom = -1
        saver.localSave.currentRoom = currentRoom
    }

    Rectangle {
        id: rectangle
        color: "#88000000"
        anchors.fill: parent
    }

    Rectangle {
        //        property double buttonTextWidth : 0
        id: menu
        color: "#55777777"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        //width: buttonTextWidth*1.3//0.3*parent.width
        width: column2.width * 1.2
        height: column2.height * 1.2
        radius: height / 8
        Column {
            id: column2
            anchors.horizontalCenter: menu.horizontalCenter
            anchors.verticalCenter: menu.verticalCenter
            spacing: menu.height * 0.05
            Repeater {
                model: buttonName
                Button1 {
                    text: modelData
                    visible: index !== 1
                    buttonArea.onClicked: {
                        index === 0 ? action1(
                                          ) : index === 1 ? action2(
                                                                ) : index === 2 ? action3(
                                                                                      ) : action4()
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Rectangle {
        id: bookmarkRect
        color: bookmark.containsMouse ? "#88777777" : "#88AAAAAA"
        height: menu.height / 6
        width: bookmark.containsMouse ? height / 2 : height / 4
        anchors.right: cheatRect.left
        anchors.verticalCenter: parent.verticalCenter
        MouseArea {
            id: bookmark
            hoverEnabled: true
            anchors.fill: parent
            onClicked: {
                if (cheatRect.x >= rectangle.width)
                    cheatRect.x = rectangle.width - cheatRect.width
                else
                    cheatRect.x = rectangle.width
            }
        }
        Text {
            text: bookmark.containsMouse ? cheatRect.x >= rectangle.width ? "<" : ">" : ""
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            fontSizeMode: Text.VerticalFit
            anchors.fill: parent
            color: "white"
            font.bold: true
        }
        Behavior on width {
            PropertyAnimation {
                target: bookmarkRect
                property: "width"
                duration: 100
                easing.type: "InQuad"
            }
        }
    }

    Rectangle {
        id: cheatRect
        color: "#55777777"
        width: (parent.width - menu.width * 1.1) / 2
        x: rectangle.width
        //            anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        Behavior on x {
            PropertyAnimation {
                target: cheatRect
                property: "x"
                duration: 500
                easing.type: Easing.OutCirc
            }
        }
        ScrollView {
            height: cheatRect.height
            width: cheatRect.width
            Column {
                id: column
                spacing: cheatRect.height * 0.02
                width: cheatRect.width
                height: cheatRect.height
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                Repeater {
                    id: repeater
                    model: commandName
                    Button1 {
                        text: modelData
                        anchors.horizontalCenter: parent.horizontalCenter
                        buttonArea.onClicked: {
                            index === 0 ? mhHeal() : index === 1 ? mhDamage() : index === 2 ? hDamage() : index === 3 ? hHeal() : index === 4 ? mhSit() : index === 5 ? mhIdle() : index === 6 ? mhAttack1() : index === 7 ? mhAttack2() : index === 8 ? mhDie() : index === 9 ? hSit() : index === 10 ? hIdle() : index === 11 ? hAttack1() : index === 12 ? hAttack2() : index === 13 ? hDie() : index === 14 ? hOff() : index === 15 ? message() : index === 16 ? hitboxVisibility() : index === 17 ? finish() : {}
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: settingsRect
        color: "#55777777"
        width: parent.width // (parent.width - menu.width * 1.1) / 2
        x: -settingsRect.width
        //            anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        Behavior on x {
            PropertyAnimation {
                target: settingsRect
                property: "x"
                duration: 500
                easing.type: Easing.OutCirc
            }
        }
        ScrollView {
            height: settingsRect.height
            width: settingsRect.width
            Settings {}
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.33;height:720;width:1280}
}
##^##*/

