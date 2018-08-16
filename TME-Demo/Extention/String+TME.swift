//
//  String+TME.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

extension String {
    //--  parameter example:
    //--  "oauth_token=BDA4497F6C98E6DE2E8A85EE590DBF3D&oauth_token_secret=603BD1BC5EC22A17A69F012D1553FA0A&oauth_callback_confirmed=true"
    func dictionaryFromRequestTokenResponse(_ string: String?) -> Dictionary<String, String>? {
        let dictionary = NSMutableDictionary()
        guard let string = string, (string.contains("oauth_token") && string.contains("oauth_token_secret")) else { return nil }
        
        string.components(separatedBy: "&").forEach { (element) in
            let elementArray = element.components(separatedBy: "=")
            if !(elementArray[0].isEmpty) && !(elementArray[1].isEmpty) {
                dictionary[elementArray[0]] = elementArray[1]
            }
        }
        return dictionary as? Dictionary<String, String>
    }
    
    
}
