import QtQuick 2.6
import QtQuick.Controls 2.1
import QtMultimedia 5.8
import QtWebSockets 1.1

ApplicationWindow {
    visible: true
    width: 360
    height: 640
    title: qsTr("Direct broadcast by qml")

    Camera {
        id: camera

        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

        exposure {
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }

        flash.mode: Camera.FlashRedEyeReduction
    }

    VideoOutput {
        id: videoOutput
        source: camera
        anchors.fill: parent
        focus : visible // to receive focus and capture key events when visible
        visible: false
    }

    property int catchWidth: 30
    property int catchHeight: 30

    Item2Base64 {
        id: image2Base64
        width: catchWidth
        height: catchHeight
        onDumpBase64: {
//            console.log("url:", url, "data length:", dataUrl.length);
            webSocket.sendTextMessage(dataUrl);
        }
    }

    Image {
        id: showBase64Image
        width: catchWidth * 4
        height: catchHeight * 4
    }

    WebSocket {
        id: webSocket
        // Or set your echo web socket server url
        url: "wss://echo.websocket.org"
        active: true
        onStatusChanged: {
            console.log(webSocket.status);
        }
        onTextMessageReceived: {
//            console.log("receive data: lenght:", message.length);
            showBase64Image.source = message;
        }
    }

    Timer {
        interval: 250
        repeat: true
         running: true
        onTriggered: {
            videoOutput.grabToImage(function(result){
                image2Base64.toBase64(result.url);
            }, Qt.size(catchWidth, catchHeight));
        }
    }


}
