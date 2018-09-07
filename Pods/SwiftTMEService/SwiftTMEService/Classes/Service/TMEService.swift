//
//  TMEService.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

public class TMEService {
    
    // MARK: - Types
    
    /// Empty success handler
    public typealias EmptySuccessHandler = () -> Void
    
    /// Success handler
    public typealias SuccessHandler<T> = (_ data: T) -> Void
    
    /// Failure handler
    public typealias FailureHandler = (_ error: Error) -> Void
    
    private enum API {
        static let authURL = ""
        static let baseURL = "https://api.tmsandbox.co.nz/v1"
    }
    
    enum HTTPMethod: String {
        case get = "GET", post = "POST", delete = "DELETE"
    }
    
    // MARK: - Properties
    
    private let urlSession = URLSession(configuration: .default)
    
    private var consumer: (key: String, secret: String)?
    
    private var authorization: String {
        return String(describing: "OAuth oauth_consumer_key=\(consumer!.key), oauth_signature_method=PLAINTEXT, oauth_signature=\(consumer!.secret)")
    }
    
    private var headersWithAuthorization: [String:String] {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": authorization
        ]
        return headers
    }
    
    
    // MARK: - Initializers
    
    /// Returns a shared instance of TMEService.
    public static let shared = TMEService()
    
    private init() {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            
            if let consumerKey = dict["TMEConsumerKey"] as? String,
                let consumerSecret = dict["TMEConsumerSecret"] as? String,
                !(consumerKey.isEmpty), !(consumerSecret.isEmpty) {
                consumer = (consumerKey, consumerSecret)
            } else {
                let msg = "Configure ConsumerKey and ConsumerSecret inside Info.plist"
                fatalError(msg)
            }
        }
    }
    
    // MARK: -
    
    /// Request TME data
    ///
    /// Return an instance or an error message to client.
    ///
    /// - parameter success: The callback called after a correct request.
    /// - parameter failure: The callback called after an incorrect request.
    func request<T: Decodable>(_ endpoint: String,
                               method: HTTPMethod = .get,
                               parameters: Parameters = [:],
                               success: ((_ data: T?) -> Void)?,
                               failure: FailureHandler?) {
        
        let urlRequest = buildURLRequest(endpoint, method: method, parameters: parameters)
        
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
}
