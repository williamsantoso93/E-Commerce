//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by William Santoso on 27/06/21.
//

import Foundation

class HomeViewModel {
    var commerce: CommerceData?
    var selectedProduct: Product?
    
    func fetchData(completion: @escaping (Bool) -> Void) {
        Networking.shared.getData(from: "https://private-4639ce-ecommerce56.apiary-mock.com/home") { (result: Result<Commerce,NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    self.commerce = data.data
                    completion(true)
                case .failure(let error) :
                    print(error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
}
