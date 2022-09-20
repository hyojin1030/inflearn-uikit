//
//  NetworkAPI.swift
//  MovieApp
//
//  Created by 주효진 on 2022/09/20.
//

import Foundation

enum RequestType {
    case justURL(urlString: String)
    case searchMovie(querys: [URLQueryItem])
}

enum NetworkAPIError: Error {
    case badURL
}

class NetworkAPI {
    
    typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void
    
    func request(type: RequestType, completion: @escaping NetworkCompletion) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let request = try bulidRequest(type: type)
            
            session.dataTask(with: request) { data, response, error in
                print((response as! HTTPURLResponse).statusCode)
                
                completion(data, response, error)
                
            }.resume()
            
            session.finishTasksAndInvalidate()
        } catch {
            print(error)
        }
    }
    
    private func bulidRequest(type: RequestType) throws -> URLRequest {
        switch type {
        case .justURL(let urlString):
            guard let hasURL = URL(string: urlString) else {
                throw NetworkAPIError.badURL
            }
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            return request
            
        case .searchMovie(let querys):
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = querys
            
            guard let hasUrl = components?.url else {
                throw NetworkAPIError.badURL
            }
        
            var request = URLRequest(url: hasUrl)
            request.httpMethod = "GET"
            return request
            
        }
    }
}
