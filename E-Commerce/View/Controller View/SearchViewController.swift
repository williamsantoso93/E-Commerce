//
//  SearchViewController.swift
//  E-Commerce
//
//  Created by William Santoso on 27/06/21.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product]?
    var viewModel = SearchViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib.init(nibName: "ListCardTableViewCell", bundle: nil), forCellReuseIdentifier: "ListCardTableViewCell")
        
        viewModel.products = products
        setupSearchBar()
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDetailSegue" {
            let controller = segue.destination as! DetailProductViewController
            controller.product = viewModel.selectedProduct
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, ListCardTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCardTableViewCell", for: indexPath) as! ListCardTableViewCell
        if let product = viewModel.products?[indexPath.row] {
            cell.setupCell(product: product, at: indexPath.row)
        }
        cell.delegate = self
        
        return cell
    }
    
    func productTapped(at index: Int) {
        if let product = viewModel.products?[index] {
            viewModel.selectedProduct = product
            
            performSegue(withIdentifier: "SearchToDetailSegue", sender: nil)
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}
