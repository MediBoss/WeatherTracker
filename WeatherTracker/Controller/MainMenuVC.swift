//
//  MainMenuVC.swift
//  WeatherTracker
//
//  Created by Assumani, Medi on 5/10/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import UIKit
import CoreLocation

final class MainMenuVC: UIViewController, CLLocationManagerDelegate {
    
    // -MARK: @IBOULETS
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
     @IBOutlet weak var currentCity: UILabel!
    
    // -MARK: PROPERTIES
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getUserCoordinates()

    }
    
    // -MARK: CLASS METHODS
    
    
    /*
     This function requests permission to get user's location, calculates the location's
     accuracy, and updates the location frequently.
     */
    fileprivate func getUserCoordinates(){
        
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    /*
        This Function gets the current user location from the ios device and updates
        The coordinates with realtime and recent location.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
       
        makeNetworkCall(longitude: locValue.longitude, latitude: locValue.latitude)
       
    }
    /*
     This function updates the user interface with the data received from the API.
     */
    fileprivate func makeNetworkCall(longitude: Double, latitude: Double) -> Void{
        
        ForecastService.getForecast(longitude, latitude) { (currentWeather) in
            
            self.lookUpCurrentLocation(completionHandler: { (currentPlace) in
                DispatchQueue.main.async {
                    self.currentCity.text = currentPlace?.locality
                }
            })
            
            // UPDATING UI IN THE MAIN THREAD
            DispatchQueue.main.async {
                guard let weatherSummary = currentWeather.summary, let weatherTemperature = currentWeather.temperature else{return}
                // UPDATING THE UI
                self.summaryLabel.text = weatherSummary
                self.temperatureLabel.text = weatherTemperature.convertToInt().convertToString() + "°"
            }
        }
    }
    // convert the geo location into place mark
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
                                                
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    

}
