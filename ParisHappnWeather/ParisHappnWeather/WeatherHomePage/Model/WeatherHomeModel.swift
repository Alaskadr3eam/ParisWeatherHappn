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
    //transition
    var index = Int()
    //session
    private var weatherServiceSession = WeatherService(weatherSession: URLSession(configuration: .default))
    
    var delegate : WeatherHomeDelegate?
    
    deinit {}
    
    init(weatherServiceSession: WeatherService) {
        self.weatherServiceSession = weatherServiceSession
        self.weatherDetailTableModels = []
        self.weatherCellModels = []
    }
    //MARK: - Function Success
    fileprivate func success(_ forecast: WeatherResponse) {
        var onedayList: [[Forecast]] = []
        guard let listF = forecast.list else { return }
        let dictionary = Dictionary(grouping: listF) { $0.dateString }
        dictionary.forEach { (key, list) in
            onedayList.append(list)
        }
        self.weatherCellModels = onedayList.map { WeatherCellModel(forecast: $0[($0.count - 1) / 2]) }
        self.weatherCellModels.sort {$0.dateDouble < $1.dateDouble}
        guard let citySecure = forecast.city else { return }
        self.weatherDetailTableModels = onedayList.map{ WeatherDetailTableModel(forecasts: $0, city: citySecure) }
        self.weatherDetailTableModels.sort { $0.forecasts.first!.dt < $1.forecasts.first!.dt }
        DispatchQueue.main.async {
            //delete coreData before reSave last data
            self.manageCoreData.deleteAll(weatherCoreDataS: self.manageCoreData.all)
            for weatherDetailTableModel in self.weatherDetailTableModels {
                self.manageCoreData.save(forecasts: weatherDetailTableModel.forecasts, city: weatherDetailTableModel.city, weatherCellModel: nil)
            }
            self.delegate?.weReceiveWeatherData()
        }
    }
    //MARK: - Function Failure
    func failure(error: NetworkError) {
        DispatchQueue.main.async {
            let localDB = self.manageCoreData.all
            self.transformWeatherDetailCoreDataInWeatherDetailTableModel(weatherDetailCoreDate: localDB)
            if localDB.count > 0 {
                self.prepareModelForDisplayWithDB()
                self.delegate?.weReceiveWeatherData()
                return
            }
            self.delegate?.failReceiveWeatherData(error: error)
        }
    }
    ///func for add data db in model if no network
    private func prepareModelForDisplayWithDB() {
        for weatherDataDetail in self.weatherDetailTableModels {
            let middle = (weatherDataDetail.forecasts.count - 1)/2
            let weatherCellModel = WeatherCellModel(forecast: weatherDataDetail.forecasts[middle])
            self.weatherCellModels.append(weatherCellModel)
        }
    }
    //MARK: - Function Request
    func getRequestWeather(completionHandler: @escaping(Bool?) -> Void) {
        weatherServiceSession.getWeather(q: Constant.city) { [weak self] (weatherData, error) in
            guard let self = self else { return }
            guard error == nil else {
                self.failure(error: error!)//error never nil => ! Secure
                completionHandler(false)
                return
            }
            self.success(weatherData!)//weatherData never nil => Secure
            completionHandler(true)
        }
    }
    //MARK: - Function Decode Data
    private func transformWeatherDetailCoreDataInWeatherDetailTableModel(weatherDetailCoreDate: [WeatherDetailCoreData]) {
        weatherDetailCoreDate.forEach { (weatherDetailData) in
            let decoded = decodeWeatherCoreData(weatherDetailData)
            guard let decodedSecure = decoded else {
                print("error decode core Data WeatherHome")
                return
            }
            self.weatherDetailTableModels.append(decodedSecure)
        }
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
    //MARK: - Function Selection Cell model or DetailModel
    func homeCell(at index: Int) -> WeatherCellModel {
        self.weatherCellModels[index]
    }
    
    func detailsTableView(at index: Int) -> WeatherDetailTableModel {
        self.weatherDetailTableModels[index]
    }
}


