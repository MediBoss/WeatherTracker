//
//  ForcastService.swift
//  WeatherTracker
//
//  Created by macuser on 5/24/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import Foundation

class ForecastService{
    
  
    

    static func getForecast(_ longitude: Double,_ latitude: Double, completionHandler: @escaping (Weather) -> Void){
        
        let complete_url = URL(string: "\(Constants.baseURL)\(Constants.apiKey)" + "/" + "\(latitude)" + "," + "\(longitude)")!
        
        let request: URLRequest = URLRequest(url: complete_url)
        
       
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

