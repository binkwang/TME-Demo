//
//  TMEDataRequester.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

internal let TMEListingPageSize = 20
internal let TMERequestTimeoutInterval = 10.0

typealias DataCompletionHandler = (Data?, Error?) -> Void

class TMEDataRequester {
    
    static let shared = TMEDataRequester()
    
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
