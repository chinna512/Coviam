//
//  Products.swift
//  Coviam
//
//  Created by Chinnababu on 03/10/19.
//  Copyright © 2019 Chinnababu. All rights reserved.
//

import Foundation

struct Products1:Decodable {
    var id:String?
    var sku:String?
    var status:String?
    var name:String?
    var price:Price?
    var images:[String]?
    var brand:String?
    var rootCategory:RootCategory?
    var review:Review?
    var itemCount:Int?
    var defaultSku:String?
    var itemSku:String?
    var tags:[String]?
    
    private enum CodingKeys: String, CodingKey {
        case id, sku, status, name, price, brand, review, itemCount, defaultSku, itemSku, tags,images
    }
    
    init(rootCategory: RootCategory, review:Review, price:Price) {
        self.rootCategory = rootCategory
        self.review = review
        self.price = price
    }
    
    init(from decoder:Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.itemCount = try values.decode(Int.self, forKey: .itemCount)
        self.images = try values.decode([String].self, forKey: .images)
        self.tags = try values.decode([String].self, forKey: .tags)
        self.id = try values.decode(String.self, forKey: .id)
        self.sku = try values.decode(String.self, forKey: .sku)
        self.status = try values.decode(String.self, forKey: .status)
        self.brand = try values.decode(String.self, forKey: .brand)
        self.defaultSku = try values.decode(String.self, forKey: .defaultSku)
        self.itemSku = try values.decode(String.self, forKey: .itemSku)
        self.name = try values.decode(String.self, forKey: .name)
    }
}

struct Price1:Codable {
    var priceDisplay:String?
    var strikeThroughPriceDisplay:String?
    var discount:Int?
    var minPrice:Int
    
    private enum CodingKeys: String, CodingKey{
        case priceDisplay, strikeThroughPriceDisplay, discount, minPrice
    }
}

struct RootCategory1:Codable {
    var id:String?
    var name:String?
    private enum CodingKeys: String, CodingKey{
        case id, name
    }
}

struct Review1:Codable {
    var rating:Int
    var count:Int
    private enum CodingKeys: String, CodingKey{
        case rating, count
    }
}
