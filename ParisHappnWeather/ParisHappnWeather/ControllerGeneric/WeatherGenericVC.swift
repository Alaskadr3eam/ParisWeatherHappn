//
//  WeatherGenericVC.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

class WeatherGenericVC: UIViewController {
    
    var backgroundView: UIView!
    var gradientLayer: CAGradientLayer?
    
    //MARK: - Activity Indicator
    func showActivityIndicator(title: String? = "Loading..") {
        self.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        // blur effect
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundView.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.backgroundView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.backgroundView.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            self.backgroundView.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        }
        
        let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicatorView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        indicatorView.hidesWhenStopped = true
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        self.backgroundView.addSubview(indicatorView)
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = title
        label.textColor = UIColor.gray
        label.sizeToFit()
        label.center = CGPoint(x: indicatorView.center.x, y: indicatorView.center.y + 30)
        self.backgroundView.addSubview(label)
        
        self.view.addSubview(self.backgroundView)
    }
    
    func hideActivityIndicator(){
        if(self.backgroundView != nil && self.backgroundView.isDescendant(of: self.view)){
            self.backgroundView.removeFromSuperview()
            self.backgroundView = nil
        }
    }
    
    //MARK: - AlertView methods
    func showAlertView(title: String, message: String, firstBtnTitle: String, firstBtnAction: @escaping (UIAlertAction) -> Void = { _ in}, secondBtnTitle: String? = nil, secondBtnAction: @escaping ((UIAlertAction) -> Void) = { _ in}, preferredStyle: UIAlertController.Style = .alert) {
        
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: firstBtnTitle, style: .default, handler: firstBtnAction))
        if let secBtnTitle = secondBtnTitle{
            alert.addAction(UIAlertAction(title: secBtnTitle, style: .default, handler: secondBtnAction))
        }
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        guard let gradientLayerSecure = gradientLayer else { return }
        gradientLayerSecure.frame = self.view.bounds
        if #available(iOS 11.0, *) {
            guard let color1 = UIColor(named: "color1") else { return }
            guard let color2 = UIColor(named: "color2") else { return }
            gradientLayerSecure.colors = [color1.cgColor, color2.cgColor]
            self.view.layer.insertSublayer(gradientLayerSecure, at: 0)
        } else {
            // Fallback on earlier versions
            let color1 = UIColor(displayP3Red: 0.253, green: 0.569, blue: 0.721, alpha: 1)
            let color2 = UIColor(displayP3Red: 0.315, green: 0.694, blue: 0.805, alpha: 1)
            gradientLayerSecure.colors = [color1.cgColor, color2.cgColor]
            self.view.layer.insertSublayer(gradientLayerSecure, at: 0)
        }
    }
}

