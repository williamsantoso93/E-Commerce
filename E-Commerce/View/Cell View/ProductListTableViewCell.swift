//
//  ProductListTableViewCell.swift
//  E-Commerce
//
//  Created by William Santoso on 26/06/21.
//

import UIKit

protocol ProductListTableViewCellDelegate {
    func favoriteAction(at index: Int)
    func productTapped(at index: Int)
}

class ProductListTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var delegate: ProductListTableViewCellDelegate?
    var index: Int = 0
    
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
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        delegate?.favoriteAction(at: index)
    }
    
    @objc func tapped() {
        delegate?.productTapped(at: index)
    }
}
