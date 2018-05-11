//
//  NetworkProcessor.swift
//  WeatherTracker
//
//  Created by Assumani, Medi on 5/10/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import Foundation

class NetworkProcessor{
    let url: URL
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    init(url: URL){
        self.url = url
    }
    
    typealias JSONDictionaryHandler = (([String: Any]?) -> Void)
    
    func downloadJsonFromApi(_ completionHandler: @escaping JSONDictionaryHandler){
        
            // Make a request
        let request = URLRequest(url: self.url)
        let dataTask = self.session.dataTask(with: request) { (data, response, error) in
                // No erro found
            if error == nil { 
                // check the http response
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode{
                    case 200:
                        // succesfully made our request
                        if let data = data {
                            do{
                               let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                print(jsonDictionary)
                            }catch let error{
                                print(error.localizedDescription)
                            }
                        }
                    default:
                        print("HTTP Responce Code : \(httpResponse.statusCode)")
                    }
                }
            }else {
                print("Error : \(error?.localizedDescription)")
            }
        }.resume()
    }
}
