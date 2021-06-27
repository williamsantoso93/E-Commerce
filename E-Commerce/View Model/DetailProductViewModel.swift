//
//  DetailProductViewModel.swift
//  E-Commerce
//
//  Created by William Santoso on 27/06/21.
//

import UIKit
import CoreData

class DetailProductViewModel {
    var product: Product?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func buyProduct() {
        guard let product = product else { return }
        save(product)
    }
    
    func encodeToString(_ product: Product) -> String? {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(product)
            let encoded = String(data: data, encoding: .utf8)!
            return encoded
        } catch {
            print("error : ", error.localizedDescription)
        }
        
        return nil
    }
    
    func save(_ product: Product) {
        let productsHistoryEntity = NSEntityDescription.entity(forEntityName: "ProductsHistory", in: context)!
            
        let productsHistoryObject = NSManagedObject(entity: productsHistoryEntity, insertInto: context)
        
        guard let encodedData = encodeToString(product) else { return }
        
        productsHistoryObject.setValue(UUID(), forKey: "id")
        productsHistoryObject.setValue(encodedData, forKey: "product")
        do {
            try context.save()
        } catch {
            print("error : ", error.localizedDescription)
        }
    }
}
