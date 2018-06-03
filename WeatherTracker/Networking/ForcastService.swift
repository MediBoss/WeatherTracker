//
//  ForcastService.swift
//  WeatherTracker
//
//  Created by macuser on 5/24/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import Foundation

class ForecastService{
    
    let complete_url: URL
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    let latitude: Double
    let longitude: Double
    typealias WeatherClosure = ((Weather?) -> Void)
    
    init(_ latitude: Double, _ longitude: Double) {
        
        self.latitude = latitude
        self.longitude = longitude
        self.complete_url = URL(string: "\(Constants.baseURL)\(Constants.apiKey)" + "/" + "\(latitude)" + "," + "\(longitude)")!
    }

    func getForecast(_ completionHandler: @escaping WeatherClosure){
        
        // make url request
        let urlRequest: URLRequest = URLRequest(url: self.complete_url)
        
        // Create a data task
        self.session.dataTask(with: urlRequest) { (data, response, error) in
            // check request response
            if error == nil{ // if there are no error
                guard let httpUrlResponse = response as? HTTPURLResponse else {return}
                switch httpUrlResponse.statusCode{
                case 200:
                    guard let data = data else {return}
                    
                    do{
                        let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]
                        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: Any]{
                            let currentWeather = Weather(jsonDictionary: currentWeatherDictionary)
                            completionHandler(currentWeather)
                            
                        }
                        
                    }catch let error{
                        print("ERROR FOUND : \(error.localizedDescription)")
                    }
                    
                default:
                    print("STATUS CODE : \(httpUrlResponse.statusCode)")
                }
            }
        }.resume()

    }

}
