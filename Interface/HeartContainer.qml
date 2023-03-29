import QtQuick 2.12

Item {
    id: heartContainer
    property string name: ""
    property var heart: ["Heart1.png","Heart2.png","Heart3.png","Heart4.png","Heart5.png"]
    property double containerWidth: 0
    property double maxHealth: 0
    property double health: 0
    property alias nameText: _nameText

Component{
    id: nameText
    Text {
        id: text
        text: name!==undefined?qsTr(name):""
        font.weight: Font.DemiBold
        font.family: "Arial"
        color: "white"
        font.pixelSize: main.windowWidth/36
    }
}

Component{
    id: column
    Column {
        Repeater {model: maxHealth!==undefined?maxHealth/100<=1?1:maxHealth/100<=2?2:maxHealth/100<=3?3:maxHealth/100<=4?4:5:0
            Row {
                id: row
                property int rowIndex: index
                Repeater { model: maxHealth/20-rowIndex*5>=5?5:Math.ceil(maxHealth/20-rowIndex*5)
                    Image {
                        property int columnIndex: index
                        id: healthIcon
                        source: (health-20*(columnIndex+row.rowIndex*5))-20>=0?heart[0]:
                                                                                (health-20*(columnIndex+row.rowIndex*5))-15>=0?heart[1]:
                                                                                                                                (health-20*(columnIndex+row.rowIndex*5))-10>=0?heart[2]:
                                                                                                                                                                                (health-20*(columnIndex+row.rowIndex*5))-5>=0?heart[3]:heart[4]
                        fillMode: Image.PreserveAspectFit
                        width: main.minimumWidth*0.04
//                        height: main.minimumHeight*0.08
                    }
                    Component.onCompleted: {containerWidth=main.minimumWidth*0.04 * model//(Math.ceil(maxHealth/20-rowIndex*5)>=5)?5:Math.ceil(maxHealth/20-rowIndex*5)
                }
                }
            }
        }
    }
}

    Loader {id: _nameText; sourceComponent: /*typeof(_dialogue.item) !== 'undefined'?undefined:*/nameText; /*onLoaded: heartContainer.contentWidth=item.contentWidth*/}
    Loader {id: _column;
        anchors.top: _nameText.bottom;
        sourceComponent: /*typeof(_dialogue.item) !== 'undefined'?undefined:*/column}
}
