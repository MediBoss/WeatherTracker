//
//  Weather.swift
//  WeatherTracker
//
//  Created by macuser on 5/24/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import Foundation

struct Weather: Decodable{
    
    let temperature: Double?
    let summary: String?
    
    enum CodingKeys: String, CodingKey {
        case temperature
        case summary
    }
    enum WeatherKeys: String, CodingKey{
        case currently
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: WeatherKeys.self)
        let weatherValues = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .currently)
        temperature = try weatherValues.decode(Double.self, forKey: .temperature)
        summary = try? weatherValues.decode(String.self, forKey: .summary)
    }
}
