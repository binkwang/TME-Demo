//
//  TMEListingPhoto.swift
//  TME-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

struct TMEListingPhoto: Decodable {
    var key: Int? //--- format: 3633090
    var value: Value?
    
    init() {}
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        key = dictionary["Key"] as? Int

        if let valueDictionary = dictionary["Value"] as? [String:Any] {
            value = Value.init(with: valueDictionary)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case value = "Value"
    }
}

struct Value: Decodable {
    var photoId: Int?
    var thumbnail: String?
    var list: String?
    var medium: String?
    var gallery: String?
    var large: String?
    var fullSize: String?
    
    init() {}
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        
        thumbnail = dictionary["Thumbnail"] as? String
        list = dictionary["List"] as? String
        medium = dictionary["Medium"] as? String
        gallery = dictionary["Gallery"] as? String
        large = dictionary["Large"] as? String
        fullSize = dictionary["FullSize"] as? String
        photoId = dictionary["PhotoId"] as? Int
    }
    
    enum CodingKeys: String, CodingKey {
        case photoId = "PhotoId"
        case thumbnail = "Thumbnail"
        case list = "List"
        case medium = "Medium"
        case gallery = "Gallery"
        case large = "Large"
        case fullSize = "FullSize"
    }
}

/** Json Example
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
*/
