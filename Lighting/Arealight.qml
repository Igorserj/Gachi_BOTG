import QtQuick 2.0
import QtGraphicalEffects 1.15

Item {
    property double upperBound: 1.0
    property double lowerBound: 0.5
    property string lightColor: "bd9f55"
    property double lowerFiller: 0
    property double upperFiller: 0
    property alias horizontalRadius: light.horizontalRadius
    property alias verticalRadius: light.verticalRadius
    property alias horizontalOffest: light.horizontalOffset
    property alias verticalOffest: light.verticalOffset

    Rectangle {
        anchors.fill: parent
        //        height: room.height
        //        width: room.width
        color: "transparent"
        RadialGradient {
            id: light
            horizontalRadius: parent.width
            verticalRadius: parent.height
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: lowerBound
                    color: ("#11" + lightColor)
                }
                GradientStop {
                    position: upperBound
                    color: "black"
                }
            }
        }
    }
    Rectangle {
        anchors.bottom: parent.bottom
        height: lowerFiller
        width: parent.width
        color: "black"
    }
    Rectangle {
        anchors.top: parent.top
        height: upperFiller
        width: parent.width
        color: "black"
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.05;height:2160;width:7680}
}
##^##*/

