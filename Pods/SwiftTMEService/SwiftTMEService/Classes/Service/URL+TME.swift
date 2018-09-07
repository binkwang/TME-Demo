//
//  URL+TME.swift
//  TME-Demo
//
//  Created by Bink Wang on 9/6/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

extension URL {
    
    /// Returns a URL constructed by appending the given parameters to self.
    func appendingQueryParameters(_ parameters: Parameters) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var items = urlComponents.queryItems ?? []
        items += parameters.map { URLQueryItem(name: $0, value: "\($1)") }
        urlComponents.queryItems = items
        return urlComponents.url!
    }
    
    /// Modifies the current URL by appending the given parameters.
    mutating func appendQueryParameters(_ parameters: Parameters) {
        self = appendingQueryParameters(parameters)
    }
}
