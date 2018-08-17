//
//  TMECategoryViewController.swift
//  TME-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

internal let kTMECategoryViewControllerIdentifier = "TMECategoryViewController"

class TMECategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var isRootCategoryView: Bool = true
    
    private var category: TMECategory? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Category"
        
        // Init TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.gray
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
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

extension TMECategoryViewController: UITableViewDataSource, UITableViewDelegate
{
    //--- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.section as Any, indexPath.row as Any)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let isLeaf = category?.subcategories[indexPath.row].isLeaf, isLeaf {
            if let listingViewController = storyboard.instantiateViewController(withIdentifier: kTMEListingViewControllerIdentifier) as? TMEListingViewController {
                listingViewController.category = category?.subcategories[indexPath.row]
                self.navigationController?.pushViewController(listingViewController, animated: true)
            }
        }
        else {
            if let categoryViewController = storyboard.instantiateViewController(withIdentifier: kTMECategoryViewControllerIdentifier) as? TMECategoryViewController {
                categoryViewController.category = category?.subcategories[indexPath.row]
                categoryViewController.isRootCategoryView = false
                self.navigationController?.pushViewController(categoryViewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    //--- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = category?.subcategories.count {
            return count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return category?.path
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

