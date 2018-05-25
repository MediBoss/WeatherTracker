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
    
    func getForecast(latitude: Double, longitude: Double, completionHandler: @escaping () -> Void){
        
        if let forecastUrl = URL(string: "\(latitude),\(longitude)", relativeTo: baseUrl!){
            
            let networkProcessor = NetworkProcessor(url: forecastUrl)
            networkProcessor.downloadFromApi { (jsonDictionary) in
                // TODO Turn JSON Dictionary into swift weather objects
                let currentWeather = Weather(jsonDictionary: [String : Any])
            }
            
        }
    }
}
