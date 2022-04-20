//
//  ItemVCell.swift
//  DevMnt Pro Del
//
//  Created by Ivan Ramirez on 1/19/22.
//

import UIKit

class ItemCVCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pizzaImage: UIImageView!
    @IBOutlet weak var cheeseLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    var pizza: Pizza? {
        didSet {
//            DispatchQueue.main.async {
//                self.updateViews()
//            }
           self.updateViews()
        }
    }
    
    override func awakeFromNib() {
        updateViews()
    }
    
    func updateViews() {
        guard let pizza = pizza else {
            return
        }

        nameLabel.text = pizza.name
        pizzaImage.image = UIImage(named: pizza.imageName)
        cheeseLabel.text = pizza.cheeseType
        priceLabel.text = "$ \(pizza.price)"
        
    }
}
