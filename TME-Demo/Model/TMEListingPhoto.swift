//
//  TMEListingPhoto.swift
//  TME-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

struct TMEListingPhoto {
    var key: Int? //--- format: 3633090
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
        key = dictionary["Key"] as? Int
        
        if let value = dictionary["Value"] as? [String:Any] {
            thumbnail = value["Thumbnail"] as? String
            list = value["List"] as? String
            medium = value["Medium"] as? String
            gallery = value["Gallery"] as? String
            large = value["Large"] as? String
            fullSize = value["FullSize"] as? String
            photoId = value["PhotoId"] as? Int
        }
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
