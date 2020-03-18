//
//  WeatherResponse.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

// MARK: - Forecast Response
struct ForecastResponse: Codable {
    let message: String?
    let cod: Int
    let cnt: Int?
    let list: [Forecast]?
    let city: City?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let messageString = try? values.decode(String.self, forKey: .message) {
            message = messageString
        } else if let messageInt = try? values.decode(Int.self, forKey: .message) {
            message = String(messageInt)
        } else {
            message = nil
        }
        if let codeInt = try? values.decode(Int.self, forKey: .cod) {
            cod = codeInt
        } else if let codeString = try? values.decode(String.self, forKey: .cod), let codeInt = Int(codeString) {
            cod = codeInt
        } else {
            cod = 200
        }
        cnt = try? values.decode(Int.self, forKey: .cnt)
        list = try? values.decode([Forecast].self, forKey: .list)
        city = try? values.decode(City.self, forKey: .city)
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int
    let sunrise, sunset: Date
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - Forecast
struct Forecast: Codable {
    let dt: Double
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let rain: Rain?
    let sys: Sys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, rain, sys
        case dtTxt = "dt_txt"
    }
    
    var dateString: String {
        let dateString = DateFormatter.createDateTime(timestamp: "\(dt)")
        return dateString
    }
    
    var dateHourString: String {
        let dtString = "\(dt)"
        return createDateTimeHour(timestamp: dtString)
    }
    
    private func createDateTimeHour(timestamp: String) -> String {
        var strDate = "undefined"
            
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
            dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "HH:MM" //Specify your format that you want
            strDate = dateFormatter.string(from: date)
        }
            
        return strDate
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}


// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}
