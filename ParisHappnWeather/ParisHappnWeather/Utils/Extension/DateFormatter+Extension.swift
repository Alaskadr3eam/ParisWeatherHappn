//
//  DateFormatter+Extension.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var weekdayDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.frFr
        formatter.dateFormat = "EEEE dd MMM"
        return formatter
    }
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    static var hourFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    static func createDateTime(timestamp: String) -> String {
        var strDate = "undefined"
        
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
            dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd/MM/yyyy" //Specify your format that you want
            strDate = dateFormatter.string(from: date)
        }
        
        return strDate
    }
    
    static func createDateTimeHour(timestamp: String) -> String {
        var strDate = "undefined"
        
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
            dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "HH:MM" //Specify your format that you want
            strDate = dateFormatter.string(from: date)
        }
        
        return strDate
    }
}
