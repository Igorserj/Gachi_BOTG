import QtQuick 2.12
import QtGraphicalEffects 1.15
import "../Controls"

Item {
    Image {
        id: img
        source: "../Loading/Gachi.png"
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }
    FastBlur {
        anchors.fill: img
        source: img
        radius: 24
        cached: true
    }
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: 0.5 * parent.height
        color: "transparent"
        Text {
            id: txt
            text: qsTr("Рівень 1 закінчено\n Дякую за гру!\nДалі буде")
            height: parent.height * 0.9
            width: parent.width * 0.9
            color: "white"
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            padding: 10
            font.weight: Font.DemiBold
            font.family: "Comfortaa"
            fontSizeMode: Text.VerticalFit
            minimumPixelSize: 10
            font.pixelSize: 72
        }
        Glow {
            anchors.fill: txt
            radius: 16
            samples: 32
            spread: 0.3
            color: "#80000000"
            source: txt
            cached: true
        }
    }
    //    Rectangle {
    //        height: parent.height * 0.05
    //        width: parent.width
    //        color: "transparent"
    //        anchors.bottom: parent.bottom
    //        Text {
    //            text: "Назад"
    //            height: parent.height * 0.9
    //            width: parent.width * 0.9
    //            color: mouseArea.containsMouse ? "#888888" : "white"
    //            horizontalAlignment: Text.AlignRight
    //            verticalAlignment: Text.AlignVCenter
    //            padding: 10
    //            font.weight: Font.DemiBold
    //            font.family: "Comfortaa"
    //            fontSizeMode: Text.VerticalFit
    //            minimumPixelSize: 10
    //            font.pixelSize: 72
    //        }
    //        MouseArea {
    //            id: mouseArea
    //            anchors.fill: parent
    //            hoverEnabled: true
    //            onClicked: {
    //                saver.localSaving()
    //                pageLoader.source = "../Main_menu/MainMenu.qml"
    //            }
    //        }
    //    }
    Button3 {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Назад"
        buttonArea.onClicked: {
            saver.localSaving()
            pageLoader.source = "../Main_menu/MainMenu.qml"
        }
    }
}
