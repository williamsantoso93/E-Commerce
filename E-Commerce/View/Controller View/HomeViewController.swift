//
//  HomeViewController.swift
//  E-Commerce
//
//  Created by William Santoso on 26/06/21.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        tableView.register(UINib.init(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell")
        // Do any additional setup after loading the view.
        
//        fetchData()
    }

    func fetchData() {
        viewModel.fetchData { isSuccess in
            if isSuccess {
                self.collectionView.reloadData()
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDetailSegue" {
            let controller = segue.destination as! DetailProductViewController
            controller.product = viewModel.selectedProduct
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.commerce?.category.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryImageView.sd_setImage(with: URL(string: viewModel.commerce?.category[indexPath.row].imageURL ?? ""))
        cell.titleLabel.text = viewModel.commerce?.category[indexPath.row].name ?? ""
        return cell
        
    }
    
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, ProductListTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.commerce?.product.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
        
        cell.productImageView.sd_setImage(with: URL(string: viewModel.commerce?.product[indexPath.row].imageURL ?? ""))
        cell.titleLabel.text = viewModel.commerce?.product[indexPath.row].title ?? ""
        let loved = viewModel.commerce?.product[indexPath.row].loved == 1 ? "heart.fill" : "heart"
        cell.favoriteButton.setImage(UIImage(systemName: loved), for: .normal)
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    func favoriteAction(at index: Int) {
        if let loved = viewModel.commerce?.product[index].loved {
            if loved == 1 {
                viewModel.commerce?.product[index].loved = 0
            } else {
                viewModel.commerce?.product[index].loved = 1
            }
            tableView.reloadData()
        }
    }
    
    func productTapped(at index: Int) {
        guard let product = viewModel.commerce?.product[index] else { return }
        viewModel.selectedProduct = product
        
        performSegue(withIdentifier: "HomeToDetailSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "HomeToDetailSegue", sender: nil)
    }
}
