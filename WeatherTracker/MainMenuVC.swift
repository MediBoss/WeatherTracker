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
    
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    let apiKey: String = Constants.apiKey
    var coordinate: (latitude: Double, longitude: Double)
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
   func checkAuthorization() -> (latitude: Double, longitude: Double){
        locManager.requestWhenInUseAuthorization()
    
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            currentLocation = locManager.location
        }
        
            // return a tuple that contains the coordinates
        return(currentLocation.coordinate.latitude,currentLocation.coordinate.longitude)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coordinate = checkAuthorization()
        
        let forecastService = ForecastService(apiKey: self.apiKey)
        forecastService.getForecast(latitude: coordinate.latitude, longitude: coordinate.longitude) { (currentWeather) in
            if let currentWeather = currentWeather {
                guard var summary = self.summaryLabel.text, var temperature = self.summaryLabel.text, var location = self.locationLabel.text else{return}
                // MUST GET BACK TO THE MAIN QUEUE
                DispatchQueue.main.async {
                    
                    
                }
            }
        }
        
    }

}

