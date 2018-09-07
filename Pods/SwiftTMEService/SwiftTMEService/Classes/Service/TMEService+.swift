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
    // MARK: - Types
    
    private enum Endpoint {
        static let AllCategories = "/Categories/0.json" //--- example: https://api.tmsandbox.co.nz/v1/Categories/0.json
        static let GeneralSearch = "/Search/General.json?" //--- example: https://api.trademe.co.nz/v1/Search/General.json?category=3720
        static let ListingDetail = "/Listings/" //--- example: https://api.tmsandbox.co.nz/v1/Listings/6866235.json
    }
    
    // MARK: -
    
    /// Fetch & parse category.
    ///
    /// Return an instance of TMECategory or an error message to client.
    ///
    /// - parameter success: The callback called after a correct request.
    /// - parameter failure: The callback called after an incorrect request.
    public func fetchCategories(success: SuccessHandler<TMECategory>?, failure: FailureHandler?) {
        request(Endpoint.AllCategories, success: { data in success?(data!) }, failure: failure)
    }
    
    /// Fetch & parse the listings of a specific leaf category.
    ///
    /// Return a listing array or an error message to client.
    ///
    /// - parameter catetoryId:
    /// - parameter success: The callback called after a correct request.
    /// - parameter failure: The callback called after an incorrect request.
    public func fetchListing(_ catetoryId: String, success: SuccessHandler<TMEGeneralSearchResponse>?, failure: FailureHandler?) {
        request(Endpoint.GeneralSearch, parameters: ["category": catetoryId, "rows": TMEListingPageSize], success: { data in success?(data!) }, failure: failure)
    }
    
    /// Fetch & parse the detail of a specific listing.
    ///
    /// Return an instance of TMESingleListingDetail or an error message to client.
    ///
    /// - parameter listingId:
    /// - parameter success: The callback called after a correct request.
    /// - parameter failure: The callback called after an incorrect request.
    public func fetchListingDetail(_ listingId: Int, success: SuccessHandler<TMESingleListingDetail>?, failure: FailureHandler?) {
        request("\(Endpoint.ListingDetail)\(listingId).json", success: { data in success?(data!) }, failure: failure)
    }
}
