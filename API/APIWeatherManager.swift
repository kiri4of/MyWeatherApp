//
//  APIWeatherManager.swift
//  WeatherApp
//
//  Created by Kiri4of on 17.11.2022.
//

import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

enum ForecastType: FinalURLPoint {
    
    case Current(apiKey: String, coordinates: Coordinates) //чтобы узнать текущий прогноз погоды (ассоциативное значение)
    
    var baseURL: URL{
        return URL(string: "https://api.weatherapi.com")!
    }
    
    var path: String {
        switch self {
        case .Current(let apiKey, let coordinates): //Как я понял сюда приходят значения которые мы передали при вызове
            return "/v1/forecast.json?key=\(apiKey)&q=\(coordinates.latitude),\(coordinates.longitude)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
}

final class APIWeatherManager: APIManager {
    let sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    let apiKey: String
    
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchCurrentWeatherWith(coordinates: Coordinates, closure: @escaping (APIResult<CurrentWeater>) -> Void) {
        
        let request = ForecastType.Current(apiKey: self.apiKey, coordinates: coordinates).request //запрос (ссылка на данные https...)
        
//        fetch(request: request, parse: { json in
//            //достаем словари(ключ:значение) с данными из json
//            if let dictionary = json["current"] as? [String: AnyObject], let conditionDictionary = dictionary["condition"] as? [String:AnyObject] {
//                return CurrentWeater(JSON: dictionary,JSONExtension: conditionDictionary)
//            } else { //если же не получаестся то return
//                return nil
//            }
//        }, completionHandler: completionHandler) //передаем complitionHandler в fetch() из параметра этой(fetchCurrentWeatherWith) функции (Как я понял передаем result дальше...) Просто передаем в клоужер fetch() эту функцию (типо как var a = 2, b = a) и соотвественно передаем значение которое получает клоужер fetch() в реализации самого fetch(). Ну или пример снизу тоже самое

        
        fetch(request: request) { json in
            if let dictionary = json["current"] as? [String: AnyObject], let conditionDictionary = dictionary["condition"] as? [String:AnyObject] {
                return CurrentWeater(JSON: dictionary,JSONExtension: conditionDictionary)
            } else { //если же не получаестся то return
                return nil
            }
            
        } completionHandler: { result in
            closure(result) //передаем result из completionHandler fetch() в completionHandler этой функции
        }

    }
    
}
