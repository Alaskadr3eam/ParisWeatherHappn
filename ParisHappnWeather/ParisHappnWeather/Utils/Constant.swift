//
//  Constant.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    // MARK: - PROPERTIES WEATHER
    static let weatherUrl = URL(string: "http://api.openweathermap.org/data/2.5/forecast")!
    static let apiKeyWeather = "2567298816d0d1f85b5a7edfdc58aa63"
    static let city = "Paris"
    //static let dataWeatherHoliday = [WeatherHoliday]()
    static let unit = "metric"
    static let lang = "fr"
    //MARK: - Segue
    static let detailSegue = "Detail"
    //MARK: - Config TitleNavBar
    static func configureTilteTextNavigationBar(view: UIViewController,title: String) {
        view.navigationItem.title = title
    }
}
