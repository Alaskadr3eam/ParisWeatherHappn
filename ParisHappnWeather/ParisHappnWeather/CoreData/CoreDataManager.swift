//
//  CoreDataManager.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer!
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
           //Use the default container for production environment
           guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { fatalError("no coreData") }
           
           self.init(container: appDelegate.persistentContainer)
       }
    
    var all: [WeatherDetailCoreData] {
        let request: NSFetchRequest<WeatherDetailCoreData> = WeatherDetailCoreData.fetchRequest()
        guard let weatherDetailModels = try? self.persistentContainer.viewContext.fetch(request) else { return [] }
        return weatherDetailModels
    }
    
    //MARK: - Manage WeatherDetailCoreData
    //Save
    func save(forecasts: [Forecast], city: City, weatherCellModel: WeatherCellModel?) {
        let weatherDetail = WeatherDetailCoreData(context: persistentContainer.viewContext)
        weatherDetail.city = encodeCity(objet: city)
        weatherDetail.forecasts = encodeForecasts(objet: forecasts)
        weatherDetail.weatherCellModel = encodeWeatherCellModel(objet: weatherCellModel)
        
        do {
            try self.persistentContainer.viewContext.save()
            print("ok save")
        } catch {
            print("error save")
        }
    }
    
    private func encodeForecasts(objet: [Forecast]) -> [Data] {
        var forecastsData = [Data]()
        let encoder = JSONEncoder()
        for forecast in objet {
            do {
                let encoded = try encoder.encode(forecast)
                forecastsData.append(encoded)
                let str = String(decoding: encoded, as: UTF8.self)
                print(str)
            } catch {
                print(error.localizedDescription)
            }
        }
        return forecastsData
    }
    
    private func encodeCity(objet: City) -> Data {
        var objData = Data()
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(objet)
            objData = encoded
        } catch {
            print(error.localizedDescription)
        }
        return objData
    }
    
    private func encodeWeatherCellModel(objet: WeatherCellModel?) -> Data? {
        var objData = Data()
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(objet)
            objData = encoded
        } catch {
            print(error.localizedDescription)
        }
        return objData
    }
    
    //Delete
    func deleteAll(weatherCoreDataS: [WeatherDetailCoreData]) {
        weatherCoreDataS.forEach { (weatherCoreData) in
            delete(weatherCoreData: weatherCoreData)
        }
    }
    private func delete(weatherCoreData: WeatherDetailCoreData) {
        self.persistentContainer.viewContext.delete(weatherCoreData)
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            print("error supression core data")
        }
    }
}
