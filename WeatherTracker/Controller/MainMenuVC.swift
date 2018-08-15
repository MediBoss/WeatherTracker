//
//  MainMenuVC.swift
//  WeatherTracker
//
//  Created by Assumani, Medi on 5/10/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

final class MainMenuVC: UIViewController, CLLocationManagerDelegate {
    
    // -MARK: @IBOULETS
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // -MARK: PROPERTIES
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getUserCoordinates()
        self.lookUpCurrentLocation { (currentUserPlace) in
            guard let city = currentUserPlace?.locality else {return}
            self.cityLabel.text = city
        }
    }
    
    // -MARK: CLASS METHODS
    
    
        // From Apple's documentation
        // This function gets the informtaion about the current location(address,city, state)
    fileprivate func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)-> Void ) {

        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }else {
                    completionHandler(nil)
                }
            })
        }
        else {
            completionHandler(nil)
        }
    }
    
        //This function requests permission to get user's location
    fileprivate func getUserCoordinates(){
        
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    
        //This Function gets the current user location from the device and makes the call to the api
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        let forecastService = ForecastService(locValue.latitude, locValue.longitude)
        forecastService.getForecast { (currentWeather) in
            DispatchQueue.main.async {
                        // UPDATING Temperature's and Summary's Labels
                guard let weatherSummary = currentWeather.summary, let weatherTemperature = currentWeather.temperature else{return}
                self.summaryLabel.text = weatherSummary
                self.temperatureLabel.text = weatherTemperature.convertToInt().convertToString() + "°"
            }
        }
    }

}
