//
//  APIManager.swift
//  WeatherApp
//
//  Created by Kiri4of on 16.11.2022.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONComplitionHandeler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}

extension APIManager {
    
    func JSONTaskWith(request: URLRequest, complitionHandler: @escaping JSONComplitionHandeler) -> JSONTask {
        let dataTask = session.dataTask(with: request) { data, response, error in
            //производим ошибку в случае неполучения HTTPURLResponse
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                let error = NSError(domain: ZXCNetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                complitionHandler(nil,nil,error)
                return
            }
            //ошибка если данные(HTTPRespons пришел и с ним все ОК) не пришли или же равняются nil
            if data == nil {
                if let error = error {
                    complitionHandler(nil,HTTPResponse,error)
                }
            } else { //если данные пришли и статусКод нормальный
                switch HTTPResponse.statusCode {  //статус нашего ответа(хз насчет 200 типо все найс, хз)
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] //получаем весь json... 
                        complitionHandler(json,HTTPResponse,nil)
                    } catch let error as NSError { //если json не приходит
                        complitionHandler(nil,HTTPResponse,error)
                    }
                default:
                    print("We have got response status \(HTTPResponse.statusCode)")
                }
            }
        }
        return dataTask
    }
    
    func fetch<T>(request: URLRequest,  parse: @escaping ([String:AnyObject]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void) {
        let dataTask = JSONTaskWith(request: request) { json, response, error in
           
            DispatchQueue.main.async {
                //если с json все хуево выдаем ошибку
                guard let json = json else {
                    if let error = error {
                        completionHandler(.Failure(error))
                    }
                    return
                }
                //если с json все ок
                if let value = parse(json) {
                    completionHandler(.Success(value)) // это чо?
                } else { //если parse не удалось выдаем ошибку
                    let error = NSError(domain: ZXCNetworkingErrorDomain, code: 200, userInfo: nil)
                    completionHandler(.Failure(error))
                }
            }
            
        }
        dataTask.resume() //чтобы работал
    }
}
