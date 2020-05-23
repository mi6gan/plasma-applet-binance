import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0

Item {
    Layout.minimumWidth: 40
    Layout.minimumHeight: 30
    Label {
        id: output
        width: parent.width
        height: parent.height
        font.pointSize: 100
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        padding: 20
    }
    Timer {
        id: timer
        interval: plasmoid.configuration.interval * 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            const api = 'https://api.binance.com/api/v3/ticker/price'
            const currencies = plasmoid.configuration.ticker.split('/')
            const base = currencies[0];
            const quote = currencies[1];
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