//
//  CategoryCollectionViewCell.swift
//  E-Commerce
//
//  Created by William Santoso on 26/06/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(category: Category) {
        categoryImageView.sd_setImage(with: URL(string: category.imageURL))
        titleLabel.text = category.name
    }
}
