//
//  WeatherTileCell.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

class WeatherTileCell: UICollectionViewCell {
    //MARK: - Properties
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var iconWeather: UIImageView!
    @IBOutlet weak var labelTemp: UILabel!
    //for shadow
    @IBOutlet weak var shadow: UIView!
    //for containView
    @IBOutlet weak var containView: UIView!
    
    var model: WeatherCellModel! {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelDay.font = UIFont.boldSystemFont(ofSize: 20)
        labelDescription.font = UIFont.systemFont(ofSize: 15)
        labelTemp.font = UIFont.boldSystemFont(ofSize: 20)
    }
    //MARK: - Configure cell home
    private func configureCell() {
        addShadowForCell(shadow: shadow)
        addCornerRadiusContainView(containView: containView)
        self.labelDay.text = model.date
        self.labelTemp.text = model.averageTemperature
        if model.date == "Aujourd'hui" {
            self.containView.backgroundColor = .systemYellow
        }
        guard let descriptionSecure = model.description, let weatherSecure = model.forecast.weather.first else { return }
        self.labelDescription.text = descriptionSecure
        self.iconWeather.image = UIImage(named: weatherSecure.icon)
    }
    //MARK: - Configure Detail
    func configureDetailModel(forecast: Forecast) {
        labelDay.text = forecast.dateHourString
        labelDescription.isHidden = true
        self.labelTemp.text = "\(forecast.main.temp)°"
        containView.backgroundColor = .clear
        shadow.backgroundColor = .clear
        guard let weatherSecure = forecast.weather.first else { return }
        iconWeather.image = UIImage(named: weatherSecure.icon)
    }
    //MARK: - Function Design
    ///func is possible in extension uiview for REFACTO
    private func addShadowForCell(shadow: UIView) {
        shadow.backgroundColor = .clear
        shadow.layer.cornerRadius = 20
        shadow.layer.shadowOpacity = 0.8
        shadow.layer.shadowRadius = 3
        shadow.layer.shadowColor = UIColor.white.cgColor
        shadow.layer.shadowOffset = CGSize(width: 10, height: 10)
        shadow.layer.shadowPath = UIBezierPath(roundedRect: shadow.bounds, cornerRadius: 20).cgPath
    }
    
    private func addCornerRadiusContainView(containView: UIView) {
        containView.layer.cornerRadius = 20
        containView.layer.masksToBounds = true
        containView.clipsToBounds = true
    }
}
