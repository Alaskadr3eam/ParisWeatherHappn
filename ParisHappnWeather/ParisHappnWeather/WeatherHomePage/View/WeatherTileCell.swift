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
    
    private func configureCell() {
        addShadowForCell(shadow: shadow)
        addCornerRadiusContainView(containView: containView)
        self.labelDay.text = model.date
        self.labelDescription.text = model.description!
        self.iconWeather.image = UIImage(named: model.forecast.weather.first!.icon)
        self.labelTemp.text = model.averageTemperature
        if model.date == "Aujourd'hui" {
            self.containView.backgroundColor = .systemYellow
        }
    }
    
    func configureDetailModel(forecast: Forecast) {
        labelDay.text = forecast.dateHourString
        labelDescription.isHidden = true
        iconWeather.image = UIImage(named: forecast.weather.first!.icon)
        self.labelTemp.text = "\(forecast.main.temp)°"
        containView.backgroundColor = .clear
        shadow.backgroundColor = .clear
    }
    ///func is possible in extension uiview for REFACTO
    private func addShadowForCell(shadow: UIView) {
        shadow.backgroundColor = .clear
        //layer
        shadow.layer.cornerRadius = 20
        shadow.layer.shadowOpacity = 0.8
        shadow.layer.shadowRadius = 3
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOffset = CGSize(width: 15, height: 15)
    }

    private func addCornerRadiusContainView(containView: UIView) {
        containView.layer.cornerRadius = 20
        containView.layer.masksToBounds = true
    }
    

}
