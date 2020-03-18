//
//  DetailView.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

class DetailView: UIView {
     
      @IBOutlet weak var labelCity: UILabel!
      @IBOutlet weak var labelDescription: UILabel!
      @IBOutlet weak var labelTemp: UILabel!
      @IBOutlet weak var iconImage: UIImageView!
      @IBOutlet weak var tempMinLabel: UILabel!
      @IBOutlet weak var tempMaxLabel: UILabel!
    
      override func awakeFromNib() {
      }
      
      func configureDetailView(model: WeatherDetailTableModel) {
          labelCity.text = model.city.name
          labelDescription.text = model.weatherCellModel?.description
          labelTemp.text = model.weatherCellModel?.averageTemperature
          iconImage.image = UIImage(named:(model.weatherCellModel?.iconUrl)!)
          tempMinLabel.text = model.tempMin
          tempMaxLabel.text = model.tempMax
      }
}
