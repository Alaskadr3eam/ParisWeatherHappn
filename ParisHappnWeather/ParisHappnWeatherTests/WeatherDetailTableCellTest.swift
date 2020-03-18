//
//  WeatherDetailTableCellTest.swift
//  TestHappnTests
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import XCTest
@testable import ParisHappnWeather

class MockForecast {
    
    static func createForecasts() -> [Forecast] {
        let main = MainClass(temp: 20.0, feelsLike: 20.0, tempMin: 20.0, tempMax: 20.0, pressure: 1020, seaLevel: 1045, grndLevel: 1030, humidity: 50, tempKf: 30.2)
        let weather = Weather(id: 50, main: .clear, weatherDescription: "clear", icon: "1d")
        let clouds = Clouds(all: 20)
        let wind = Wind(speed: 10.0, deg: 5)
        let sys = Sys(pod: .d)
        let forecast1 = Forecast(dt: 1025012.0, main: main, weather: [weather], clouds: clouds, wind: wind, rain: nil, sys: sys, dtTxt: "2020-03-23 09:00:00")
        let forecast2 = Forecast(dt: 1025012.0, main: main, weather: [weather], clouds: clouds, wind: wind, rain: nil, sys: sys, dtTxt: "2020-03-24 09:00:00")
        return [forecast1,forecast2]
        
    }
    static func createCity() -> City {
        let coord = Coord(lat: 4.53, lon: 2.30)
        let sunrise = Date(timeIntervalSince1970: 12365480.0)
        let sunset = Date(timeIntervalSince1970: 10005480.0)
        let city = City(id: 5, name: "Paris", coord: coord, country: "France", population: 150000, timezone: 123580, sunrise: sunrise, sunset: sunset)
        return city
    }
}
class WeatherDetailTableCellTest: XCTestCase {

    var weatherDetail: WeatherDetailTableModel!
    
    override func setUp() {
        super.setUp()
        weatherDetail = WeatherDetailTableModel(forecasts: MockForecast.createForecasts(), city: MockForecast.createCity(), weatherCellModel: nil)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testWind() {
        let wind = weatherDetail.wind
        
        XCTAssertEqual(wind, "10.0 Km/h")
    }
    
    func testFeelLike() {
        let feelLike = weatherDetail.feelLike
        
        XCTAssertEqual(feelLike, "20.0°")
    }
    
    func testPressure() {
        let pressure = weatherDetail.pressure
        
        XCTAssertEqual(pressure, "1020 hPa")
    }
    
    func testTempMax() {
        let tempMax = weatherDetail.tempMax
        
        XCTAssertEqual(tempMax, "max: 20.0°")
    }
    
    func testTempMin() {
        let tempMin = weatherDetail.tempMin
        
        XCTAssertEqual(tempMin, "min: 20.0°")
    }
    
    func testSunrise() {
        let sunrise = weatherDetail.sunrise
        
        XCTAssertEqual(sunrise, "03:51")
    }
    
    func testSunset() {
        let sunset = weatherDetail.sunset
        
        XCTAssertEqual(sunset, "20:18")
    }
    
    func testRain() {
        let rain = weatherDetail.rain
        
        XCTAssertEqual(rain, "0.0 %")
    }
    
    func testHumidity() {
        let humidity = weatherDetail.humidity
        
        XCTAssertEqual(humidity, "50 %")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
