//
//  WeatherDetailTableModel.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

struct WeatherDetailTableModel {
    let forecasts: [Forecast]
    let city: City
    var weatherCellModel: WeatherCellModel?
    //with forecast
    var wind: String {
        return "\(forecasts.first?.wind.speed ?? 0) Km/h"
    }
    
    var feelLike: String {
        return "\(forecasts.first?.main.feelsLike ?? 0)°"
    }
    
    var pressure: String {
        return "\(forecasts.first?.main.pressure ?? 0) hPa"
    }
    
    var tempMax: String {
        return "max: \(tempsMax())°"
    }
    
    var tempMin: String {
        return "min: \(tempsMin())°"
    }
    
    var sunrise: String {
        DateFormatter.hourFormatter.string(from: city.sunrise)
    }
    
    var sunset: String {
        DateFormatter.hourFormatter.string(from: city.sunset)
    }
    
    var rain: String {
        return "\(forecasts.first?.rain?.the3H ?? 0) %"
    }
    
    var humidity: String {
        return "\(forecasts.first?.main.humidity ?? 0) %"
    }
    
    fileprivate func tempsMin() -> Double {
        var temp = [Double]()
        for i in 0..<forecasts.count {
            temp.append(forecasts[i].main.tempMin)
        }
        guard let tempSecure = temp.min() else { return 0.0 }
        return tempSecure
    }
    
    fileprivate func tempsMax() -> Double {
        var temp = [Double]()
        for i in 0..<forecasts.count {
            temp.append(forecasts[i].main.tempMax)
        }
        guard let tempSecure = temp.max() else { return 0.0 }
        return tempSecure
    }
}
