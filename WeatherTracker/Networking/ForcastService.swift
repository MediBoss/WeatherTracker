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
    let latitude: Double
    let longitude: Double
    
    init(_ latitude: Double, _ longitude: Double) {
        
        self.latitude = latitude
        self.longitude = longitude
        self.complete_url = URL(string: "\(Constants.baseURL)\(Constants.apiKey)" + "/" + "\(latitude)" + "," + "\(longitude)")!
    }

    func getForecast(_ completionHandler: @escaping (Weather) -> Void){
        
        let request: URLRequest = URLRequest(url: self.complete_url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil{
                guard let httpResponse = response as? HTTPURLResponse else {return}
                switch httpResponse.statusCode{
                case 200:
                    guard let dataReceivedFromWeb = data else {return}
                    do{
                        let decoder = JSONDecoder()
                        let weather = try decoder.decode(Weather.self, from: dataReceivedFromWeb)
                        completionHandler(weather)
                    }catch let error{
                        print("ERROR FOUND : \(error.localizedDescription)")
                    }
                    
                default:
                    print("Error Found : \(httpResponse.statusCode)")
                }
            }
        }
        task.resume()
    }
}

