//
//  TMEResponse.swift
//  TME-Demo
//
//  Created by Bink Wang on 9/6/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

struct TMEResponse<T: Decodable>: Decodable {
    
    // MARK: - Properties
    
//    let data: T?
    let Subcategories: T?
//    let meta: Meta
//    let pagination: Pagination?
//
//    // MARK: - Types
//
//    struct Meta: Decodable {
//        let code: Int
//        let errorType: String?
//        let errorMessage: String?
//    }
//
//    struct Pagination: Decodable {
//        let nextUrl: String?
//        let nextMaxId: String?
//    }
}
