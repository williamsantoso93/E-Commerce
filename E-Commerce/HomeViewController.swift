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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        tableView.register(UINib.init(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell")
        // Do any additional setup after loading the view.
        
        fetchData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func fetchData() {
        Networking.shared.getData(from: "https://private-4639ce-ecommerce56.apiary-mock.com/home") { (result: Result<Commerce,NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    self.commerce = data
                    self.collectionView.reloadData()
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commerce?.data.productPromo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
        
        cell.productImageView.sd_setImage(with: URL(string: commerce?.data.productPromo[indexPath.row].imageURL ?? ""))
        cell.titleLabel.text = commerce?.data.productPromo[indexPath.row].title ?? ""
        let loved = commerce?.data.productPromo[indexPath.row].loved == 1 ? "heart.fill" : "heart"
        cell.favoriteButton.setImage(UIImage(systemName: loved), for: .normal)
        
        return cell
    }
    
    
}
