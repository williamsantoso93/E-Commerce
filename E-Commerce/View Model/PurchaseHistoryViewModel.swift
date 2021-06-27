//
//  PurchaseHistoryViewModel.swift
//  E-Commerce
//
//  Created by William Santoso on 27/06/21.
//

import UIKit
import CoreData

class PurchaseHistoryViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var productsHistory: [ProductsHistory]?
    var products: [Product] = []
    
    func fetchData(completion: @escaping (Bool) -> Void) {
        loadData()
        completion(true)
    }
    
    func loadData() {
        let request: NSFetchRequest = ProductsHistory.fetchRequest()
        
        do {
            productsHistory = try context.fetch(request)
            products.removeAll()
                    
            for loadProductsHistory in productsHistory! {
                guard let decoded = try? JSONDecoder().decode(Product.self, from: (loadProductsHistory.product?.data(using: .utf8))!) else {
                    print("error Decoding")
                    return
                }
                products.append(decoded)
            }
        } catch {
            print("error parah : ", error)
        }
    }
}
