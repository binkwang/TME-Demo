//
//  TMESingleListingDetail.swift
//  TME-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

struct TMESingleListingDetail: Decodable {
    var listingId: Int? //--- format: 6866235
    var title: String?
    var subtitle: String?
    var category: String?
    var categoryPath: String?
    var startPrice: Double?
    var priceDisplay: String? //--- format: $117.00
    var photoId: Int? //--- format: 3633090
    var photos: [TMEListingPhoto]?
    
    init() {}
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        
        listingId = dictionary["ListingId"] as? Int
        title = dictionary["Title"] as? String
        subtitle = dictionary["Subtitle"] as? String
        category = dictionary["Category"] as? String
        categoryPath = dictionary["CategoryPath"] as? String
        startPrice = dictionary["StartPrice"] as? Double
        priceDisplay = dictionary["PriceDisplay"] as? String
        photoId = dictionary["PhotoId"] as? Int
        
        photos = [TMEListingPhoto]()
        
        if let photoArray = dictionary["Photos"] as? [[String:Any]] {
            photoArray.forEach { (photoDictionary) in
                let photo = TMEListingPhoto.init(with: photoDictionary)
                photos?.append(photo)
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case listingId = "ListingId"
        case title = "Title"
        case subtitle = "Subtitle"
        case category = "Category"
        case categoryPath = "CategoryPath"
        case startPrice = "StartPrice"
        case priceDisplay = "PriceDisplay"
        case photoId = "PhotoId"
        case photos = "Photos"
    }
}

/** Json Example
{
    "ListingId": 6865995,
    "Title": "Polo Shirts",
    "Category": "0153-0438-3762-",
    "StartPrice": 0,
    "BuyNowPrice": 21,
    "StartDate": "/Date(1534192903827)/",
    "EndDate": "/Date(1534538503827)/",
    "ListingLength": null,
    "HasGallery": true,
    "AsAt": "/Date(1534392158513)/",
    "CategoryPath": "/Clothing-Fashion/Men/Tops-shirts",
    "PhotoId": 3633090,
    "IsNew": true,
    "RegionId": 16,
    "Region": "Canterbury",
    "SuburbId": 86,
    "Suburb": "Christchurch City",
    "HasBuyNow": true,
    "NoteDate": "/Date(0)/",
    "CategoryName": "Tops & shirts",
    "ReserveState": 3,
    "Attributes": [
    {
    "Name": "Colour",
    "DisplayName": "Colour",
    "Value": "Sky Blue",
    "Type": 4,
    "DisplayValue": "Sky Blue"
    },
    {
    "Name": "Size",
    "DisplayName": "Size",
    "Value": "Small",
    "Type": 4,
    "DisplayValue": "Small"
    }
    ],
    "OpenHomes": [],
    "IsBuyNowOnly": true,
    "HasMultiple": true,
    "IsFlatShippingCharge": true,
    "PriceDisplay": "$21.00 per item",
    "IsClearance": true,
    "AvailableToBuy": "2",
    "ListingGroupId": 7024,
    "AdditionalData": {
        "BulletPoints": [],
        "Tags": []
    },
    "UnansweredQuestionCount": 0,
    "Member": {
        "MemberId": 4000148,
        "Nickname": "junk",
        "DateAddressVerified": "/Date(1380798000000)/",
        "DateJoined": "/Date(1319713200000)/",
        "UniqueNegative": 19,
        "UniquePositive": 45,
        "FeedbackCount": 26,
        "IsAddressVerified": true,
        "Suburb": "Christchurch City",
        "Region": "Canterbury",
        "IsAuthenticated": true,
        "IsInTrade": true,
        "IsTopSeller": true
    },
    "Body": "Polo shirts.\r\nJust select your colour and size and we will do the rest.\r\n\r\nJunk from the bottom of the world.",
    "Questions": {
        "TotalCount": 1,
        "Page": 1,
        "PageSize": 1,
        "List": [
        {
        "ListingId": 6865995,
        "ListingQuestionId": 288382,
        "Comment": "Voted worst Junk of all time by the anarchy branch of  Time Travelers Unlimited.\nVoted second best by the Alzheimer's branch of Grey Power 2012.",
        "CommentDate": "/Date(1534192942980)/",
        "IsSellerComment": true,
        "Answer": "",
        "AnswerDate": "/Date(0)/",
        "AskingMember": {
        "MemberId": 4000148,
        "Nickname": "junk",
        "DateAddressVerified": "/Date(1380798000000)/",
        "DateJoined": "/Date(1319713200000)/",
        "UniqueNegative": 19,
        "UniquePositive": 45,
        "FeedbackCount": 26,
        "IsAddressVerified": true,
        "IsAuthenticated": true
        }
        }
        ]
    },
    "Photos": [
    {
    "Key": 3633090,
    "Value": {
    "Thumbnail": "https://images.tmsandbox.co.nz/photoserver/thumb/3633090.jpg",
    "List": "https://images.tmsandbox.co.nz/photoserver/lv2/3633090.jpg",
    "Medium": "https://images.tmsandbox.co.nz/photoserver/med/3633090.jpg",
    "Gallery": "https://images.tmsandbox.co.nz/photoserver/gv/3633090.jpg",
    "Large": "https://images.tmsandbox.co.nz/photoserver/tq/3633090.jpg",
    "FullSize": "https://images.tmsandbox.co.nz/photoserver/full/3633090.jpg",
    "PhotoId": 3633090,
    "OriginalWidth": 1000,
    "OriginalHeight": 1000
    }
    }
    ],
    "AllowsPickups": 3,
    "ShippingOptions": [
    {
    "Type": 4,
    "Price": 1.7,
    "Method": "Snail Mail",
    "ShippingId": 4
    },
    {
    "Type": 4,
    "Price": 9.75,
    "Method": "Pony Express (P)",
    "ShippingId": 5
    },
    {
    "Type": 4,
    "Price": 40.1,
    "Method": "International Courier (C)",
    "ShippingId": 6
    },
    {
    "Type": 4,
    "Price": 0,
    "Method": "Free with Buy Now (F)",
    "ShippingId": 7
    }
    ],
    "PaymentOptions": "Cash, NZ Bank Deposit",
    "IsInTradeProtected": true,
    "CanAddToCart": false,
    "EmbeddedContent": {},
    "SupportsQuestionsAndAnswers": true,
    "PaymentMethods": [
    {
    "Id": 4,
    "Name": "Cash"
    },
    {
    "Id": 1,
    "Name": "NZ Bank Deposit"
    }
    ]
}
*/
