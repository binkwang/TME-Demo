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
    
    /**
     Fetch & parse root category.
     
     Return an instance of TMECategory or an error message to client.
     */
    func fetchRootCategory(completion: @escaping CategoryParsingCompletionHandler) {
        TMEService.shared.fetchCategories { (data, error) -> Void in
            TMEDataParser.shared.parseCategoryResponse(data, error, completion: { (category, errString) in
                completion(category, errString)
            })
        }
    }
    
    /**
     Fetch & parse the listings of a specific leaf category.
     
     Return a listing array or an error message to client.
     */
    func fetchListing(_ catetoryId: String?, completion: @escaping ListingParsingCompletionHandler) {
        TMEService.shared.fetchListing(catetoryId) { (data, error) -> Void in
            TMEDataParser.shared.parseListingSearchResponse(data, error, completion: { (listings, errString) in
                completion(listings, errString)
            })
        }
    }
    
    /**
     Fetch & parse the detail of a specific listing.
     
     Return an instance of TMESingleListingDetail or an error message to client.
     */
    func fetchListingDetail(_ listingId: Int?, completion: @escaping ListingDetailParsingCompletionHandler) {
        TMEService.shared.fetchListingDetail(listingId) { (data, error) in
            TMEDataParser.shared.parseListingDetailResponse(data, error, completion: { (listingDetail, errString) in
                completion(listingDetail, errString)
            })
        }
    }
}


