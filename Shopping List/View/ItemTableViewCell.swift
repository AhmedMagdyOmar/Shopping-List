//
//  ItemTableViewCell.swift
//  Shopping List
//
//  Created by Ahmed on 3/10/21.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func generateCell(_ item: Item) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        priceLabel.text = convertToCurrency(item.price)
        priceLabel.adjustsFontSizeToFitWidth = true
        
        if item.imageLink != nil  {
            dowwnloadImages(imageUrl: item.imageLink!) { (image) in
                self.itemImageView.image = image
            }
        }
    }
}



