//
//  ProductsResultsViewController.swift
//  Coviam
//
//  Created by Chinnababu on 03/10/19.
//  Copyright © 2019 Chinnababu. All rights reserved.
//

import UIKit

class ProductsResultsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var holderView: UIView!
    
    
    var productsListArray:NSMutableArray? = nil
    var viewModel:ProductsViewModel? = nil
    var tableView:UITableView?
    var selectedItemTitle:String? = nil
    var searchItemTitle:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setTitle(searchItemTitle!, subtitle: selectedItemTitle!)
        let button = UIBarButtonItem()
        button.title = "chinna"
        self.navigationItem.hidesBackButton = false
        let backItem = UIBarButtonItem()
        backItem.title = "Something Else"
        self.navigationItem.setRightBarButtonItems([button,button], animated: true)

    }

    func loadListView(){
        tableView = UITableView(frame: self.holderView.bounds)
        self.tableView!.register( UINib(nibName: "ProductsResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductsResultsTableViewCell")
        self.tableView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView?.dataSource = self
        tableView?.delegate = self
        self.holderView.addSubview(tableView!)
    }
    
    func loadGridView(){
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadListView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.getNumberOfProductsAvailable())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsResultsTableViewCell") as! ProductsResultsTableViewCell
        var nameText:String? = nil
        var retialText:String? = nil
        var otherOffersStaringFrom:String? = nil
        var offersCount:Int
        var rating:Int
        var imageUrl:String? = nil
        var minPriceWithDiscount:NSMutableAttributedString? = nil
        (nameText, retialText, rating, minPriceWithDiscount, otherOffersStaringFrom, offersCount,imageUrl) = (viewModel?.getProductDetailsForIndexptah(index:indexPath.row))!
        cell.updateLabelData(nameText: nameText!, retialText: retialText!, rating: rating, minPriceWithDiscount: minPriceWithDiscount, otherOffersStaringFrom: otherOffersStaringFrom, offersCount: offersCount, imageUrl:imageUrl)
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    func setTitle(_ title: String, subtitle: String) {
        let rect = CGRect(x: 0, y: 0, width: 400, height: 50)
        let titleSize: CGFloat = 20     // adjust as needed
        let subtitleSize: CGFloat = 15
        
        let label = UILabel(frame: rect)
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: title, attributes: [.font : UIFont.boldSystemFont(ofSize: titleSize)]))
        text.append(NSAttributedString(string: "\n\(subtitle)", attributes: [.font : UIFont.systemFont(ofSize: subtitleSize)]))
        label.attributedText = text
        self.navigationItem.titleView = label
    }
}

extension UINavigationItem {
    
    func setTitle(_ title: String, subtitle: String) {
        let one = UILabel()
        one.text = title
        one.font = UIFont.systemFont(ofSize: 17)
        one.sizeToFit()
        
        let two = UILabel()
        two.text = subtitle
        two.font = UIFont.systemFont(ofSize: 12)
        two.textAlignment = .center
        two.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let width = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        one.sizeToFit()
        two.sizeToFit()
        self.titleView = stackView
    }
}
