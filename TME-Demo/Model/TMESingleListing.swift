//
//  TMESingleListing.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

struct TMESingleListing: Decodable {
    var listingId: Int? //--- format: 6866235
    var title: String?
    var subtitle: String?
    var category: String?
    var categoryPath: String?
    var startPrice: Double?
    var startDate: String?
    var pictureHref: String?
    var isNew: Bool?
    
    init() {}
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        
        listingId = dictionary["ListingId"] as? Int
        title = dictionary["Title"] as? String
        subtitle = dictionary["Subtitle"] as? String
        category = dictionary["Category"] as? String
        categoryPath = dictionary["CategoryPath"] as? String
        startPrice = dictionary["StartPrice"] as? Double
        startDate = dictionary["StartDate"] as? String
        pictureHref = dictionary["PictureHref"] as? String
        isNew = dictionary["IsNew"] as? Bool
    }
    
    enum CodingKeys: String, CodingKey {
        case listingId = "ListingId"
        case title = "Title"
        case subtitle = "Subtitle"
        case category = "Category"
        case categoryPath = "CategoryPath"
        case startPrice = "StartPrice"
        case startDate = "StartDate"
        case pictureHref = "PictureHref"
        case isNew = "IsNew"
    }
}

/** Json Example
{
    "ListingId": 6866235,
    "Title": "Mens Fashionista Overcoat - L",
    "Category": "0153-0438-3720-",
    "StartPrice": 117,
    "BuyNowPrice": 137,
    "StartDate": "/Date(1534210457080)/",
    "EndDate": "/Date(1534815180000)/",
    "ListingLength": null,
    "IsFeatured": true,
    "HasGallery": true,
    "IsBold": true,
    "AsAt": "/Date(1534333936084)/",
    "CategoryPath": "/Clothing-Fashion/Men/Jackets",
    "PictureHref": "https://images.tmsandbox.co.nz/photoserver/thumb/893921.jpg",
    "IsNew": true,
    "Region": "Auckland",
    "Suburb": "Auckland City",
    "HasReserve": true,
    "HasBuyNow": true,
    "NoteDate": "/Date(0)/",
    "ReserveState": 2,
    "Subtitle": "Extra = feature Combo",
    "PriceDisplay": "$117.00",
    "PromotionId": 4,
    "AdditionalData": {
        "BulletPoints": [],
        "Tags": []
    },
    "MemberId": 4000155
}
*/
