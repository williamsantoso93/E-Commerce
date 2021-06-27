//
//  PurchaseHistoryViewController.swift
//  E-Commerce
//
//  Created by William Santoso on 26/06/21.
//

import UIKit

class PurchaseHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var commerce: Commerce?
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UINib.init(nibName: "ListCardTableViewCell", bundle: nil), forCellReuseIdentifier: "ListCardTableViewCell")
        
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
                    self.tableView.reloadData()
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryToDetailSegue" {
            let controller = segue.destination as! DetailProductViewController
            controller.product = selectedProduct
        }
    }
}


extension PurchaseHistoryViewController: UITableViewDataSource, UITableViewDelegate, ListCardTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commerce?.data.product.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCardTableViewCell", for: indexPath) as! ListCardTableViewCell
        
        if let product = commerce?.data.product[indexPath.row] {
            cell.setupCell(product: product, at: indexPath.row)
        }
        cell.delegate = self
        
        return cell
    }
    
    func productTapped(at index: Int) {
        guard let product = commerce?.data.product[index] else { return }
        selectedProduct = product
        
        performSegue(withIdentifier: "HistoryToDetailSegue", sender: nil)
    }
}
