//
//  ProductCollectionViewCell.swift
//  Coviam
//
//  Created by Chinnababu on 05/10/19.
//  Copyright © 2019 Chinnababu. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retailPriceLabel: UILabel!
    @IBOutlet weak var minPriceWithDiscount: UILabel!
    @IBOutlet weak var otherOffersStartingFromLabel: UILabel!
    @IBOutlet weak var minPrice: UILabel!
    @IBOutlet var collectionOfButtons: Array<UIButton>? // = [UIButton]?
    @IBOutlet weak var ratingLabell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetImages()
    }
    
    func resetImages(){
        self.productImageView.image = nil
    }
    
    func updateLabelData(nameText:String, retialText:String, rating:Int, ratingCount:Int, minPriceWithDiscount:NSMutableAttributedString?, otherOffersStaringFrom:String?, offersCount:Int, imageUrl:String?){
        self.nameLabel.text = nameText
        self.retailPriceLabel.text = retialText
        self.minPriceWithDiscount.attributedText = minPriceWithDiscount
        self.ratingLabell.text = ""
        if offersCount != 0{
            self.otherOffersStartingFromLabel.text = String(format:"%d other offers starting from", offersCount)
            self.minPrice.text = otherOffersStaringFrom
        }
        else{
            self.otherOffersStartingFromLabel.text = ""
             self.minPrice.text = ""
        }
        self.productImageView.clipsToBounds = true
        if imageUrl != nil{
            self.productImageView.downloadImageFrom(link: imageUrl!, contentMode: UIView.ContentMode.scaleAspectFit)
        }
        if rating != 0{
            for i in 0..<rating{
                let button = collectionOfButtons![i]
                button.setImage(UIImage(named: "rateus_on"), for: .normal)
            }
            self.ratingLabell.text = String(format: "(%d)", ratingCount)
        }
        else{
            for button in collectionOfButtons!{
                button.setImage(UIImage(named: "rateus_off"), for: .normal)
            }
            
        }
    }
}
