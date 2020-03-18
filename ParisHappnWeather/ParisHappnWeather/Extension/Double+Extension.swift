//
//  Double+Extension.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation
extension Double {
    var dateFormatted : String? {
       let date = Date(timeIntervalSince1970: self)
       let dateFormatter = DateFormatter()
       dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
       dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
       return dateFormatter.string(from: date)
    }
    
    var dateFormattedReturnDate : Date? {
       return Date(timeIntervalSince1970: self)
    }
}
