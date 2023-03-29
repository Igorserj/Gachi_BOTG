import QtQuick 2.12
import QtGraphicalEffects 1.15

Rectangle {
    id: button
    property string text: ""
    color: "#77000000"
    border.width: 5
    border.color: "white"
    height: 0.1 * pageLoader.height
    width: height
    x: pageLoader.width - width * 1.25 - levelName.x
    y: pageLoader.height - height * 1.25 - levelName.y
    z: typeof (_dialogue) != 'undefined' ? _dialogue.z + 1 : room.z + 1
    visible: false

    Text {
        id: text
        anchors.fill: parent
        text: button.text
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        minimumPixelSize: 10
        fontSizeMode: Text.Fit
        font.weight: Font.Bold
        font.family: "Arial"
        font.pixelSize: 100
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            button.text === "E" ? mainHero.keyE(
                                      ) : button.text === "⎵" ? mainHero.keySpace(
                                                                    ) : {}
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:6;height:480;width:640}
}
##^##*/

