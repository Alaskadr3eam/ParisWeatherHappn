//
//  WeatherCellModel.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

struct WeatherCellModel: Codable {
    var forecast: Forecast
}

extension WeatherCellModel {
    
    var iconUrl: String? {
        return self.forecast.weather.first?.icon
    }
    
    var description: String? {
        return self.forecast.weather.first?.weatherDescription.capitalized
    }
    
    var secondDescription: String? {
        return "Chance of rain: \(NumberFormatter.percentFormatter.string(from: NSNumber(value: self.forecast.rain?.the3H ?? 0)) ?? "0 %")"
    }
    
    var averageTemperature: String? {
        return MeasurementFormatter.temperatureFormatter.string(from: self.forecast.main.temp)
    }
    
    var date: String? {
        guard let dateSecure = self.forecast.dt.dateFormattedReturnDate else { return "undefined" }
        if Calendar.current.isDateInToday(dateSecure) {
            return "Aujourd'hui"
        } else {
            return DateFormatter.weekdayDateFormatter.string(from: dateSecure)
        }
    }
    
    var dateDouble: Double {
        return self.forecast.dt
    }
}
