//
//  WeatherCellModelTest.swift
//  ParisHappnWeatherTests
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import XCTest
@testable import ParisHappnWeather

class WeatherCellModelTest: XCTestCase {
    
    var weatherCellModel: WeatherCellModel!

    override func setUp() {
        super.setUp()
        weatherCellModel = WeatherCellModel(forecast: MockObjet.createForecast())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testIconUrl() {
        let iconUrl = weatherCellModel.iconUrl
        
        XCTAssertEqual(iconUrl, "1d")
    }
    
    func testDescription() {
        let description = weatherCellModel.description
        
        XCTAssertEqual(description, "Clear")
    }
    
    func testSecondDescription() {
        let secondDescription = weatherCellModel.secondDescription
        
        XCTAssertEqual(secondDescription?.contains("C"), true)
        
    }
    
    func testAverageTemperature() {
        let temp = weatherCellModel.averageTemperature
        
        XCTAssertEqual(temp, "20°")
    }
    
    func testDate() {
        let date = weatherCellModel.date
        
        XCTAssertEqual(date, "lundi 12 janv.")
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
