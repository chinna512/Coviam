//
//  ViewController.swift
//  Coviam
//
//  Created by Chinnababu on 03/10/19.
//  Copyright © 2019 Chinnababu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel:ProductsViewModel? = nil
    var searchController:UISearchController? = nil
    var searchText = ""
    var suggestions:[String]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchBar()
        viewModel = ProductsViewModel()
        registerTableViewCellAndAssignDelegate()
    }
    
    func addSearchBar(){
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        searchController = UISearchController(searchResultsController: nil)
        searchController!.searchBar.delegate = self
        self.navigationItem.searchController = searchController
   }
    
    func registerTableViewCellAndAssignDelegate(){
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func showResultsForItemSelected(index:Int){
        let vc = ProductsResultsViewController()
        vc.searchItemTitle = searchText
        vc.selectedItemTitle = viewModel?.getNameOfProductForIndex(index: index)
        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchBar.text!
        viewModel?.removeAllcachedObjects()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }
        getDataForTheSearchKeyWord(keyWord: searchBar.text!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.suggestions != nil{
            return (suggestions?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?)!
        let displayName =  suggestions![indexPath.row]
        cell.textLabel?.text = displayName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showResultsForItemSelected(index: indexPath.row)
    }
    
    func getDataForTheSearchKeyWord(keyWord:String){
        let urlString = String(format: "https://www.blibli.com/backend/search/products?searchTerm=%@&start=0&itemPerPage=24", keyWord)
        RequestClass.getData(urlString: urlString, completionHandler: {
            [weak self] (dict, error) in
            if self != nil{
                self!.viewModel?.removeAllcachedObjects()
                if let productsArray = dict!["products"] as? NSArray {
                    self!.viewModel!.parseData(productInfo: productsArray)
                    self!.suggestions = self!.viewModel!.getProductNames()
                    DispatchQueue.main.async {
                        self!.tableView.reloadData()
                    }
                }
                else if dict!["code"] != nil{
                }
            }
        })
    }
    
    func showAlert(message:String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

