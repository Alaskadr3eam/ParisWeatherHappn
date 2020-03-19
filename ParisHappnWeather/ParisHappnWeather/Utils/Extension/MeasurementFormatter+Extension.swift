//
//  MeasurementFormatter.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

extension MeasurementFormatter {
    static var temperatureFormatter: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter = NumberFormatter.temperatureFormatter
        formatter.unitStyle = .medium
        formatter.unitOptions = .temperatureWithoutUnit
        formatter.locale = Locale.frFr
        return formatter
    }
    
    func string(from value: Double) -> String {
        let measurement = Measurement(value: floor(value), unit: UnitTemperature.celsius)
        return string(from: measurement)
    }
}
