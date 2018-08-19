//
//  TMEListingTableViewCell.swift
//  TME-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

internal let kTMEListingTableViewCellNibName = "TMEListingTableViewCell"
internal let kTMEListingTableViewCellReuseIdentifier = "TMEListingTableViewCellReuseIdentifier"


class TMEListingTableViewCell: UITableViewCell {
    
    var singleListing: TMESingleListing? {
        didSet {
            if let title = singleListing?.title, let id = singleListing?.listingId {
                titleLabel.text = "\(title)"
                idLabel.text = "\(id)"
                pictureImageView.renderImage(imageUrl: singleListing?.pictureHref)
            }
        }
    }
    
    //--- MARK: IBOutlets

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var accessoryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //--- Initialization code
        
        pictureImageView.layer.cornerRadius = 5
        pictureImageView.layer.masksToBounds = true
        
        titleLabel.backgroundColor = UIColor.clear
        idLabel.backgroundColor = UIColor.clear
        pictureImageView.backgroundColor = UIColor.clear
        accessoryImageView.backgroundColor = UIColor.clear
        
        self.viewAutoLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //--- Configure the view for the selected state
    }
    
    private func viewAutoLayout() {
        
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let views = Dictionary(dictionaryLiteral: ("pictureImageView",pictureImageView), ("accessoryImageView",accessoryImageView), ("titleLabel",titleLabel), ("idLabel",idLabel)) as [String : Any]
        
        let metrics = Dictionary(dictionaryLiteral: ("hPadding", 20),("vPadding",10))
        
        let horizontal1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-hPadding-[pictureImageView(==40)]-10-[titleLabel]-[accessoryImageView(==20)]-hPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        let horizontal2 = NSLayoutConstraint.constraints(withVisualFormat: "H:[pictureImageView]-10-[idLabel]-[accessoryImageView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        let vertical1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-vPadding-[pictureImageView(==40)]-vPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        let vertical2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-vPadding-[titleLabel(==20)]-0-[idLabel(==20)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        let vertical3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[accessoryImageView(==20)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        var viewConstraints = [NSLayoutConstraint]()
        
        viewConstraints += horizontal1
        viewConstraints += horizontal2
        viewConstraints += vertical1
        viewConstraints += vertical2
        viewConstraints += vertical3
        
        NSLayoutConstraint.activate(viewConstraints)
    }
    
}
