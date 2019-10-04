//
//  Products.swift
//  Coviam
//
//  Created by Chinnababu on 03/10/19.
//  Copyright © 2019 Chinnababu. All rights reserved.
//

import Foundation

struct Product {
    var id:String?
    var sku:String?
    var status:String?
    var name:String?
    var brand:String?
    var itemCount:Int?
    var defaultSku:String?
    var itemSku:String?
    var tags:[String]?
    var images:[String]?
    var price:Price?
    var rootCategory:RootCategory?
    var review:Review?
    var otherOffers:OtherOffers?
    
    init(dict:NSDictionary) {
        if let id = dict["id"] as? String{
            self.id = id
        }
        if let sku = dict["sku"] as? String{
            self.sku = sku
        }
        if let status = dict["status"] as? String{
            self.status = status
        }
        if let name = dict["name"] as? String{
            self.name = name
        }
        if let brand = dict["brand"] as? String{
            self.brand = brand
        }
        if let defaultSku = dict["defaultSku"] as? String{
            self.defaultSku = defaultSku
        }
        if let itemSku = dict["itemSku"] as? String{
            self.itemSku = itemSku
        }
        if let itemCount = dict["itemCount"] as? Int{
            self.itemCount = itemCount
        }
        
        if let price = dict["price"] as? NSDictionary{
            self.price = Price(dict: price)
        }
        if let otherOffer = dict["otherOfferings"] as? NSDictionary{
            self.otherOffers = OtherOffers(dict: otherOffer)
        }
        if let rootCategory = dict["rootCategory"] as? NSDictionary{
            self.rootCategory = RootCategory(dict: rootCategory)
        }
        if let review = dict["review"] as? NSDictionary{
            self.review = Review(dict: review)
        }
        if let images = dict["images"] as? NSArray{
            self.images = (images as! [String])
        }
        if let tags = dict["tags"] as? NSArray{
            self.tags = tags as? [String]
        }
    }
}

struct Price {
    var priceDisplay:String?
    var strikeThroughPriceDisplay:String?
    var discount:Int?
    var minPrice:Int
    
    init(dict:NSDictionary){
        if let priceDisplay = dict["priceDisplay"] as? String{
            self.priceDisplay = priceDisplay
        }
        if let strikeThroughPriceDisplay = dict["strikeThroughPriceDisplay"] as? String{
            self.strikeThroughPriceDisplay = strikeThroughPriceDisplay
        }
        if let discount = dict["discount"] as? Int{
            self.discount = discount
        }
        else{
            self.discount = 0
        }
        if let minPrice = dict["minPrice"] as? Int{
            self.minPrice = minPrice
        }
        else{
            self.minPrice = 0
        }
    }
    
}

struct RootCategory {
    var id:String?
    var name:String?
    
    init(dict:NSDictionary){
        if let id = dict["id"] as? String{
            self.id = id
        }
        if let name = dict["name"] as? String{
            self.name = name
        }
    }
    
}

struct Review{
    var rating:Int
    var count:Int
    init(dict:NSDictionary){
        if let rating = dict["rating"] as? Int{
            self.rating = rating
        }
        else{
           self.rating = 0
        }
        if let count = dict["count"] as? Int{
            self.count = count
        }
        else{
            self.count = 0
        }
    }
}

struct OtherOffers{
    var count:Int
    var startPrice:String?
    
    init(dict:NSDictionary){
        if let startPrice = dict["startPrice"] as? String{
            self.startPrice = startPrice
        }
        else{
            self.startPrice =  ""
        }
        if let count = dict["count"] as? Int{
            self.count = count
        }
        else{
            self.count = 0
        }
    }
}

