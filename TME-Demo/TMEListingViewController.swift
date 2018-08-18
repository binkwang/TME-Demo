//
//  TMEListingViewController.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

internal let kTMEListingViewControllerIdentifier = "TMEListingViewController"

class TMEListingViewController: UITableViewController {
    
    var listings: [TMESingleListing]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if self.listings?.count == 0 {
                    self.showAlert("Info", "Nothing found under this category.")
                }
            }
        }
    }
    
    var category: TMECategory? {
        didSet {
            TMEDataCenter.shared.fetchListing(category?.id) { (listings, errString) in
                if let errString = errString {
                    self.showAlert("ERROR", "\(errString)")
                }
                else if let listings = listings {
                    self.listings = listings
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Listing"
        
        //--- Init TableView
        let nib = UINib.init(nibName: kTMEListingTableViewCellNibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: kTMEListingTableViewCellReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//--- MARK: UITableViewDataSource & UITableViewDelegate

extension TMEListingViewController
{
    //--- UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.section as Any, indexPath.row as Any)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: kTMEDetailViewControllerIdentifier) as? TMEDetailViewController {
            if let listings = listings {
                detailViewController.listingId = listings[indexPath.row].listingId
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //--- UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = listings?.count {
            return count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kTMEListingTableViewCellReuseIdentifier, for: indexPath) as? TMEListingTableViewCell else {
            fatalError("The dequeued cell is not an instance of SelectedPlaceCell.")
        }
        if let listings = listings {
            cell.singleListing = listings[indexPath.row]
        }
        return cell
    }
}

//--- MARK: LeafCategorySelectionDelegate

extension TMEListingViewController: LeafCategorySelectionDelegate {
    func leafCategorySelected(_ category: TMECategory?) {
        self.category = category
    }
}
