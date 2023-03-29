import QtQuick 2.15
import QtQuick.Window 2.15
import "Interface/"

Window {
    id: main
    property int windowHeight: 720
    property int windowWidth: 1280
    property double k: screen.width / screen.height
    property alias attention: attention
    property alias pageLoader: pageLoader
    //    property alias comfortaa: comfortaa
    //    property alias lora: lora
    //    property alias overpass: overpass
    property string version: "0.13.6"
    property date currentDate: new Date()
    width: minimumWidth
    height: minimumHeight
    minimumWidth: windowWidth
    minimumHeight: windowHeight
    maximumWidth: windowWidth
    maximumHeight: windowHeight
    title: qsTr("Gachi: Boss of this Gym ")

    FontLoader {
        id: comfortaa
        name: "Comfortaa"
        source: "Fonts/Comfortaa/Comfortaa-VariableFont_wght.ttf"
    }
    FontLoader {
        id: lora
        name: "Lora"
        source: "Fonts/Lora/Lora-VariableFont_wght.ttf"
    }
    FontLoader {
        id: overpass
        name: "Overpass"
        source: "Fonts/Overpass/Overpass-VariableFont_wght.ttf"
    }
    Rectangle {
        id: filler
        color: "black"
        anchors.fill: parent
    }

    PageLoader {
        id: pageLoader
        width: k < 16 / 9 ? windowWidth : k > 16 / 9 ? windowHeight / 9 * 16 : windowWidth
        height: k < 16 / 9 ? windowWidth / 16 * 9 : k > 16 / 9 ? windowHeight : windowHeight
        focus: true
        anchors.verticalCenter: filler.verticalCenter
        anchors.horizontalCenter: filler.horizontalCenter
        clip: true
    }
    Attention {
        id: attention
        anchors.fill: parent
    }
}
