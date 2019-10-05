 //
//  ProductionGridViewCell.swift
//  Coviam
//
//  Created by Chinnababu on 05/10/19.
//  Copyright © 2019 Chinnababu. All rights reserved.
//

import UIKit

class ProductionGridViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retailPriceLabel: UILabel!
    @IBOutlet weak var minPriceWithDiscount: UILabel!
    @IBOutlet weak var otherOffersStartingFromLabel: UILabel!
    @IBOutlet weak var minPrice: UILabel!
    @IBOutlet var collectionOfRatingButtons: Array<UIButton>?
    @IBOutlet weak var ratingLabel: UILabel!

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
        self.ratingLabel.text = ""
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
                let button = collectionOfRatingButtons![i]
                button.setImage(UIImage(named: "rateus_on"), for: .normal)
            }
            self.ratingLabel.text = String(format: "(%d)", ratingCount)
        }
        else{
            for button in collectionOfRatingButtons!{
                button.setImage(UIImage(named: "rateus_off"), for: .normal)
            }
            
        }
    }
}
