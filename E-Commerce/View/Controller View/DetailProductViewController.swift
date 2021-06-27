//
//  DetailProductViewController.swift
//  E-Commerce
//
//  Created by William Santoso on 26/06/21.
//

import UIKit
import SDWebImage

class DetailProductViewController: UIViewController {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    var product: Product?
    var viewModel = DetailProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.product = product
        setupView()
    }
    
    func setupView() {
        guard let product = viewModel.product else { return }
        productImage.sd_setImage(with: URL(string: product.imageURL))
        titleLabel.text = product.title
        let loved = product.loved == 1 ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: loved), for: .normal)
        
        descriptionLabel.text = product.productPromoDescription
        priceLabel.text = product.price
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        guard let product = product else { return }
        if product.loved == 1 {
            viewModel.product?.loved = 0
        } else {
            viewModel.product?.loved = 1
        }
        let loved = viewModel.product?.loved == 1 ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: loved), for: .normal)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let items = [URL(string: "https://www.sehatq.com")!]

        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @IBAction func buyAction(_ sender: Any) {
        viewModel.buyProduct()
        guard let product = product else { return }
        let alert = UIAlertController(title: "Added Product", message: "You have added \(product.title)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
            self.navigationController?.popToRootViewController(animated: true)
        }))

        self.present(alert, animated: true)
    }
}
