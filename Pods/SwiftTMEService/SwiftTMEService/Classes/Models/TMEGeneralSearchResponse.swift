//
//  TMEGeneralSearchResponse.swift
//  TME-Demo
//
//  Created by Bink Wang on 9/7/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

public struct TMEGeneralSearchResponse: Decodable {
    public var totalCount: Int?
    public var list: [TMESingleListing]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case list = "List"
    }
}

/**
 https://api.tmsandbox.co.nz/v1/Search/General.json?category=0001&rows=1
{
    "TotalCount": 35,
    "Page": 1,
    "PageSize": 1,
    "List": [
    {
    "ListingId": 6880354,
    "Title": "Powerbuilt 2200kg Vehicle Trolley Jack",
    "Category": "0001-0877-2900-8654-",
    "StartPrice": 1,
    "StartDate": "/Date(1536203063377)/",
    "EndDate": "/Date(1536807863377)/",
    "ListingLength": null,
    "IsFeatured": true,
    "HasGallery": true,
    "IsBold": true,
    "AsAt": "/Date(1536238295871)/",
    "CategoryPath": "/Trade-Me-Motors/Car-parts-accessories/Tools-repair-kits/Jacks",
    "PictureHref": "https://images.tmsandbox.co.nz/photoserver/thumb/4279865.jpg",
    "Region": "Canterbury",
    "Suburb": "Christchurch City",
    "NoteDate": "/Date(0)/",
    "Subtitle": "SKYLARC'S GENERAL AUCTION",
    "PriceDisplay": "$1.00",
    "PhotoUrls": [
    "https://images.tmsandbox.co.nz/photoserver/thumb/4279866.jpg",
    "https://images.tmsandbox.co.nz/photoserver/thumb/4279867.jpg",
    "https://images.tmsandbox.co.nz/photoserver/thumb/4279868.jpg",
    "https://images.tmsandbox.co.nz/photoserver/thumb/4279869.jpg",
    "https://images.tmsandbox.co.nz/photoserver/thumb/4279870.jpg",
    "https://images.tmsandbox.co.nz/photoserver/thumb/4279871.jpg"
    ],
    "PromotionId": 4,
    "AdditionalData": {
    "BulletPoints": [],
    "Tags": []
    },
    "MemberId": 4005383
    }
    ],
    "DidYouMean": "",
    "FoundCategories": [
    {
    "Count": 2,
    "Category": "0001-0268-",
    "Name": "Cars",
    "CategoryId": 268
    },
    {
    "Count": 5,
    "Category": "0001-0026-",
    "Name": "Motorbikes",
    "CategoryId": 26
    },
    {
    "Count": 1,
    "Category": "0001-0348-",
    "Name": "Boats & marine",
    "CategoryId": 348
    },
    {
    "Count": 25,
    "Category": "0001-0877-",
    "Name": "Car parts & accessories",
    "CategoryId": 877
    },
    {
    "Count": 2,
    "Category": "0001-1484-",
    "Name": "Aircraft",
    "CategoryId": 1484
    }
    ]
}
*/

 
