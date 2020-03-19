//
//  UIDevice+Extension.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

extension UIDevice {
    
    public static let hardwareModel: String = {
        var path = [CTL_HW, HW_MACHINE]
        var n = 0
        sysctl(&path, 2, nil, &n, nil, 0)
        var a: [UInt8] = .init(repeating: 0, count: n)
        sysctl(&path, 2, &a, &n, nil, 0)
        return .init(cString: a)
    }()
}
