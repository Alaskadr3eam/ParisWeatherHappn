//
//  WeatherServiceTestCase.swift
//  TestHappnTests
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import XCTest
@testable import ParisHappnWeather

class WeatherServiceTestCase: XCTestCase {

    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: TestError.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather(q: "Paris") { (weatherData,error) in
        // Then
        XCTAssertEqual(error, NetworkError.emptyData)
        XCTAssertNil(weatherData)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather(q: "Paris") { (weatherData,error) in
        // Then
        XCTAssertEqual(error, NetworkError.emptyData)
        XCTAssertNil(weatherData)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData,response: FakeResponseData.responseKO,error:
            nil))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather(q: "Paris") { (weatherData,error) in
        //Then
        XCTAssertEqual(error,NetworkError.badResponse)
        XCTAssertNil(weatherData)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherIncorrectData,response: FakeResponseData.responseOK,error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather(q: "Paris") { (weatherData,error) in
        // Then
        XCTAssertEqual(error, NetworkError.jsonDecodeFailed)
        XCTAssertNil(weatherData)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
       let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData,response: FakeResponseData.responseOK,error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather(q: "Paris") { (weatherData,error) in
        //XCTAssertEqual(FakeResponseData.weatherCorrectData, weatherData)
        XCTAssertNil(error)
        XCTAssertEqual(weatherData!.city?.name, "Paris")
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData2() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherIncorrectData,response: FakeResponseData.responseOK,error: TestError.error))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather(q: "Paris") { (weatherData,error) in
        //XCTAssertEqual(FakeResponseData.weatherCorrectData, weatherData)
        XCTAssertNil(weatherData)
        XCTAssertNotNil(error)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
