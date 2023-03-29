import QtQuick 2.15
import QtGraphicalEffects 1.15
import ".."
import "../Lighting"

Item {
    id: bg
    property alias bgImage: bgImage
    property alias bgFace: bgFace
    property real bgScale: 1.05
    property bool newYear: ((main.currentDate.getMonth(
                                 ) + 1 === 12 && main.currentDate.getDate(
                                 ) > 24)
                            || (main.currentDate.getMonth() + 1 === 1
                                && main.currentDate.getDate() < 24))
    property var picArray: newYear ? ['man_ny.png', "herrington_ny.png", "van_ny.png"] : ['bald.png', "herrington.png", "semen.png"]
    property int i: 0
    Image {
        id: bgImage
        source: "bg.png"
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectCrop
        scale: 1
        SequentialAnimation {
            ScaleAnimator {
                target: bgImage
                duration: 10000
                from: 1
                to: bgScale
            }
            PauseAnimation {
                duration: 500
            }
            ScaleAnimator {
                target: bgImage
                duration: 10000
                from: bgScale
                to: 1
            }
            PauseAnimation {
                duration: 500
            }
            running: bgImage.visible === true ? true : false
            loops: Animation.Infinite
        }
        Image {
            id: bgFace
            source: picArray[i]
            fillMode: Image.PreserveAspectFit
            height: parent.height
            width: parent.width
            z: (!mainMenu.container.visible
                && !mainMenu2.container.visible) ? -1 : 1
            SequentialAnimation {
                ParallelAnimation {
                    OpacityAnimator {
                        target: bgFace
                        from: 0
                        to: 1
                        duration: 500
                    }
                    ScaleAnimator {
                        target: bgFace
                        duration: 10000
                        from: 1
                        to: bgScale
                    }
                }
                OpacityAnimator {
                    target: bgFace
                    from: 1
                    to: 0
                    duration: 500
                }
                ScriptAction {
                    script: i === 2 ? i = 0 : i++
                }

                ParallelAnimation {
                    OpacityAnimator {
                        target: bgFace
                        from: 0
                        to: 1
                        duration: 500
                    }
                    ScaleAnimator {
                        target: bgFace
                        duration: 10000
                        from: bgScale
                        to: 1
                    }
                }
                OpacityAnimator {
                    target: bgFace
                    from: 1
                    to: 0
                    duration: 500
                }
                ScriptAction {
                    script: i === 2 ? i = 0 : i++
                }

                running: bgFace.visible ? true : false
                loops: Animation.Infinite
            }
        }
    }

    Repeater {
        id: repeater
        model: newYear ? settings.intensity : 0
        delegate: Snowflake {}
    }

    Arealight {
        id: light
        anchors.verticalCenter: parent.verticalCenter
        upperBound: 0.8
        //        lightRotation: 91
        lowerBound: 0.25
        anchors.horizontalCenter: parent.horizontalCenter
        lightColor: "888888"
        width: parent.width
        height: parent.height
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

