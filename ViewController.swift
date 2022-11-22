//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kiri4of on 12.11.2022.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var weatherManager = APIWeatherManager(apiKey: "ddc3e2adbe0640fa868210941221611")
    
    var longitude = 0.0
    var latitude = 0.0
    var coordinates: Coordinates!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinates = Coordinates(latitude: latitude, longitude: longitude)
        getCurrentWeatherData()
    }
    
    
    @IBAction func refreshButtonAction(_ sender: UIButton) {
        toggleActivityIndicator(on: true)
        getCurrentWeatherData()
    }
    
    func findTheLocation(){
        let location = CLLocation(latitude: latitude, longitude: longitude)
        location.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.locationLabel.text = "\(city), \(country)"
            print(city + ", " + country)  // Rio de Janeiro, Brazil
        }
    }
    
    func toggleActivityIndicator(on: Bool) {
        activityIndicator.isHidden = on
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func getCurrentWeatherData() {
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { result in
            self.toggleActivityIndicator(on: false)
            
            switch result {
            case .Success(let currentWeather): //сюда приходит value(экземпляр CurrentWeather) из метода
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
                self.alertError(title: "Unable to data", message: error.localizedDescription, error: error)
            }
        }
        findTheLocation()
    }
    
    func alertError(title: String, message: String, error: Error) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        ac.addAction(ok)
        present(ac, animated: true)
    }
    
    func updateUIWith(currentWeather: CurrentWeater) {
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.humidityLabel.text = currentWeather.humidityStirng
        self.appearentTemperatureLabel.text = currentWeather.apperantTemperatureString
        
    }
    
}


