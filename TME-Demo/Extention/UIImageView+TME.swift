//
//  UIImageView+TME.swift
//  TME-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    func renderImage(imageUrl: String?) {
        guard let imageUrl = imageUrl, !(imageUrl.isEmpty) else { return }
        URLSession.shared.dataTask(with: NSURL(string: imageUrl)! as URL) { (data, response, error) -> Void in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            }.resume()
    }
}
