//
//  WeatherDetailTVC+ExtensionMapKit.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//
import UIKit
import MapKit

extension WeatherDetailTVC: MKMapViewDelegate {
    ///func for prepare mapKitView
    private func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        locationMapCity.setRegion(coordinateRegion, animated: true)
        
    }
    ///func for create annotation for mapKitView
    private func createAnnotationMapView() {
        let coordinate = CLLocationCoordinate2D(latitude: 48.868688, longitude: 2.345698)
        let happnLoc = Place(title: "happn", coordinate: coordinate)
        locationMapCity.addAnnotation(happnLoc)
    }
    ///func for initialize mapKitView
    private func initializeRegionViewMapView() {
        createAnnotationMapView()
        let lat = model.city.coord.lat
        let longitude = model.city.coord.lon
        let initialisation = CLLocation(latitude: lat, longitude: longitude)
        let regionRadius: CLLocationDistance = 5000
        centerMapOnLocation(location: initialisation, regionRadius: regionRadius)
        locationMapCity.isUserInteractionEnabled = false
    }
    ///func initialisation MapKitView
    func initLocMapView() {
        initializeRegionViewMapView()
    }
    //MARK: - Delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annot = annotation as? Place {
            let identifier = "annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView != nil {
                annotationView?.annotation = annot
            } else {
                annotationView = MKAnnotationView(annotation: annot, reuseIdentifier: identifier)
                annotationView?.isEnabled = true
            }
            let pinImage = UIImage(named: "happn")
            let size = CGSize(width: 30, height: 40)
            UIGraphicsBeginImageContext(size)
            pinImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            annotationView?.image = resizedImage
            
            annotationView?.canShowCallout = true
            annotationView?.calloutOffset = CGPoint(x: -5, y: 5)
            if annot.title == "happn" {
                let mapsButton = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = mapsButton
            }
            return annotationView
        }
        return nil
    }
}
///Object for create place in map view
class Place: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
    }
}

