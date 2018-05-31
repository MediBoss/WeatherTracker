//
//  ForcastService.swift
//  WeatherTracker
//
//  Created by macuser on 5/24/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import Foundation

class ForecastService{
    
    let apiKey: String
    let baseUrl: URL?
    
    init(apiKey: String){
        self.apiKey = apiKey
        baseUrl = URL(string: "https://api.darksky.net/forecast/\(Constants.apiKey)")
    }
    
    func getForecast(latitude: Double, longitude: Double, completionHandler: @escaping (Weather?) -> Void){
        
        if let forecastUrl = URL(string: "\(baseUrl!)/\(latitude),\(longitude)"){
            
            let networkProcessor = NetworkProcessor(url: forecastUrl)
            networkProcessor.downloadFromApi { (jsonDictionary) in
                // TODO Turn JSON Dictionary into swift weather objects
                if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: Any]{
                    
                    let currentWeather = Weather(jsonDictionary: currentWeatherDictionary)
                    completionHandler(currentWeather)
                }else{
                    completionHandler(nil)
                }
            }
            
        }
    }
}
