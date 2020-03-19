//
//  ViewController.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

class WeatherHomeVC: WeatherGenericVC {
    //MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!

    var model = WeatherHome(weatherServiceSession: WeatherService(weatherSession: URLSession(configuration: .default)))
    var manageCoreData = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createGradientLayer()
        self.showActivityIndicator(title: "Loading..")
        
        setUpViewCollectionView()
        prepareModelAndRequest()
        
        // Do any additional setup after loading the view.
    }
    //MARK: - SetupView
    private func setUpViewCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        if let layout = collectionView?.collectionViewLayout as? LayoutWeatherTile {
            layout.delegate = self as LayoutWeatherTileDelegate
        }
        collectionView.register(UINib(nibName: "WeatherTileCell", bundle: nil), forCellWithReuseIdentifier: "WeatherTileCell")
    }
    //MARK: - SetupView
    private func prepareModelAndRequest() {
        model.delegate = self
        
        model.getRequestWeather { [weak self] (bool) in
            guard let self = self else { return }
            guard bool == true else {
                self.showAlertView(title: "Error", message: "No NetWork", firstBtnTitle: "OK")
                self.hideActivityIndicator()
                return
            }
        }
    }
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.detailSegue {
            if let detailVC = segue.destination as? WeatherDetailTVC {
                detailVC.model = model.detailsTableView(at: model.index)
                detailVC.model.weatherCellModel = model.homeCell(at: model.index)
            }
        }
    }
}


    

