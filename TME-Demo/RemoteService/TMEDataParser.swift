//
//  TMEDataParser.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

class TMEDataParser {
    
    init() {}
    
    func parseCategoryResponse(_ data: Data?, _ error: Error?, completion: @escaping (TMECategory?, String?) -> Void) -> Void {
        
        if let data = data {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                
                if let dictionary = dictionary {
                    let category = TMECategory(with: dictionary)
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
    
    func parseListingSearchResponse(_ data: Data?, _ error: Error?, completion: @escaping ([TMESingleListing]?, String?) -> Void) -> Void {
        if let data = data {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                
                var listings: [TMESingleListing] = []
                if let dictionary = dictionary, let list = dictionary["List"] as? [[String:Any]] {
                    list.forEach { (listingDictionary) in
                        let singleListing = TMESingleListing.init(with: listingDictionary)
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
