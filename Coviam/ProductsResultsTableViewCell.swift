//
//  ProductsResultsTableView.swift
//  Coviam
//
//  Created by Chinnababu on 03/10/19.
//  Copyright © 2019 Chinnababu. All rights reserved.
//

import UIKit

class ProductsResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retailPriceLabel: UILabel!
    @IBOutlet weak var minPriceWithDiscount: UILabel!
    @IBOutlet weak var otherOffersStartingFromLabel: UILabel!
    @IBOutlet weak var minPrice: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func updateLabelData(nameText:String, retialText:String, rating:Int, minPriceWithDiscount:NSMutableAttributedString?, otherOffersStaringFrom:String?, offersCount:Int, imageUrl:String?){
        self.nameLabel.text = nameText
        self.retailPriceLabel.text = retialText
        self.otherOffersStartingFromLabel.text = String(format:"%d other offers starting from", offersCount)
        self.minPrice.text = otherOffersStaringFrom
        self.productImageView.clipsToBounds = true
        if imageUrl != nil{
            self.productImageView.downloadImageFrom(link: imageUrl!, contentMode: UIView.ContentMode.scaleAspectFit)
        }
        self.layoutSubviews()
    }
    
}
