//
//  RecipeTableViewCell.swift
//  FamilyRecipe
//
//  Created by Thiago Costa on 3/14/22.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipePhotoImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeShortDescLabel: UILabel!
    
    var onReuse: () -> Void = {}
    var recipe: Recipe?
    var loader = ImageLoader()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        recipePhotoImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureView() {
        guard let recipe = recipe else {
            return
        }
        configureImage()
        recipeNameLabel.text = recipe.name
        recipeShortDescLabel.text = recipe.shortDescription
        self.layoutSubviews()
    }
    
    private func configureImage() {
        guard let recipe = recipe else { return }
        recipePhotoImageView.contentMode = .scaleAspectFill
        imageView?.layer.cornerRadius = 8
        
        guard let url = URL(string: recipe.photoURL) else { return }
        
        let token = loader.loadImage(url) { [weak self] result in
            guard let self = self else { return }
            do {
                // 2
                let image = try result.get()
                // 3
                DispatchQueue.main.async {
                    self.recipePhotoImageView.image = image
                }
            } catch {
                // 4
                print(error)
            }
        }
        
        self.onReuse = {
            if let token = token {
                self.loader.cancelLoad(token)
            }
        }
    }
    
}

//var imageCache = NSCache<AnyObject,AnyObject>()
//
//extension UIImageView {
//    func loadImage(withUrl urlString: String) {
//        guard let url = URL(string: urlString) else {
//            return
//        }
//
//        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
//            self.image = image
//            return
//        }
//
//        DispatchQueue.global().async { [weak self] in
//           if let imageData = try? Data(contentsOf: url) {
//               if let image = UIImage(data: imageData) {
//                   DispatchQueue.main.async {
//                       imageCache.setObject(image, forKey: urlString as NSString)
//                       self?.image = image
//                   }
//               }
//           }
//        }
//    }
//}
