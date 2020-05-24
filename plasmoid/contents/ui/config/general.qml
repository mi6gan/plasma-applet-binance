import QtQuick 2.0
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0

import "../../code/constants.js" as Constants

Item {
    Layout.fillWidth: true
    property string cfg_ticker
    property alias cfg_interval: interval_field.value
    Grid {
        Layout.fillWidth: true
        columns: 2
        PlasmaComponents.Label {
            text: "Ticker"
        }
        ComboBox {
            id: ticker_field
            model: Constants.tickers
            onActivated: {
                cfg_ticker = ticker_field.currentText
            }
        }

        PlasmaComponents.Label {
            text: "Interval"
        }

        SpinBox {
            id: interval_field
            from: 1
            to: 86400
            stepSize: 1
            onValueModified: {
                cfg_interval = interval_field.value
            }
            function textFromValue(value) {
                return `${value} s`;
            }
        }
    }
    Component.onCompleted: {
        cfg_ticker = plasmoid.configuration.ticker
        cfg_interval = plasmoid.configuration.interval
        ticker_field.currentIndex = ticker_field.find(cfg_ticker)
    }

}