//
//  WeatherHomeVC+ExtensionWeatherHomeDelegate.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

extension WeatherHomeVC: WeatherHomeDelegate {
    func failReceiveWeatherData(error: NetworkError) {
        self.present(NetworkError.getAlert(error), animated: true)
    }
    
    func weReceiveWeatherData() {
        self.collectionView.reloadData()
        self.hideActivityIndicator()
    }
}
