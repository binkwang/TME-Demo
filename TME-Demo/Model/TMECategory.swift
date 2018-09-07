//
//  TMECategory.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

struct TMECategory: Decodable {
    var name: String?
    var number: String? //--- format: 0001-0268-0269-
    var path: String?
    var isLeaf: Bool?
    var subcategories: [TMECategory]?
    
    init() {}
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        
        name = dictionary["Name"] as? String
        number = dictionary["Number"] as? String
        path = dictionary["Path"] as? String
        isLeaf = dictionary["IsLeaf"] as? Bool
        
        subcategories =  [TMECategory]()
        
        let subcategoryArr = dictionary["Subcategories"] as? [[String: Any]]
        subcategoryArr?.forEach({ (subcategoryDic) in
            let subcategory = TMECategory(with: subcategoryDic)
            subcategories?.append(subcategory)
        })
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case number = "Number"
        case path = "Path"
        case isLeaf = "IsLeaf"
        case subcategories = "Subcategories"
    }
    
    var id: String { //--- used for listing searching, format: 0269
        var id = ""
        if let number = number, !(number.isEmpty) {
            let numberComponent: [String] = number.components(separatedBy: "-")
            if numberComponent.count >= 2 {
                id = numberComponent[numberComponent.count-2]
            }
        }
        return id
    }
}

/** Json Example
{
    Name: "Root",
    Number: "",
    Path: "",
    Subcategories: [
        {
            Name: "Trade Me Motors",
            Number: "0001-",
            Path: "/Trade-Me-Motors",
            Subcategories: [],
            HasClassifieds: true,
            CanHaveSecondCategory: true,
            CanBeSecondCategory: true,
            IsLeaf: false
        },
        {
            Name: "Trade Me Property",
            Number: "0350-",
            Path: "/Trade-Me-Property",
            Subcategories: [],
            HasClassifieds: true,
            IsLeaf: false
        }
    ],
    IsLeaf: false
}
*/
