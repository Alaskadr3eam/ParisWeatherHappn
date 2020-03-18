//
//  WeatherHomeVC+ExtensionCollectionViewDelegate.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

extension WeatherHomeVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weatherCellModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherTileCell", for: indexPath) as! WeatherTileCell
        cell.model = viewModel.homeCell(at: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.index = indexPath.row
        performSegue(withIdentifier: Constant.detailSegue, sender: nil)
        print("clicked")
    }

}
