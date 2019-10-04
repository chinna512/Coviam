//
//  ProductsViewModel.swift
//  Coviam
//
//  Created by Chinnababu on 03/10/19.
//  Copyright © 2019 Chinnababu. All rights reserved.
//

import Foundation
import UIKit

struct ProductsViewModel{

    private var productResultArray = [Product]()
    mutating func addProductToArray(product:Product){
        productResultArray.append(product)
    }
    
    mutating func parseData(productInfo:NSArray) {
        for modelData in productInfo{
            let model = Product(dict: modelData as! NSDictionary)
            addProductToArray(product: model)
        }
    }

    mutating func removeAllcachedObjects(){
        productResultArray.removeAll()
    }
    
    func getNumberOfProductsAvailable() -> Int{
            return productResultArray.count
    }
    
    func getNameOfProductForIndex(index:Int) -> String{
        let product = productResultArray[index]
        return product.name!
    }
    
    func getProductDetailsForIndexptah(index:Int) -> (nameText:String?, retialText:String?, rating:Int, minPriceWithDiscount:NSMutableAttributedString?, otherOffersStaringFrom:String?, offersCount:Int, imageUrl:String?){
        
        let product = productResultArray[index]
        var discountCombination:NSMutableAttributedString? = nil
        var otherofferString:String? = nil
        var otherMinPrice = 0
        var imageUrl:String? = nil
        
        if let price = product.price{
            if price.strikeThroughPriceDisplay != nil{
                let attributes: [NSAttributedString.Key : Any] = [
                    NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.purple,
                    NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "lightGray", size:20) ??
                        UIFont.systemFont(ofSize: 10),
                    NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineStyle.rawValue): NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key(rawValue: NSAttributedString.Key.strikethroughStyle.rawValue):  NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key(rawValue: NSAttributedString.Key.strikethroughColor.rawValue): UIColor.lightGray
                ]
                let strokeString = NSAttributedString(string: (price.strikeThroughPriceDisplay)!, attributes: attributes)
                let discountAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "Red", size:20) ??
                    UIFont.systemFont(ofSize: 20)]
                let disCountString = NSAttributedString(string: String(format: "  %d % OFF",(price.discount)!), attributes: discountAttribute)
                discountCombination = NSMutableAttributedString()
                discountCombination!.append(strokeString)
                discountCombination!.append(disCountString)
            }
            else if price.minPrice != nil{
                
            }
        }
        if let otherOffers = product.otherOffers{
            if otherOffers.startPrice != nil{
                otherofferString = otherOffers.startPrice
                otherMinPrice = otherOffers.count
            }
        }
        if let images = product.images{
            imageUrl = images[0]
        }
        return (product.name!, (product.price?.priceDisplay)!, product.review!.rating, discountCombination, otherofferString, otherMinPrice, imageUrl)
    }
}
