//
//  WeatherHomeVC+ExtensionWeatherHomeDelegate.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

extension WeatherHomeVC: WeatherHomeDelegate {
    func failReceiveWeatherData(error: NetworkError) {
        DispatchQueue.main.async {
            self.present(NetworkError.getAlert(error), animated: true)
        }
    }
    
    func weReceiveWeatherData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.hideActivityIndicator()
        }
    }
    
}
