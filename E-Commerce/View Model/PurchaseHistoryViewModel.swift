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
            completion(true)
        } catch {
            print("error : ", error.localizedDescription)
            completion(false)
        }
    }
    
    func deleteAll(completion: @escaping (Bool) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductsHistory")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                }
            }
            try context.save()
            products.removeAll()
            completion(true)
        }
        catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func loadData() {
    }
}
