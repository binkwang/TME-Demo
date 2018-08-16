//
//  DataParser.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

let dataloadedNotificationKey = "com.binkwang.dataloaded"

//func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        completion(data, response, error)
//        }.resume()
//}


//enum FacilityType: String {
//    case Attraction
//    case Entertainment
//    case Restaurant
//}

class DataParser {
    
    init() {}
    
    func parseCategoryResponse(_ data: Data?, _ error: Error?, completion: @escaping (Category?, String?) -> Void) -> Void {
        
        if let data = data {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                
                if let dictionary = dictionary {
                    let category = Category(with: dictionary)
                    completion(category, nil)
                }
            } catch let error as NSError {
                print(error)
                
                //--- TODO: parse Error to String
                
                completion(nil, nil)
                
            }
        }
        else if let error = error {
            print(error)
            
            //--- TODO: parse Error to String
            
            completion(nil, nil)
        }
    }
    
    func parseListingSearchResponse(_ data: Data?, _ error: Error?, completion: @escaping ([SingleListing]?, String?) -> Void) -> Void {
        if let data = data {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                
                var listings: [SingleListing] = []
                if let dictionary = dictionary, let list = dictionary["List"] as? [[String:Any]] {
                    list.forEach { (listingDictionary) in
                        let singleListing = SingleListing.init(with: listingDictionary)
                        listings.append(singleListing)
                    }
                    completion(listings, nil)
                }
                else {
                    completion(nil, "Data Error")
                }
            } catch let error as NSError {
                print(error)
                completion(nil, "Data Error")
            }
        }
        else if let error = error {
            print(error)
            completion(nil, "Data Error")
        }
    }
}
