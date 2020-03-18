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
        return (collectionView.bounds.height - 60 ) / 3
    }
    
    
}
