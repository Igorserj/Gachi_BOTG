import QtQuick 2.0
import QtGraphicalEffects 1.15
import "Entity/MainHero"

Item {
    id: dialogue
    property int indexId: 0
    property int textId: 0
    property bool fadeOutRunning: false
    property bool monologue: false
    onVisibleChanged: {
        typeof (buttonIcon) !== 'undefined' ? [buttonIcon.text = "⎵", buttonIcon.visible
                                               = visible] : {}
    }
    SequentialAnimation {
        id: fadeOut
        running: fadeOutRunning
        ParallelAnimation {
            NumberAnimation {
                target: mainText
                property: "opacity"
                from: 1
                to: 0
                duration: 500
            }
            NumberAnimation {
                target: nameText
                property: "opacity"
                from: 1
                to: 0
                duration: 500
            }
        }
        ScriptAction {
            script: {
                indexId++
                fadeIn.running = true
                fadeOutRunning = false
            }
        }
    }
    SequentialAnimation {
        id: fadeIn
        ParallelAnimation {
            NumberAnimation {
                target: mainText
                property: "opacity"
                from: 0
                to: 1
                duration: 500
            }
            NumberAnimation {
                target: nameText
                property: "opacity"
                from: 0
                to: 1
                duration: 500
            }
        }
    }

    //    Behavior on height {
    //        PropertyAnimation {
    //            properties: "height"
    //            target: field
    //            duration: 1000
    //        }
    //    }
    //    Component.onCompleted: {field.height=dialogue.height*0.3}
    Rectangle {
        id: field
        color: "#55000000"
        height: parent.height * 0.3
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Rectangle {
            id: nameTextRect
            color: "transparent"
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.025
            height: field.height / 2
            width: field.width - field.height * 3
            anchors.horizontalCenter: field.horizontalCenter
            Text {
                id: nameText
                text: levelText[indexId * 2]
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Medium
                font.family: "Comfortaa"
                fontSizeMode: Text.Fit
                minimumPixelSize: 10
                font.pixelSize: 100
                color: "white"
                onTextChanged: textId++
                anchors.fill: parent
            }
        }
        Rectangle {
            color: "transparent"
            anchors.top: nameTextRect.bottom
            //            height: field.height/2.2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.025
            width: field.width - field.height
            anchors.horizontalCenter: field.horizontalCenter
            Text {
                id: mainText
                color: "#ffffff"
                text: levelText[indexId * 2 + 1]
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Medium
                fontSizeMode: Text.Fit
                minimumPixelSize: 10
                font.pixelSize: 100
                font.family: "Comfortaa"
                height: mainHeroFrame.height / 2
                width: field.width - mainHeroFrame.width
                wrapMode: Text.Wrap
                anchors.fill: parent
            }
        }
        //        }
    }

    Rectangle {
        id: mainHeroFrame
        color: "transparent"
        border.color: "black"
        border.width: saver.settingsSave.hitboxVisible === true ? 2 : 0
        clip: true
        height: parent.height * 0.3
        width: height
        anchors.verticalCenter: field.top
        //        y: parent.height*0.7-height/2
        x: height / 2
        Image {
            id: mainHeroImage
            source: /*"Entity/MainHero/Semen/parts/Semen_face.png"*/ mainHero.semen_face.source
            sourceSize.height: height * 0.3
            sourceSize.width: width * 0.3
            fillMode: Image.Pad
            verticalAlignment: Image.AlignTop
            height: dialogue.height
            width: dialogue.height
            x: -(width - mainHeroFrame.width) / 2
            Image {
                source: mainHero.semen_pupils.source //"Entity/MainHero/Semen/parts/Semen_pupils.png"
                height: 19 * mainHero.semen_pupils.height / 30 * pageLoader.height / 720
                width: 76 * pageLoader.height / 720
                x: mainHeroImage.width * 0.478
                transformOrigin: Item.Center
                anchors.verticalCenter: mainHeroImage.verticalCenter
                anchors.verticalCenterOffset: -mainHeroImage.height * 0.363
            }
            Image {
                source: mainHero.semen_mouth.visible ? mainHero.semen_mouth.source : mainHero.semen_speak.visible ? mainHero.semen_speak.source : mainHero.semen_speak2.source
                height: 5
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: mainHeroImage.horizontalCenter
                anchors.horizontalCenterOffset: mainHeroImage.width * 0.03
                anchors.verticalCenter: mainHeroImage.verticalCenter
                anchors.verticalCenterOffset: -mainHeroImage.height * 0.257
            }
        }

        BrightnessContrast {
            anchors.fill: mainHeroImage
            source: mainHeroImage
            brightness: nameText.text === mainHero.name ? 0 : -0.6
            cached: true
        }
    }

    Component {
        id: _hostileFrame
        Rectangle {
            id: hostileFrame
            color: "transparent"
            border.color: "black"
            border.width: saver.settingsSave.hitboxVisible === true ? 2 : 0
            clip: true
            height: dialogue.height * 0.3
            width: height
            x: dialogue.width - 1.5 * height
            //        anchors.verticalCenter: field.top
            Image {
                id: hostileImage
                source: !!_hostile.itemAt(
                            0) ? _hostile.itemAt(
                                     0).picture.source : !!npc.item ? npc.item.harley_face.source : ""
                fillMode: Image.PreserveAspectCrop
                verticalAlignment: Image.AlignTop
                height: dialogue.height
                width: dialogue.height
                x: -(width - mainHeroFrame.width) / 2
                mirror: !!npc.item
                sourceSize.height: !!npc.item ? height * 0.3 : height
                sourceSize.width: !!npc.item ? width * 0.3 : width
                Image {
                    id: mask
                    source: !!_hostile.itemAt(
                                0) ? _hostile.itemAt(
                                         0).masked === true ? _hostile.itemAt(
                                                                  0).mask.source : "" : ""
                    height: dialogue.height
                    width: dialogue.height
                    fillMode: Image.PreserveAspectCrop
                    verticalAlignment: Image.AlignTop
                }
            }
            BrightnessContrast {
                anchors.fill: hostileImage
                source: hostileImage
                brightness: !!npc.item ? nameText.text === npc.item.name ? 0 : -0.6 : !!_hostile.itemAt(0) ? nameText.text === _hostile.itemAt(0).name ? 0 : -0.6 : -0.6 // !!npc.item ? npc.item.name ? 0 : -0.6 : 0
                //                cached: true
            }
        }
    }
    Component {
        id: errorDialogue
        Text {
            text: !monologue ? typeof (_hostile.itemAt(
                                           0)) !== 'undefined' ? _hostile.itemAt(
                                                                     0).picture.source ? "_hostileFrame" : "No picture" : "No picture" : "Monologue active"
            font.pointSize: 28
            x: dialogue.width - contentWidth
        }
    }
    Loader {
        sourceComponent: !monologue ? !!_hostile.itemAt(0)
                                      || !!npc.item ? _hostileFrame : errorDialogue : errorDialogue
        anchors.verticalCenter: field.top
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.1;height:720;width:1280}
}
##^##*/

