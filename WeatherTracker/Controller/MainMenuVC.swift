//
//  MainMenuVC.swift
//  WeatherTracker
//
//  Created by Assumani, Medi on 5/10/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import UIKit
import CoreLocation

final class MainMenuVC: UIViewController, CLLocationManagerDelegate {
    
    // -MARK: @IBOULETS
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // -MARK: PROPERTIES
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getUserCoordinates()

    }
    
    // -MARK: CLASS METHODS
    
    
    /*
     This function requests permission to get user's location, calculates the location's
     accuracy, and updates the location frequently.
     */
    fileprivate func getUserCoordinates(){
        
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    /*
        This Function gets the current user location from the ios device and updates
        The coordinates with realtime and recent location.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        let forecastService = ForecastService(locValue.latitude, locValue.longitude)
        forecastService.getForecast { (currentWeather) in
            // UPDATING THE UI
            DispatchQueue.main.async {
                guard let weatherSummary = currentWeather.summary, let weatherTemperature = currentWeather.temperature else{return}
                print(weatherTemperature)
                self.summaryLabel.text = weatherSummary
                self.temperatureLabel.text = weatherTemperature.convertToInt().convertToString() + "°"
            }
        }
    }

}
