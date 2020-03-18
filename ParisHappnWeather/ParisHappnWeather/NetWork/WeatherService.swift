//
//  WeatherService.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

class WeatherService {
    
    private var weatherSession = URLSession(configuration: .default)
    
    init(weatherSession: URLSession) {
       
        self.weatherSession = weatherSession
    }
    
    var task: URLSessionDataTask?
    
    private var arguments: [String: String] =
        ["q": String(),
         "APPID": Constant.apiKeyWeather,
         "units": Constant.unit,
         "lang": Constant.lang
    ]
    
    func getWeather(q: String, completionHandler: @escaping (ForecastResponse?,NetworkError?) -> Void) {
        arguments["q"] = q
        guard var request = ServiceCreateRequest.createRequest(url: Constant.weatherUrl, arguments: arguments) else { return }
        request.httpMethod = "GET"
        task?.cancel()
        task = weatherSession.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, NetworkError.emptyData)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, NetworkError.badResponse)
                return
            }
            guard let weatherData = try? JSONDecoder().decode(ForecastResponse.self, from: data) else {
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                return
            }
            completionHandler(weatherData, nil)
        }
        task?.resume()
    }
    
    
}
