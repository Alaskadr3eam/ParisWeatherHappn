//
//  WeatherHomeVC+ExtensionLayout.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

extension WeatherHomeVC: LayoutWeatherTileDelegate {
    func numberOfColumn() -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let screenDeviceSE = CGRect(x: 0.0, y: 0.0, width: 640.0, height: 1136.0)
        if UIScreen.main.nativeBounds.width > screenDeviceSE.width {
             return (collectionView.bounds.height - 60 ) / 3
        }
        return (collectionView.bounds.height - 60 ) / 2
    }
}
