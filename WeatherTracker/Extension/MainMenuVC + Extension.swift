//
//  MainMenuVC + Extension.swift
//  WeatherTracker
//
//  Created by macuser on 7/8/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import Foundation
import CoreLocation

extension MainMenuVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
    }
    
}

