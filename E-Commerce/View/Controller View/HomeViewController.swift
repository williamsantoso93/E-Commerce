//
//  HomeViewController.swift
//  E-Commerce
//
//  Created by William Santoso on 26/06/21.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    let categories = ["Celana", "Baju", "Topi", "Tas"]
    var commerce: Commerce?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        tableView.register(UINib.init(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell")
        // Do any additional setup after loading the view.
        
        fetchData()
    }

    func fetchData() {
        Networking.shared.getData(from: "https://private-4639ce-ecommerce56.apiary-mock.com/home") { (result: Result<Commerce,NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    self.commerce = data
                    self.collectionView.reloadData()
                    self.tableView.reloadData()
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDetailSegue" {
            let controller = segue.destination as! DetailProductViewController
            controller.product = selectedProduct
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commerce?.data.category.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryImageView.sd_setImage(with: URL(string: commerce?.data.category[indexPath.row].imageURL ?? ""))
        cell.titleLabel.text = commerce?.data.category[indexPath.row].name ?? ""
        return cell
        
    }
    
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, ProductListTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commerce?.data.product.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
        
        cell.productImageView.sd_setImage(with: URL(string: commerce?.data.product[indexPath.row].imageURL ?? ""))
        cell.titleLabel.text = commerce?.data.product[indexPath.row].title ?? ""
        let loved = commerce?.data.product[indexPath.row].loved == 1 ? "heart.fill" : "heart"
        cell.favoriteButton.setImage(UIImage(systemName: loved), for: .normal)
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    func favoriteAction(at index: Int) {
        if let loved = commerce?.data.product[index].loved {
            if loved == 1 {
                commerce?.data.product[index].loved = 0
            } else {
                commerce?.data.product[index].loved = 1
            }
            tableView.reloadData()
        }
    }
    func productTapped(at index: Int) {
        guard let product = commerce?.data.product[index] else { return }
        selectedProduct = product
        
        performSegue(withIdentifier: "HomeToDetailSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "HomeToDetailSegue", sender: nil)
    }
}
