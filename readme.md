# QML 画面直播

> Direct broadcast by qml, only video, not sound.

1. 使用 `Camera` 将捕获的画面传送给 `VideoOutput` 展示

2. 用 `Item2Base64` 将 `VideoOutput` 的画面处理成 `base64`

3. 使用 `WebSocket` 将 `base64` 的画面数据发送给 `WebSocket` 服务器。这里使用 `wss://echo.websocket.org` 来处理

4. 将 `wss://echo.websocket.org` 传送回来的 `base64` 数据赋值给 `Image` 展示，完成画面直播。

> PS：开心就好
