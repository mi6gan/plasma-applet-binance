import QtQuick 2.4
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

Item {
    Layout.minimumWidth: 250
    Layout.minimumHeight: 90
    PlasmaComponents.Label {
        id: output
        width: parent.width
        height: parent.height
        font.pointSize: 100
        fontSizeMode: Text.Fit
    }
    Timer {
        interval: 10 * 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            const api = 'https://api.binance.com/api/v3/ticker/price'
            const base = 'BTC'
            const quote = 'USDT'
            const url = `${api}?symbol=${base}${quote}`
            const xhr = new XMLHttpRequest()
            xhr.onload = () => {
                const { price } = JSON.parse(xhr.responseText);
                output.text = `${`${price}`.replace(/(\.?)0+$/g, '')} ${base} / ${quote}`
                delete xhr.onload
            }
            xhr.open('GET', url)
            xhr.send('')
        }

    }
}