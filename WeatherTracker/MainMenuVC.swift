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
    let coordinate: (latitude: Double, longitude: Double) = (37.8267,-122.4233)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let forecastService = ForecastService(apiKey: self.apiKey)
        forecastService.getForecast(latitude: coordinate.latitude, longitude: coordinate.longitude) { (currentWeather) in
            if let currentWeather = currentWeather {
                guard let summary = self.summaryLabel.text, let temperature = self.summaryLabel.text, let location = self.locationLabel.text else{return}
                // MUST GET BACK TO THE MAIN QUEUE
                DispatchQueue.main.async {
                    
                }
            }
        }
        
    }

}

