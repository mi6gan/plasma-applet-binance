import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

import "../code/constants.js" as Constants

Item {
    Layout.minimumWidth: 140
    Layout.minimumHeight: 30
    Row {
        width: parent.width
        height: parent.height
        spacing: 5
        Label {
            id: output
            width: 0.7 * parent.width
            height: parent.height
            minimumPointSize: 10
            font.pointSize: 100
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            leftPadding: 5;
        }
        Column {
            width: 0.3 * parent.width
            height: output.contentHeight
            y: (output.height - output.contentHeight) / 2
            Label {
                id: baseSymbol
                width: parent.width
                height: parent.height / 2
                minimumPointSize: 10
                font.pointSize: 100
                fontSizeMode: Text.Fit
                font.weight: Font.Bold
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignBottom;
                rightPadding: 5
              }
              Label {
                id: quoteSymbol 
                width: parent.width
                height: parent.height / 2
                minimumPointSize: 10
                font.pointSize: 100
                fontSizeMode: Text.Fit
                font.weight: Font.Bold
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignTop;
                rightPadding: 5
            }
        }
    }
    Timer {
        id: timer
        repeat: true
        running: true
        triggeredOnStart: true
        interval: plasmoid.configuration.interval * 1000
        onTriggered: {
            const api = 'https://api.binance.com/api/v3/ticker/price'
            const currencies = plasmoid.configuration.ticker.split('/')
            const base = currencies[0];
            const quote = currencies[1];
            baseSymbol.text = base
            baseSymbol.color = Constants.colors[base]
            quoteSymbol.text = quote
            quoteSymbol.color = Constants.colors[quote]
            const url = `${api}?symbol=${base}${quote}`
            const xhr = new XMLHttpRequest()
            xhr.onload = () => {
                const { price } = JSON.parse(xhr.responseText);
                output.text = `${price}`.replace(/(\.?)0+$/g, '')
                delete xhr.onload
            }
            xhr.open('GET', url)
            xhr.send('')
        }

    }
    Connections {
        target: plasmoid.configuration
        onIntervalChanged: {
            output.text = '';
            timer.restart();
        }
        onTickerChanged: {
            output.text = '';
            timer.restart();
        }
    }
}