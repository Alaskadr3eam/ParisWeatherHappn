//
//  WeatherDetailPageTVC.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit
import MapKit

class WeatherDetailTVC: UITableViewController {
    //MARK: - Properties
    @IBOutlet weak var viewDetail: DetailView!
    //section1
    @IBOutlet weak var locationMapCity: MKMapView!
    //section2
    @IBOutlet weak var collectionWeatherView: UICollectionView!
    //section3
    //label
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    var model: WeatherDetailTableModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constant.configureTilteTextNavigationBar(view: self, title: model.weatherCellModel?.date ?? "Undefined")
        
        setUpView(model: model)
        setUpTableView()
        setUpCollectionView()
        setUpMapKit()
    }
    //MARK: - SetupView
    private func setUpView(model: WeatherDetailTableModel) {
        sunriseLabel.text = model.sunrise
        sunsetLabel.text = model.sunset
        rainLabel.text = model.rain
        humidityLabel.text = model.humidity
        pressureLabel.text = model.pressure
        windLabel.text = model.wind
        feelLikeLabel.text = model.feelLike
        viewDetail.configureDetailView(model: model)
    }
    
    private func setUpTableView() {
        tableView.backgroundColor = .clear
        setTableViewBackgroundGradient(sender: self)
        tableView.allowsSelection = false
    }
    
    private func setUpCollectionView() {
        collectionWeatherView.delegate = self
        collectionWeatherView.dataSource = self
        collectionWeatherView.backgroundColor = .clear
        collectionWeatherView.register(UINib(nibName: "WeatherTileCell", bundle: nil), forCellWithReuseIdentifier: "WeatherTileCell")
    }
    
    private func setUpMapKit() {
        locationMapCity.delegate = self
        initLocMapView()
    }
    //MARK: - Design
    ///func for add gradient background
    private func setTableViewBackgroundGradient(sender: UITableViewController) {
        var gradientBackgroundColors: [CGColor] = []
        if #available(iOS 11.0, *) {
            guard let color1 = UIColor(named: "color1") else { return }
            guard let color2 = UIColor(named: "color2") else { return }
            gradientBackgroundColors = [color1.cgColor, color2.cgColor]
        } else {
            // Fallback on earlier versions
            gradientBackgroundColors = [UIColor(displayP3Red: 0.253, green: 0.569, blue: 0.721, alpha: 1).cgColor, UIColor(displayP3Red: 0.315, green: 0.694, blue: 0.805, alpha: 1).cgColor]
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.frame = sender.tableView.bounds
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.tableView.backgroundView = backgroundView
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}
