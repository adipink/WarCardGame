//
//  LocationManager.swift
//  PlayingCardApp
//
//  Created by Kristina & Adi
//

import Foundation
import CoreLocation

class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var longitude: Double = 0.0
    
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse: //Location services are available
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
        case .restricted: //Location services unavailable
            authorizationStatus = .restricted
            break
        case .denied: //Location services unavailable
            authorizationStatus = .denied
            break
        case .notDetermined: //Authorization not determined
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedAlways:
            authorizationStatus = .authorizedAlways
        @unknown default:
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            
        }
    }
    
    func startUpdatingLocation() {
            locationManager.startUpdatingLocation()
        }
        
        func stopUpdatingLocation() {
            locationManager.stopUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                longitude = location.coordinate.longitude
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error: \(error.localizedDescription)")
    }}
