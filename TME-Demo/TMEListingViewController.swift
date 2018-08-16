//
//  TMEListingViewController.swift
//  TM-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

internal let kTMEListingViewControllerIdentifier = "TMEListingViewController"

class TMEListingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let kRootRableViewCellReuseIdentifier = "RootRableViewCellReuseIdentifier"
    
    let parser = DataParser()
    var listings: [SingleListing]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if self.listings?.count == 0 {
                    self.showAlert("Info", "Nothing found under this category.")
                }
            }
        }
    }
    
    var category: Category? {
        didSet {
            let requester = DataRequester()
            requester.fetchListing(category?.id) { (data, response, error) -> Void in
                self.parser.parseListingSearchResponse(data, error, completion: { (listings, errString) in
                    self.listings = listings
                    if let listings = self.listings {
                        print("listings.count: \(listings.count)")
                    }
                    else if let errString = errString {
                        print("errString: \(errString)")
                        self.showAlert("ERROR", "errString")
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Listing"
        
        // Init TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.gray
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        let nib = UINib.init(nibName: "CategoryTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: kCategoryTableViewCellReuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

//--- MARK: UITableViewDataSource & UITableViewDelegate

extension TMEListingViewController: UITableViewDataSource, UITableViewDelegate
{
    //--- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.section as Any, indexPath.row as Any)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        if let isLeaf = category?.subcategories[indexPath.row].isLeaf, isLeaf {
//            //--- TODO: show listing
//            if let listingViewController = storyboard.instantiateViewController(withIdentifier: kListingViewControllerIdentifier) as? ListingViewController {
//                listingViewController.category = category?.subcategories[indexPath.row]
//                self.navigationController?.pushViewController(listingViewController, animated: true)
//            }
//        }
//        else {
//            if let categoryViewController = storyboard.instantiateViewController(withIdentifier: kCategoryViewControllerIdentifier) as? CategoryViewController {
//                categoryViewController.category = category?.subcategories[indexPath.row]
//                categoryViewController.isRootCategoryView = false
//                self.navigationController?.pushViewController(categoryViewController, animated: true)
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    //--- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = listings?.count {
            return count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCategoryTableViewCellReuseIdentifier, for: indexPath) as? CategoryTableViewCell else {
            fatalError("The dequeued cell is not an instance of SelectedPlaceCell.")
        }
        cell.nameLabel.text = listings![indexPath.row].title
        
        return cell
    }
}