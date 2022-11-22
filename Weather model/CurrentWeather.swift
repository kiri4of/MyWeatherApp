//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Kiri4of on 12.11.2022.
//

import Foundation
import UIKit

struct CurrentWeater {
    let temperature: Double
    let appearentTemperature: Double
    let humidity: Double
    let pressure: Double
    let icon: UIImage
}

extension CurrentWeater: JSONDecodable {
    init?(JSON: [String : AnyObject], JSONExtension: [String:AnyObject]) {
        guard let tempature = JSON["temp_c"] as? Double,
              let apparentTemperature = JSON["feelslike_c"] as? Double,
              let humidity = JSON["humidity"] as? Double,
              let pressure = JSON["pressure_mb"] as? Double,
              let iconString = JSONExtension["icon"] as? String
        else {return nil}
        let iconNumberSuffix = iconString.suffix(7)
        let iconNumberPrefix = iconNumberSuffix.prefix(3)
        let icon = WeatherIconManager(rawValue: String(iconNumberPrefix)).image
        
        self.temperature = tempature
        self.appearentTemperature = apparentTemperature
        self.humidity = humidity
        self.pressure = pressure
        self.icon = icon
        
    }
    
    
    
}

extension CurrentWeater {
    var pressureString: String {
        return "\(Int(pressure)) mm"
    }
    var humidityStirng: String {
        return "\(Int(humidity)) %"
    }
    var temperatureString: String {
        return "\(Int(temperature)) ˚C"
    }
    var apperantTemperatureString: String {
        return "Feels  like: \(Int(appearentTemperature)) ˚C"
    }
}
