//
//  Weather.swift
//  WeatherTracker
//
//  Created by macuser on 5/24/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import Foundation

class Weather{
    
    let temperature: Int?
    let summary: String?
    
    struct jsonWeatherKeys{
        static let temperatureKey = "temperature"
        static let summaryKey = "summary"
    }
    
    init(jsonDictionary: [String:Any]){
       temperature = jsonDictionary[jsonWeatherKeys.temperatureKey] as? Int
       summary = jsonDictionary[jsonWeatherKeys.summaryKey] as? String
    }
}
