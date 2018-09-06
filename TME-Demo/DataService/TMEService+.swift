//
//  TMEService+.swift
//  TME-Demo
//
//  Created by Bink Wang on 9/7/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

//internal let TMEListingPageSize = 20
//internal let TMERequestTimeoutInterval = 10.0

extension TMEService
{
    private enum Endpoint {
        static let AllCategories = "/Categories/0.json"
        static let GeneralSearch = "/Search/General.json?"
        static let ListingDetail = "/Listings/"
    }
    
    //---
    public func fetchCategories(success: SuccessHandler<TMECategory>?, failure: FailureHandler?) {
        request(Endpoint.AllCategories, success: { data in success?(data!) }, failure: failure)
    }
    
    func fetchListing(_ catetoryId: String, success: SuccessHandler<TMEGeneralSearchResponse>?, failure: FailureHandler?) {
        request(Endpoint.GeneralSearch, parameters: ["category": catetoryId, "rows": TMEListingPageSize], success: { data in success?(data!) }, failure: failure)
    }
    
    func fetchListingDetail(_ listingId: Int, success: SuccessHandler<TMESingleListingDetail>?, failure: FailureHandler?) {
        request("\(Endpoint.ListingDetail)\(listingId).json", success: { data in success?(data!) }, failure: failure)
    }
}
