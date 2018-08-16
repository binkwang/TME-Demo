//
//  CategoryTableViewCell.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

internal let kCategoryTableViewCellReuseIdentifier = "CategoryTableViewCellReuseIdentifier"

class CategoryTableViewCell: UITableViewCell {
    
    let nibName = "CategoryTableViewCell"
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var accessoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nameLabel.backgroundColor = UIColor.clear
        infoLabel.backgroundColor = UIColor.clear
        accessoryImageView.backgroundColor = UIColor.clear
        
        self.viewAutoLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func viewAutoLayout() {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = Dictionary(dictionaryLiteral: ("nameLabel",nameLabel), ("infoLabel",infoLabel), ("accessoryImageView",accessoryImageView)) as [String : Any]
        
        let metrics = Dictionary(dictionaryLiteral: ("hPadding", 20),("vPadding",10))
        
        let horizontal1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-hPadding-[nameLabel]-[infoLabel(==100)]-[accessoryImageView(==20)]-hPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        let vertical1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-vPadding-[nameLabel]-vPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        let vertical2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-vPadding-[infoLabel]-vPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        let vertical3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[accessoryImageView(==20)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        var viewConstraints = [NSLayoutConstraint]()
        
        viewConstraints += horizontal1
        viewConstraints += vertical1
        viewConstraints += vertical2
        viewConstraints += vertical3
        
        NSLayoutConstraint.activate(viewConstraints)
    }
    
}
