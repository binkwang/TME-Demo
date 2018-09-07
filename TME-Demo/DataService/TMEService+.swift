//
//  TMEService+.swift
//  TME-Demo
//
//  Created by Bink Wang on 9/7/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

internal let TMEListingPageSize = 20

extension TMEService
{
    /**
     TME sandbox environment endpoint.
     */
    private enum Endpoint {
        static let AllCategories = "/Categories/0.json" //--- example: https://api.tmsandbox.co.nz/v1/Categories/0.json
        static let GeneralSearch = "/Search/General.json?" //--- example: https://api.trademe.co.nz/v1/Search/General.json?category=3720
        static let ListingDetail = "/Listings/" //--- example: https://api.tmsandbox.co.nz/v1/Listings/6866235.json
    }
    
    /**
     Fetch & parse category.
     
     Return an instance of TMECategory or an error message to client.
     */
    public func fetchCategories(success: SuccessHandler<TMECategory>?, failure: FailureHandler?) {
        request(Endpoint.AllCategories, success: { data in success?(data!) }, failure: failure)
    }
    
    /**
     Fetch & parse the listings of a specific leaf category.
     
     Return a listing array or an error message to client.
     */
    public func fetchListing(_ catetoryId: String, success: SuccessHandler<TMEGeneralSearchResponse>?, failure: FailureHandler?) {
        request(Endpoint.GeneralSearch, parameters: ["category": catetoryId, "rows": TMEListingPageSize], success: { data in success?(data!) }, failure: failure)
    }
    
    /**
     Fetch & parse the detail of a specific listing.
     
     Return an instance of TMESingleListingDetail or an error message to client.
     */
    public func fetchListingDetail(_ listingId: Int, success: SuccessHandler<TMESingleListingDetail>?, failure: FailureHandler?) {
        request("\(Endpoint.ListingDetail)\(listingId).json", success: { data in success?(data!) }, failure: failure)
    }
}
