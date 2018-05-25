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
    
    init(url: URL) {
        self.url = url
    }
    
    typealias JSONDictionaryHandler = (([String: Any]?) -> Void)
    
    func downloadFromApi(_ completionHandler: @escaping JSONDictionaryHandler){
        //@escaping means we are going to return data that we'll later need
        
        let urlRequest = URLRequest(url: self.url)
        let dataTastk = self.session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error == nil{ // if there are no error
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode{
                    case 200:
                        // we have data
                        if let data = data{
                            do{
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                completionHandler(jsonDictionary as? [String: Any])
                            }catch let error{
                                print(error.localizedDescription)
                            }
                        }
                        
                    default:
                        print("HTTP Status Code : \(httpResponse.statusCode)")
                    
                    }
                }
            }else{
                print("Error Found : \(error?.localizedDescription)")
            }
        }.resume()
    }
}
