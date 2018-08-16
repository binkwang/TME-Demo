//
//  DataRequester.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation


internal let TMEEndpointBase = "https://secure.tmsandbox.co.nz"
internal let TMEEndpointRequestToken = "https://secure.tmsandbox.co.nz/Oauth/RequestToken?scope=MyTradeMeRead,MyTradeMeWrite"
internal let TMEEndpointAccessToken = "https://secure.tmsandbox.co.nz/Oauth/AccessToken"
internal let TMEEndpointRequestAuthorisation = "https://secure.tmsandbox.co.nz/Oauth/Authorize?oauth_token="

internal let TMEEndpointAccessTokenWithXauth = "https://api.tmsandbox.co.nz/Xauth/AccessToken"


internal let TMEEndpointAllCategories = "https://api.tmsandbox.co.nz/v1/Categories/0.json"
internal let TMEEndpointGeneralSearch = "https://api.tmsandbox.co.nz/v1/Search/General.json"

internal let TMEConsumerKey: String = "A1AC63F0332A131A78FAC304D007E7D1"
internal let TMEConsumerSecret: String = "EC7F18B17A062962C6930A8AE88B16C7&"
//internal let TMEConsumerSecret: String = "EC7F18B17A062962C6930A8AE88B16C7%26"

internal let PageSize: Int = 20

class DataRequester {
    
    var requestToken: String?
    var requestSecret: String?
    
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
    
    func generateAccessToken(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
//        let headers = [
//            "Authorization": authorization,
//            "Content-Type": "application/x-www-form-urlencoded",
//            "Cache-Control": "no-cache",
//            "Accept": "application/json" //Accept=application/json
//        ]
        
        let headers = [
            
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": authorization
        ]
        
//        POST https://api.tmsandbox.co.nz/Xauth/AccessToken
//        Authorization: OAuth oauth_consumer_key="<consumer-key>", oauth_signature_method="PLAINTEXT", oauth_signature="<consumer-secret>"
//        Content-Type: application/x-www-form-urlencoded

        
        let request = NSMutableURLRequest(url: NSURL(string: TMEEndpointAccessTokenWithXauth)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        //request.httpBody = postData as Data
        
        print("\nrequest.url: \(String(describing: request.url!))")
        print("\nrequest.allHTTPHeaderFields: \(request.allHTTPHeaderFields!)\n")
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let data = data {
                
                //-- success!  now we extract and cache the temporary user token and secret from the response data
                
                if let responseString = String.init(data: data, encoding: String.Encoding.utf8) {
                    print("result: \(String(describing: responseString))")
                    
//                    let dictionaryOfAuthComponents = responseString.dictionaryFromRequestTokenResponse(responseString)
//
//                    self.requestToken = dictionaryOfAuthComponents?["oauth_token"]
//                    self.requestSecret = dictionaryOfAuthComponents?["oauth_token_secret"]
//
//                    print("requestToken: \(String(describing: self.requestToken))")
//                    print("requestToken: \(String(describing: self.requestSecret))")
                    
                }
                
            } else if let error = error {
                print("error======: \(error)")
            }
            
        })
        
        dataTask.resume()
    }
    
    func fetchCategories(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let headers = [
            "Cache-Control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: TMEEndpointAllCategories)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
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
        
        //--- example: https://api.trademe.co.nz/v1/Search/General.xml?category=3720
        let url = "\(TMEEndpointGeneralSearch)?category=\(catetoryId)&rows=\(PageSize)"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
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
