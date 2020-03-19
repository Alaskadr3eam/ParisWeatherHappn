//
//  DetailView.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

class DetailView: UIView {
     //MARK: - Properties
      @IBOutlet weak var labelCity: UILabel!
      @IBOutlet weak var labelDescription: UILabel!
      @IBOutlet weak var labelTemp: UILabel!
      @IBOutlet weak var iconImage: UIImageView!
      @IBOutlet weak var tempMinLabel: UILabel!
      @IBOutlet weak var tempMaxLabel: UILabel!
    
      override func awakeFromNib() {
      }
      //MARK: - Configure DetailView
      func configureDetailView(model: WeatherDetailTableModel) {
          labelCity.text = model.city.name
          labelDescription.text = model.weatherCellModel?.description
          labelTemp.text = model.weatherCellModel?.averageTemperature
          guard let image = model.weatherCellModel?.iconUrl else { return }
          iconImage.image = UIImage(named:image)
          tempMinLabel.text = model.tempMin
          tempMaxLabel.text = model.tempMax
      }
}
