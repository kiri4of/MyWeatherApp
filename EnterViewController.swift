//
//  EnterViewController.swift
//  WeatherApp
//
//  Created by Kiri4of on 20.11.2022.
//

import UIKit
import CoreLocation

class EnterViewController: UIViewController {

    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLocationManager()
    }

    @IBAction func cheakWeatherButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "main") as? ViewController else {return}
        if latitude.text != "" && longitude.text != "" {
            vc.latitude = Double(self.latitude.text!)!
            vc.longitude = Double(self.longitude.text!)!

            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            alert()
        }
       
    }
    
    func startLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //желаемое положение - лучшеая точность
        locationManager.requestAlwaysAuthorization() //запрос на разрешение местоположения при запуске
        locationManager.startUpdatingLocation() //получаем наши доки
    }
    
    func alert(){
        let ac = UIAlertController(title: "Missing some coordinate", message: "Set the coordinates", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        ac.addAction(ok)
        present(ac, animated: true)
    }

}

extension EnterViewController: CLLocationManagerDelegate {
    //при обновлении геопозиции
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.first! as CLLocation
        
        print("My location latitude: \(userLocation.coordinate.latitude),  longitude: \(userLocation.coordinate.longitude)")
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
