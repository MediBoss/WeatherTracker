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
    let forecastService: ForecastService = ForecastService(apiKey: Constants.apiKey)
    let coordinates: (latitude: Double, longitude: Double) = (42.3601,-71.0589) // coordinates of NY,NY
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.forecastService.getForecast(latitude: coordinates.latitude, longitude: coordinates.longitude) { (currentWeather) in
            
            if let currentWeather = currentWeather {
                // UPDATING UI IN THE MAIN THREAD
                DispatchQueue.main.async {
                    guard let weatherSummary = currentWeather.summary, let weatherTemperature = currentWeather.temperature else{return}
                    self.summaryLabel.text = weatherSummary
                    self.temperatureLabel.text = weatherTemperature.convertToInt().convertToString() + "°"
  
                }
            }
        }
       
    }
}
