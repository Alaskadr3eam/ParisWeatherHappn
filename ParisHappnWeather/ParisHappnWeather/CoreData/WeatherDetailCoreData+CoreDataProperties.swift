//
//  WeatherDetailCoreData+CoreDataProperties.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherDetailCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDetailCoreData> {
        return NSFetchRequest<WeatherDetailCoreData>(entityName: "WeatherDetailCoreData")
    }

    @NSManaged public var forecasts: [Data]?
    @NSManaged public var city: Data?
    @NSManaged public var weatherCellModel: Data?

}
