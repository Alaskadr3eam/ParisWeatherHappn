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
        if Calendar.current.isDateInToday(self.forecast.dt.dateFormattedReturnDate!) {
            return "Aujourd'hui"
        } else {
            return DateFormatter.weekdayDateFormatter.string(from: self.forecast.dt.dateFormattedReturnDate!)
        }
    }
    
    var dateDouble: Double {
        return self.forecast.dt
    }
}
