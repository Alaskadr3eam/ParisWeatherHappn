//
//  ViewController.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

class WeatherHomeVC: WeatherGenericVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = WeatherHome(weatherServiceSession: WeatherService(weatherSession: URLSession(configuration: .default)))
    
    var manageCoreData = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageCoreData.deleteAll(weatherCoreDataS: manageCoreData.all)
        print(manageCoreData.all.count)
        self.createGradientLayer()
        self.showActivityIndicator(title: "Loading..")
        viewModel.delegate = self
        
        viewModel.getRequestWeather { (bool) in
            guard bool == true else {
                self.showAlertView(title: "Error", message: "No NetWork", firstBtnTitle: "OK")
                self.hideActivityIndicator()
                return
            }
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        if let layout = collectionView?.collectionViewLayout as? LayoutWeatherTile {
            layout.delegate = self as LayoutWeatherTileDelegate
        }
        
        collectionView.register(UINib(nibName: "WeatherTileCell", bundle: nil), forCellWithReuseIdentifier: "WeatherTileCell")
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.detailSegue {
            if let detailVC = segue.destination as? WeatherDetailTVC {
                
                detailVC.model = viewModel.detailsTableView(at: viewModel.index)
                detailVC.model.weatherCellModel = viewModel.homeCell(at: viewModel.index)
            }
        }
    }
}


    

