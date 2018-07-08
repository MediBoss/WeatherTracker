//
//  MainMenuVC.swift
//  WeatherTracker
//
//  Created by Assumani, Medi on 5/10/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import UIKit
import CoreLocation

class MainMenuVC: UIViewController {
    
    // -MARK: @IBOULETS
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // -MARK: VARIABLES
    let coordinates: (latitude: Double, longitude: Double) = (42.3601,-71.0589) // coordinates of NY,NY
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNetworkCall()
        getUserCoordinates()

    }
        // CLASS METHODS
    
    fileprivate func getUserCoordinates(){
        
         self.locationManager.requestAlwaysAuthorization()
         
         if CLLocationManager.locationServicesEnabled() {
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
         locationManager.startUpdatingLocation()
            
         }
 
    }
    
    fileprivate func makeNetworkCall() -> Void{
        
        let forecastService = ForecastService(self.coordinates.latitude,self.coordinates.longitude)
        forecastService.getForecast { (currentWeather) in
                // UPDATING UI IN THE MAIN THREAD
                DispatchQueue.main.async {
                    
                    guard let weatherSummary = currentWeather.summary, let weatherTemperature = currentWeather.temperature else{return}
                    self.summaryLabel.text = weatherSummary
                    self.temperatureLabel.text = weatherTemperature.convertToInt().convertToString() + "°"
                    
                }
        }
    }
 
}

