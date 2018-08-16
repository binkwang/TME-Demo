//
//  TMEDataRequester.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

internal let TMEConsumerKey = "A1AC63F0332A131A78FAC304D007E7D1"
internal let TMEConsumerSecret = "EC7F18B17A062962C6930A8AE88B16C7&"

internal let TMEEndpointAllCategories = "https://api.tmsandbox.co.nz/v1/Categories/0.json"
internal let TMEEndpointGeneralSearch = "https://api.tmsandbox.co.nz/v1/Search/General.json"
internal let TMEEndpointListingDetail = "https://api.tmsandbox.co.nz/v1/Listings/"

internal let TMEListingPageSize = 20
internal let TMERequestTimeoutInterval = 10.0

class TMEDataRequester {
    
    var authorization: String {
        return String(describing: "OAuth oauth_consumer_key=\(TMEConsumerKey), oauth_signature_method=PLAINTEXT, oauth_signature=\(TMEConsumerSecret)")
    }
    
    init() {
        guard !(TMEConsumerKey.isEmpty) && !(TMEConsumerSecret.isEmpty) else {
            let msg = "Configure ConsumerKey and ConsumerSecret inside DataRequester.swift"
            fatalError(msg)
        }
        print("TMEConsumerKey: \(TMEConsumerKey)")
        print("TMEConsumerSecret: \(TMEConsumerSecret)")
    }
    
    func fetchCategories(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let headers = ["Cache-Control": "no-cache"]
        let request = NSMutableURLRequest(url: NSURL(string: TMEEndpointAllCategories)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: TMERequestTimeoutInterval)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers as [String: String]
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            completion(data, response, error)
        })
        dataTask.resume()
    }
    
    func fetchListing(_ catetoryId: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let catetoryId = catetoryId, !(catetoryId.isEmpty) else { return }
        
        //--- example: https://api.trademe.co.nz/v1/Search/General.json?category=3720
        let url = "\(TMEEndpointGeneralSearch)?category=\(catetoryId)&rows=\(TMEListingPageSize)"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: TMERequestTimeoutInterval)
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": authorization
        ]
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers as [String: String]
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            completion(data, response, error)
        })
        dataTask.resume()
    }
    
    func fetchListingDetail(_ listingId: Int?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let listingId = listingId else { return }
        
        //--- example: https://api.tmsandbox.co.nz/v1/Listings/6866235.json
        let url = "\(TMEEndpointListingDetail)\(listingId).json"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: TMERequestTimeoutInterval)
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": authorization
        ]
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers as [String: String]
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            completion(data, response, error)
        })
        dataTask.resume()
    }
    
    
}
