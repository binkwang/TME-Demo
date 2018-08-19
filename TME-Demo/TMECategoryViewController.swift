//
//  TMECategoryViewController.swift
//  TME-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

protocol LeafCategorySelectionDelegate: class {
    func leafCategorySelected(_ category: TMECategory?)
}

internal let kTMECategoryViewControllerIdentifier = "TMECategoryViewController"

class TMECategoryViewController: UITableViewController {
    
    private var isRootCategoryView: Bool = true
    
    weak var leafCategorySelectionDelegate: LeafCategorySelectionDelegate?
    
    private var category: TMECategory? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Category"
        
        // Init TableView
        let nib = UINib.init(nibName: kTMECategoryTableViewCellNibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: kTMECategoryTableViewCellReuseIdentifier)
        
        if isRootCategoryView {
            TMEDataCenter.shared.fetchRootCategory { (rootCategory, errString) in
                if let errString = errString {
                    self.showAlert("ERROR", "\(errString)")
                }
                else if let rootCategory = rootCategory {
                    self.category = rootCategory
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //--- Dispose of any resources that can be recreated.
    }
}

//--- MARK: UITableViewDataSource & UITableViewDelegate

extension TMECategoryViewController
{
    //--- UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section as Any, indexPath.row as Any)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let isLeaf = category?.subcategories[indexPath.row].isLeaf, isLeaf {
            leafCategorySelectionDelegate?.leafCategorySelected(category?.subcategories[indexPath.row])
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                if let listingViewController = leafCategorySelectionDelegate as? TMEListingViewController {
                    splitViewController?.showDetailViewController(listingViewController, sender: nil)
                }
            }
        }
        else {
            if let categoryViewController = storyboard.instantiateViewController(withIdentifier: kTMECategoryViewControllerIdentifier) as? TMECategoryViewController {
                categoryViewController.category = category?.subcategories[indexPath.row]
                categoryViewController.isRootCategoryView = false
                
                if let listingViewController = leafCategorySelectionDelegate as? TMEListingViewController {
                    categoryViewController.leafCategorySelectionDelegate = listingViewController
                }
                self.navigationController?.pushViewController(categoryViewController, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    //--- UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = category?.subcategories.count {
            return count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return category?.path
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kTMECategoryTableViewCellReuseIdentifier, for: indexPath) as? TMECategoryTableViewCell else {
            fatalError("The dequeued cell is not an instance of SelectedPlaceCell.")
        }
        cell.nameLabel.text = category?.subcategories[indexPath.row].name
        
        if let isLeaf = category?.subcategories[indexPath.row].isLeaf, isLeaf {
            cell.infoLabel.text = "listing"
        }
        else {
            cell.infoLabel.text = "subcategories"
        }
        return cell
    }
}

