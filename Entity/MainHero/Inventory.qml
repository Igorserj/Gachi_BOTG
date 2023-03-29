import QtQuick 2.15

Item {
    property bool topVisible: true
    property bool midVisible: true
    property bool botVisible: true
    Rectangle {
        color: "#88000000"
        anchors.fill: parent
    }
    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#CC888888"
        height: 0.8 * parent.height
        width: 0.8 * parent.width
        radius: height / 8
        clip: true
        Rectangle {
            id: heroBlock
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 0.35 * parent.width
            radius: height / 10
            Column {
                spacing: height / 10
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                height: childrenRect.height
                Rectangle {
                    id: semenTop
                    height: heroBlock.height * 0.16
                    width: height
                    color: topArea.containsMouse ? "#66000000" : "#33000000"
                    border.width: 0
                    radius: height / 8
                    Rectangle {
                        color: topVisible ? "#3300FF00" : "#33FF0000"
                        border.width: 0
                        anchors.fill: parent
                        radius: height / 8
                        Image {
                            source: "Top.png"
                            anchors.fill: parent
                            anchors.margins: 6
                            fillMode: Image.PreserveAspectFit
                        }
                        MouseArea {
                            id: topArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                topVisible = !topVisible
                            }
                        }
                    }
                }
                Rectangle {
                    id: semenMid
                    height: heroBlock.height * 0.16
                    width: height
                    color: midArea.containsMouse ? "#66000000" : "#33000000"
                    border.width: 0
                    radius: height / 8
                    Rectangle {
                        color: midVisible ? "#3300FF00" : "#33FF0000"
                        border.width: 0
                        anchors.fill: parent
                        radius: height / 8
                        Image {
                            source: "Mid.png"
                            anchors.fill: parent
                            anchors.margins: 6
                            fillMode: Image.PreserveAspectFit
                        }
                        MouseArea {
                            id: midArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                midVisible = !midVisible
                            }
                        }
                    }
                }
                Rectangle {
                    id: semenBot
                    height: heroBlock.height * 0.16
                    width: height
                    color: botArea.containsMouse ? "#66000000" : "#33000000"
                    border.width: 0
                    radius: height / 8
                    Rectangle {
                        color: botVisible ? "#3300FF00" : "#33FF0000"
                        border.width: 0
                        anchors.fill: parent
                        radius: height / 8
                        Image {
                            source: "Bot.png"
                            anchors.fill: parent
                            anchors.margins: 6
                            fillMode: Image.PreserveAspectFit
                        }
                        MouseArea {
                            id: botArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                botVisible = !botVisible
                            }
                        }
                    }
                }
            }

            Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 30
                width: 30
                height: 30
                color: "transparent"
                border.width: 2
                radius: width / 4
                Text {
                    //                    anchors.fill: parent
                    anchors.centerIn: parent
                    height: parent.height
                    width: parent.width
                    fontSizeMode: Text.Fit
                    font.pointSize: 72
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "×"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        inventory.item.opacity = 0
                        inventory.item.enabled = false
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.66;height:720;width:1280}
}
##^##*/

