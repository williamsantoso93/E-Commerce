//
//  SearchViewModel.swift
//  E-Commerce
//
//  Created by William Santoso on 27/06/21.
//

import Foundation

class SearchViewModel {
    var products: [Product]?
    var selectedProduct: Product?
    
    var searchText: String = ""
    
    var filterProducts: [Product] {
        return products?.filter {
            searchText.isEmpty ? false : $0.title.localizedStandardContains(searchText)
        } ?? []
    }
    
}
