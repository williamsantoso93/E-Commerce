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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let product = product else { return }
        productImage.sd_setImage(with: URL(string: product.imageURL))
        titleLabel.text = product.title
        let loved = product.loved == 1 ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: loved), for: .normal)
        
        descriptionLabel.text = product.productPromoDescription
        priceLabel.text = product.price
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func favoriteAction(_ sender: Any) {
        guard let product = product else { return }
        if product.loved == 1 {
            self.product?.loved = 0
        } else {
            self.product?.loved = 1
        }
        let loved = self.product?.loved == 1 ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: loved), for: .normal)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let items = [URL(string: "https://www.sehatq.com")!]


        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @IBAction func buyAction(_ sender: Any) {
        
    }
}
