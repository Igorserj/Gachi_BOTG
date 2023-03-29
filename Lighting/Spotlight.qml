import QtQuick 2.15

Item {
    property double upperBound: 1.0
    property double lowerBound: 0.5
    property string lightColor: "bd9f55"
    property int lightRotation: 0

    //    property double posX: parent.width / 2
    //    property double posY: 0
    Rectangle {
        width: parent.height < parent.width ? parent.width : parent.height
        height: width
        border.width: 0
        //        x: posX - width / 2
        //        y: posY
        //        scale: 1.5
        rotation: 135 + lightRotation
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
    Rectangle {
        width: parent.height < parent.width ? parent.width : parent.height
        height: width
        //        scale: 1.5
        border.width: 0
        //        x: posX - width / 2
        //        y: posY
        rotation: 225 - lightRotation
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

/*##^##
Designer {
    D{i:0;formeditorZoom:0.05;height:2160;width:7680}
}
##^##*/

