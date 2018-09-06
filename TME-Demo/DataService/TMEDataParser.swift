//
//  TMEDataParser.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

typealias CategoryParsingCompletionHandler = (TMECategory?, String?) -> Void
typealias ListingParsingCompletionHandler = ([TMESingleListing]?, String?) -> Void
typealias ListingDetailParsingCompletionHandler = (TMESingleListingDetail?, String?) -> Void

typealias dataParsingCompletionHandler<T> = (T?, String?) -> Void

class TMEDataParser {
    
    static let shared = TMEDataParser()
    
    private init() {}
    
    func parseCategoryResponse(_ data: Data?, _ error: Error?, completion: @escaping CategoryParsingCompletionHandler) {
        if let data = data {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                
                if let dictionary = dictionary {
                    let category = TMECategory(with: dictionary)
                    completion(category, nil)
                }
                else {
                    completion(nil, "Data parsing error")
                }
            } catch let error as NSError {
                print(error)
                completion(nil, "Data parsing error")
            }
        }
        else if let error = error {
            print(error)
            completion(nil, "Response data error")
        }
    }
    
    func parseListingSearchResponse(_ data: Data?, _ error: Error?, completion: @escaping ListingParsingCompletionHandler) {
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
                    completion(nil, "Data parsing error")
                }
            } catch let error as NSError {
                print(error)
                completion(nil, "Data parsing error")
            }
        }
        else if let error = error {
            print(error)
            completion(nil, "Response data error")
        }
    }
    
    func parseListingDetailResponse(_ data: Data?, _ error: Error?, completion: @escaping ListingDetailParsingCompletionHandler) {
        if let data = data {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                
                if let dictionary = dictionary {
                    let singleListingDetail = TMESingleListingDetail.init(with: dictionary)
                    completion(singleListingDetail, nil)
                }
                else {
                    completion(nil, "Data parsing error")
                }
            } catch let error as NSError {
                print(error)
                completion(nil, "Data parsing error")
            }
        }
        else if let error = error {
            print(error)
            completion(nil, "Response data error")
        }
    }
}
