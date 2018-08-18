//
//  TMEDataCenter.swift
//  TME-Demo
//
//  Created by Bink Wang on 8/18/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

class TMEDataCenter {
    static let shared = TMEDataCenter()
    
    private init() {}
    
    func fetchRootCategory(completion: @escaping CategoryParsingCompletionHandler) {
        TMEDataRequester.shared.fetchCategories { (data, error) -> Void in
            TMEDataParser.shared.parseCategoryResponse(data, error, completion: { (category, errString) in
                completion(category, errString)
            })
        }
    }
    
    func fetchListing(_ catetoryId: String?, completion: @escaping ListingParsingCompletionHandler) {
        TMEDataRequester.shared.fetchListing(catetoryId) { (data, error) -> Void in
            TMEDataParser.shared.parseListingSearchResponse(data, error, completion: { (listings, errString) in
                completion(listings, errString)
            })
        }
    }
    
    func fetchListingDetail(_ listingId: Int?, completion: @escaping ListingDetailParsingCompletionHandler) {
        TMEDataRequester.shared.fetchListingDetail(listingId) { (data, error) in
            TMEDataParser.shared.parseListingDetailResponse(data, error, completion: { (listingDetail, errString) in
                completion(listingDetail, errString)
            })
        }
    }
}


