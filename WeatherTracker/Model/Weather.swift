//
//  Weather.swift
//  WeatherTracker
//
//  Created by macuser on 5/24/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import Foundation

class Weather{
    
    let temperature: Double?
    let summary: String?

    
    struct jsonKeys{
        static let temperatureKey = "temperature"
        static let summaryKey = "summary"
    }
    
    init(jsonDictionary: [String:Any]){
       temperature = jsonDictionary[jsonKeys.temperatureKey] as? Double
       summary = jsonDictionary[jsonKeys.summaryKey] as? String
    }
}
