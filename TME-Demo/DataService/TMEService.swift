//
//  TMEService.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

typealias DataCompletionHandler = (Data?, Error?) -> Void

typealias EmptySuccessHandler = () -> Void
typealias SuccessHandler<T> = (_ data: T) -> Void
typealias FailureHandler = (_ error: Error) -> Void

class TMEService {
    
    static let shared = TMEService()
    
    private init() {
        guard !(TMEConsumerKey.isEmpty) && !(TMEConsumerSecret.isEmpty) else {
            let msg = "Configure ConsumerKey and ConsumerSecret inside TMEServiceConfig.swift"
            fatalError(msg)
        }
    }
    
    private enum API {
        static let authURL = ""
        static let baseURL = "https://api.tmsandbox.co.nz/v1"
    }
    
    enum HTTPMethod: String {
        case get = "GET", post = "POST", delete = "DELETE"
    }
    
    private var authorization: String {
        return String(describing: "OAuth oauth_consumer_key=\(TMEConsumerKey), oauth_signature_method=PLAINTEXT, oauth_signature=\(TMEConsumerSecret)")
    }
    
    private var headersWithAuthorization: [String:String] {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": authorization
        ]
        return headers
    }
    
    private func buildURLRequest(_ endpoint: String, method: HTTPMethod, parameters: Parameters) -> URLRequest {
        let url = URL(string: API.baseURL + endpoint)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 10.0
        
        switch method {
        case .get, .delete:
            urlRequest.url?.appendQueryParameters(parameters)
        case .post:
            urlRequest.httpBody = Data(parameters: parameters)
        }
        
        urlRequest.allHTTPHeaderFields = headersWithAuthorization as [String: String]
        
        return urlRequest
    }
    
    func request<T: Decodable>(_ endpoint: String,
                               method: HTTPMethod = .get,
                               parameters: Parameters = [:],
                               success: ((_ data: T?) -> Void)?,
                               failure: FailureHandler?) {
        
        let urlRequest = buildURLRequest(endpoint, method: method, parameters: parameters)
        
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: urlRequest) { (data, _, error) in
            if let data = data {
                DispatchQueue.global(qos: .utility).async {
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let object = try jsonDecoder.decode(T.self, from: data)
                        
                        DispatchQueue.main.async {
                            success?(object)
                        }
                        
                    } catch let error {
                        DispatchQueue.main.async {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            } else if let error = error {
                failure?(error)
            }
            }.resume()
    }
}
