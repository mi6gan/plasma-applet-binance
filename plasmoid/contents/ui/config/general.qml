import QtQuick 2.0
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0

Item {
    Layout.fillWidth: true

    property string cfg_ticker: ticker_field.currentText
    property alias cfg_interval: interval_field.value

    Grid {
        Layout.fillWidth: true
        columns: 2
        PlasmaComponents.Label {
            text: "Ticker"
        }
        ComboBox {
            id: ticker_field
            model: [
                'BTC/USDT', 
                'ETH/USDT', 
                'ETH/BTC',
            ]
            onActivated: function(index) {
                cfg_ticker = ticker_field.currentText
            }
            currentIndex: ticker_field.find(cfg_ticker)
        }

        PlasmaComponents.Label {
            text: "Interval"
        }

        SpinBox {
            id: interval_field
            from: 1
            to: 86400
            stepSize: 1
            textFromValue: function(value) {
                return `${value} s`;
            }
        }
    }
}