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
    
    var viewModel = PurchaseHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UINib.init(nibName: "ListCardTableViewCell", bundle: nil), forCellReuseIdentifier: "ListCardTableViewCell")
        
//        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func fetchData() {
        viewModel.fetchData { isSuccess in
            self.tableView.reloadData()
        }
    }
    
    @IBAction func deleteAllAction(_ sender: Any) {
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
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCardTableViewCell", for: indexPath) as! ListCardTableViewCell
        
        cell.setupCell(product: viewModel.products[indexPath.row], at: indexPath.row)
        cell.delegate = self
        
        return cell
    }
    
    func productTapped(at index: Int) {
        selectedProduct = viewModel.products[index]
        
        performSegue(withIdentifier: "HistoryToDetailSegue", sender: nil)
    }
}
