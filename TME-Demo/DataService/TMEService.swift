//
//  TMEService.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

internal let TMEListingPageSize = 1
internal let TMERequestTimeoutInterval = 10.0

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
    
    private enum API {
        static let authURL = ""
        static let baseURL = "https://api.tmsandbox.co.nz/v1"
    }
    
    enum HTTPMethod: String {
        case get = "GET", post = "POST", delete = "DELETE"
    }
    
    private func buildURLRequest(_ endpoint: String, method: HTTPMethod, parameters: Parameters) -> URLRequest {
        let url = URL(string: API.baseURL + endpoint)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        switch method {
        case .get, .delete:
            urlRequest.url?.appendQueryParameters(parameters)
        case .post:
            urlRequest.httpBody = Data(parameters: parameters)
        }
        
        urlRequest.allHTTPHeaderFields = headersWithAuthorization as [String: String]
        
        return urlRequest
    }
    
    private let urlSession = URLSession(configuration: .default)
    
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
    
    //---
    func fetchCategories(completionHandler: @escaping DataCompletionHandler) {
        let headers = ["Cache-Control": "no-cache"]
        let request = NSMutableURLRequest(url: NSURL(string: TMEEndpointAllCategories)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: TMERequestTimeoutInterval)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers as [String: String]
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            completionHandler(data, error)
        })
        dataTask.resume()
    }
    
    func fetchListing(_ catetoryId: String?, completionHandler: @escaping DataCompletionHandler) {
        guard let catetoryId = catetoryId, !(catetoryId.isEmpty) else { return }
        
        //--- example: https://api.trademe.co.nz/v1/Search/General.json?category=3720
        let url = "\(TMEEndpointGeneralSearch)?category=\(catetoryId)&rows=\(TMEListingPageSize)"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: TMERequestTimeoutInterval)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headersWithAuthorization as [String: String]
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            completionHandler(data, error)
        })
        dataTask.resume()
    }
    
    func fetchListingDetail(_ listingId: Int?, completionHandler: @escaping DataCompletionHandler) {
        guard let listingId = listingId else { return }
        
        //--- example: https://api.tmsandbox.co.nz/v1/Listings/6866235.json
        let url = "\(TMEEndpointListingDetail)\(listingId).json"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: TMERequestTimeoutInterval)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headersWithAuthorization as [String: String]
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            completionHandler(data, error)
        })
        dataTask.resume()
    }
}
