//
//  TMEDetailViewController.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

internal let kTMEDetailViewControllerIdentifier = "TMEDetailViewController"

class TMEDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var listingId: Int? {
        didSet {
            TMEDataCenter.shared.fetchListingDetail(listingId) { [weak self] (listingDetail, errString) in
                guard let strongSelf = self else { return }
                if let errString = errString {
                    strongSelf.showAlert("ERROR", "\(errString)")
                }
                else if let listingDetail = listingDetail {
                    strongSelf.listingDetail = listingDetail
                }
            }
        }
    }
    
    var listingDetail: TMESingleListingDetail? {
        didSet {
            self.freshUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func freshUI() {
        DispatchQueue.main.async {
            if let title = self.listingDetail?.title, let id = self.listingDetail?.listingId, let photos = self.listingDetail?.photos {
                self.titleLabel?.text = title
                self.idLabel?.text = "\(id)"
                
                if photos.count > 0 {
                    self.imageView?.renderImage(imageUrl: photos[0].fullSize)
                }
            }
        }
    }
}
