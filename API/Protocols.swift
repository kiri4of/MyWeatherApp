//
//  Protocols.swift
//  WeatherApp
//
//  Created by Kiri4of on 17.11.2022.
//

import Foundation

protocol JSONDecodable {
    init?(JSON: [String:AnyObject], JSONExtension: [String:AnyObject])
}

protocol FinalURLPoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith(request: URLRequest, complitionHandler: @escaping JSONComplitionHandeler) -> JSONTask
    
    func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping ([String:AnyObject]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void)
}
