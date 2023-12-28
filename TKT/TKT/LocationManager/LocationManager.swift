//
//  LocationManager.swift
//  TKT
//
//  Created by Kalandarov Vakil on 27.12.2023.
//

import Foundation
import CoreLocation
import YandexMapsMobile
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate,ObservableObject{
    let image = UIImage(named: "location") ?? UIImage()
       private let manager = CLLocationManager()
       let mapView = YMKMapView(frame: CGRect.zero) ?? YMKMapView()
       @Published var lastUserLocation: CLLocation? = nil
       lazy var map : YMKMap = {
           return mapView.mapWindow.map
       }()
       
    override init(){
           super.init()
           manager.delegate = self
           manager.startUpdatingLocation()
       }
    
    
    
    func currentUserLocation(){
        //YMKPoint(latitude: 59.935493, longitude: 30.327392)
        addPlacemarkOnMap()
        // if let myLocation = lastUserLocation {
                centerMapLocation(target: YMKPoint(latitude: 59.935493, longitude: 30.327392), map: mapView )
           // }
        }
        
        func centerMapLocation(target location: YMKPoint?, map: YMKMapView) {
            
            guard let location = location else { print("Failed to get user location"); return }
            
            map.mapWindow.map.move(
                with: YMKCameraPosition(target: YMKPoint(latitude: 59.935493, longitude: 30.327392), zoom: 18, azimuth: 0, tilt: 0),
                animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5)
            )
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                self.manager.startUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            // Notify listeners that the user has a new location
            self.lastUserLocation = locations.last
        }
    
    private func addPlacemark(_ map: YMKMap) {
        let image = UIImage(named: "location") ?? UIImage()
        let placemark = map.mapObjects.addPlacemark()
       // placemark.geometry = Const.placemarkPoint
        placemark.setIconWith(image)
    }
    
    func addPlacemarkOnMap() {
        let point = YMKPoint(latitude: 59.935493, longitude: 30.327392)
        let viewPlacemark: YMKPlacemarkMapObject = mapView.mapWindow.map.mapObjects.addPlacemark(with: point)
        
        viewPlacemark.setIconWith(
            UIImage(named: "location")!,
            style: YMKIconStyle(
                anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
                rotationType: YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 0,
                flat: true,
                visible: true,
                scale: 1.5,
                tappableArea: nil
            )
        )
    }
}
