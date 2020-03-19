//
//  WeatherHomeTestCase.swift
//  TestHappnTests
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import XCTest
import CoreData
@testable import ParisHappnWeather

class WeatherHomeTestCase: XCTestCase {
    
    var weatherHome: WeatherHome!
    

    override func setUp() {
        super.setUp()
        weatherHome = WeatherHome(weatherServiceSession: WeatherService(weatherSession: URLSession(configuration: .default)))
        weatherHome.manageCoreData = CoreDataManager(container: mockPersistantContainer)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testFuncFailure() {
        
        weatherHome.failure(error: .badResponse)
        
        XCTAssertEqual(weatherHome.weatherCellModels.count,0)
    }
    
    func testFuncFailure2() {
        weatherHome.manageCoreData.save(forecasts: MockObjet.createForecasts(), city: MockObjet.createCity(), weatherCellModel: nil)
        
        weatherHome.failure(error: .badResponse)
        
        XCTAssertEqual(weatherHome.weatherCellModels.count,0)
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
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ParisHappnWeather")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()

}
