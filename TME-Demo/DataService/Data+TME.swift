//
//  Data+TME.swift
//  TME-Demo
//
//  Created by Bink Wang on 9/6/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

extension Data {
    init(parameters: Parameters) {
        self = parameters.map { "\($0.key)=\($0.value)&" }.joined().data(using: .utf8)!
    }
}
