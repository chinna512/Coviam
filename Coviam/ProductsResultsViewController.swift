//
//  ProductsResultsViewController.swift
//  Coviam
//
//  Created by Chinnababu on 03/10/19.
//  Copyright © 2019 Chinnababu. All rights reserved.
//

import UIKit

class ProductsResultsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var listGridButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var footerView: UIView!
    
    var productsListArray:NSMutableArray? = nil
    var viewModel:ProductsViewModel? = nil
    var tableView:UITableView?
    var selectedItemTitle:String? = nil
    var searchItemTitle:String? = nil
    var isGetResponse = true
    var isGrid = false
    var paginationCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem()
        button.title = "Custom"
        self.navigationItem.hidesBackButton = false
        self.navigationItem.setRightBarButtonItems([button], animated: true)
        self.navigationItem.title = searchItemTitle
        setUpCollectionView()
    }
    
    func setUpCollectionView(){
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        self.collectionView.register(UINib(nibName: "ProductionGridViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductionGridViewCell")
        collectionView.backgroundColor = UIColor.clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.getNumberOfProductsAvailable())!
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var nameText:String? = nil
        var retialText:String? = nil
        var otherOffersStaringFrom:String? = nil
        var offersCount:Int
        var rating:Int
        var ratingCount:Int
        var imageUrl:String? = nil
        var minPriceWithDiscount:NSMutableAttributedString? = nil
        
        if !isGrid{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
            (nameText, retialText, rating, ratingCount, minPriceWithDiscount, otherOffersStaringFrom, offersCount,imageUrl) = (viewModel?.getProductDetailsForIndexptah(index:indexPath.row))!
            cell.updateLabelData(nameText: nameText!, retialText: retialText!, rating: rating, ratingCount: ratingCount, minPriceWithDiscount: minPriceWithDiscount, otherOffersStaringFrom: otherOffersStaringFrom, offersCount: offersCount, imageUrl:imageUrl)
            cell.isUserInteractionEnabled = false
            cell.layoutSubviews()
            cell.layoutIfNeeded()
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductionGridViewCell", for: indexPath) as! ProductionGridViewCell
            (nameText, retialText, rating, ratingCount, minPriceWithDiscount, otherOffersStaringFrom, offersCount,imageUrl) = (viewModel?.getProductDetailsForIndexptah(index:indexPath.row))!
            cell.updateLabelData(nameText: nameText!, retialText: retialText!, rating: rating, ratingCount: rating, minPriceWithDiscount: minPriceWithDiscount, otherOffersStaringFrom: otherOffersStaringFrom, offersCount: offersCount, imageUrl:imageUrl)
            cell.isUserInteractionEnabled = false
            cell.layoutSubviews()
            cell.layoutIfNeeded()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !isGrid{
            return CGSize(width: view.frame.width, height: 297)
        }
        else{
            let frame = self.view.safeAreaLayoutGuide
            let orientation = UIApplication.shared.statusBarOrientation
            if orientation == .portrait{
                return CGSize(width: frame.layoutFrame.size.width/2 - 5, height: 560)
            }
            return CGSize(width: frame.layoutFrame.size.width/3, height: 560)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isGetResponse {
            if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height){
                if (Reachability()!.connection != .none){
                    paginationCount += 1
                    isGetResponse = false
                    let urlString = String(format: "https://www.blibli.com/backend/search/products?searchTerm=%@&start=%@&itemPerPage=24",self.searchItemTitle!, String(paginationCount))
                    RequestClass.getData(urlString: urlString, completionHandler: {
                        [weak self] (dict, error) in
                        if self != nil{
                            if error == nil{
                                self?.isGetResponse = true
                                if let productsArray = dict!["products"] as? NSArray {
                                    self!.viewModel!.parseData(productInfo: productsArray)
                                    DispatchQueue.main.async {
                                        self!.collectionView.reloadData()
                                    }
                                }
                            }
                            else if let code = dict!["code"] as? String{
                                self?.showAlert(message: code)
                            }
                        }
                    })
                }
            }
        }
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
    
    @IBAction func listGridModeAction(_ sender: Any) {
        let button = sender as! UIButton
        if isGrid{
            button.setTitle("Grid", for: .normal)
        }
        else{
            button.setTitle("List", for: .normal)
        }
        isGrid = !isGrid
        self.collectionView.reloadData()
    }
}

