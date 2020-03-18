//
//  WeatherHomeModel.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

protocol WeatherHomeDelegate {
    func weReceiveWeatherData()
    func failReceiveWeatherData(error: NetworkError)
}

class WeatherHome {
    //MARK: - Properties
    //coreData
    var manageCoreData = CoreDataManager()
    ///cell home
    var weatherCellModels: [WeatherCellModel]
    ///detail view
    var weatherDetailTableModels: [WeatherDetailTableModel]
    var weatherData: ForecastResponse?
    //transition
    var index = Int()
    var weatherCellTransit: WeatherCellModel?
    //session
    private var weatherServiceSession = WeatherService(weatherSession: URLSession(configuration: .default))
    
    var delegate : WeatherHomeDelegate?
    
    init(weatherServiceSession: WeatherService) {
        self.weatherServiceSession = weatherServiceSession
        self.weatherDetailTableModels = []
        self.weatherCellModels = []
    }
    
    fileprivate func success(_ forecast: ForecastResponse) {
        var onedayList: [[Forecast]] = []
        let dictionary = Dictionary(grouping: forecast.list!) { $0.dateString }
        dictionary.forEach { (key, list) in
            onedayList.append(list)
        }
        self.weatherCellModels = onedayList.map{
            if $0.count == 8 {
               return WeatherCellModel(forecast: $0[3])
            } else {
               return WeatherCellModel(forecast: $0.first!)
            }
        }
        self.weatherCellModels.sort {$0.dateDouble < $1.dateDouble}
        self.weatherDetailTableModels = onedayList.map{ WeatherDetailTableModel(forecasts: $0, city: forecast.city!) }
        self.weatherDetailTableModels.sort { $0.forecasts.first!.dt < $1.forecasts.first!.dt }
        DispatchQueue.main.async {
            for weatherDetailTableModel in self.weatherDetailTableModels {
                self.manageCoreData.save(forecasts: weatherDetailTableModel.forecasts, city: weatherDetailTableModel.city, weatherCellModel: nil)
            }
            
        }
        self.delegate?.weReceiveWeatherData()
    }
    
    fileprivate func failure(error: NetworkError) {
        self.manageCoreData.deleteAll(weatherCoreDataS: self.manageCoreData.all)
        transformWeatherDetailCoreDataInWeatherDetailTableModel(weatherDetailCoreDate: self.manageCoreData.all)
        self.delegate?.failReceiveWeatherData(error: error)
    }
    
    func getRequestWeather(completionHandler: @escaping(Bool?) -> Void) {
        weatherServiceSession.getWeather(q: Constant.city) { (weatherData, error) in
            guard error == nil else {
                self.failure(error: error!)
                completionHandler(false)
                return
            }
            guard weatherData != nil else {
                self.failure(error: error!)
                completionHandler(false)
                return
            }
            completionHandler(true)
            self.success(weatherData!)
        }
    }
    
    private func transformWeatherDetailCoreDataInWeatherDetailTableModel(weatherDetailCoreDate: [WeatherDetailCoreData]) {
        weatherDetailCoreDate.forEach { (weatherDetailData) in
            let decoded = decodeWeatherCoreData(weatherDetailData)
            guard let decodedSecure = decoded else {
                print("error decode core Data WeatherHome")
                return
            }
            self.weatherDetailTableModels.append(decodedSecure)
        }
        /*for weatherDetailData in weatherDetailCoreDate {
           let decoded = decodeWeatherCoreData(weatherDetailData)
            guard let decodedSecure = decoded else {
                print("error decode core Data WeatherHome")
                return
            }
            self.weatherDetailTableModels.append(decodedSecure)
        }*/
    }
    
    private func decodeWeatherCoreData(_ object: WeatherDetailCoreData) -> WeatherDetailTableModel? {
        guard let forecastsDataSecure = object.forecasts else { return nil }
        let forecasts = decodeForecastData(forecastsData: forecastsDataSecure)
        guard let cityDataSecure = object.city else { return nil }
        let city = decodeCityData(cityData: cityDataSecure)
        let weatherDetailTableModel = WeatherDetailTableModel(forecasts: forecasts, city: city, weatherCellModel: nil)
        return weatherDetailTableModel
    }
    
    private func decodeCityData(cityData: Data) -> City {
        var city: City?
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(City.self, from: cityData)
            city = decoded
        } catch {
            print(error.localizedDescription)
        }
        return city!
    }
    
    private func decodeForecastData(forecastsData: [Data]) -> [Forecast] {
        var forecasts = [Forecast]()
        let decoder = JSONDecoder()
        for forecast in forecastsData {
            do {
                let decoded = try decoder.decode(Forecast.self, from: forecast)
                forecasts.append(decoded)
            } catch {
                print(error.localizedDescription)
            }
        }
        return forecasts
    }
}

extension WeatherHome {
    func homeCell(at index: Int) -> WeatherCellModel {
        self.weatherCellModels[index]
    }
    
    func detailsTableView(at index: Int) -> WeatherDetailTableModel {
        self.weatherDetailTableModels[index]
    }
}
