//
//  ListCardTableViewCell.swift
//  E-Commerce
//
//  Created by William Santoso on 26/06/21.
//

import UIKit

protocol ListCardTableViewCellDelegate {
    func productTapped(at index: Int)
}

class ListCardTableViewCell: UITableViewCell {
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var index: Int = 0
    
    var delegate: ListCardTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        contentView.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(product: Product, at index: Int) {
        listImage.sd_setImage(with: URL(string: product.imageURL))
        titleLabel.text = product.title
        priceLabel.text = product.price
        self.index = index
    }
    
    @objc func tapped() {
        delegate?.productTapped(at: index)
    }
}
