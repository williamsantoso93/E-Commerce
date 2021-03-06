//
//  Model.swift
//  E-Commerce
//
//  Created by William Santoso on 26/06/21.
//

import Foundation

// MARK: - Commerce
struct Commerce: Codable {
    var data: CommerceData
}

// MARK: - CommerceData
struct CommerceData: Codable {
    var category: [Category]
    var product: [Product]
    
    enum CodingKeys: String, CodingKey {
        case category
        case product = "productPromo"
    }
}

// MARK: - Category
struct Category: Codable {
    var imageURL: String
    var id: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case id, name
    }
}

// MARK: - ProductPromo
struct Product: Codable {
    var id: String
    var imageURL: String
    var title, productPromoDescription, price: String
    var loved: Int

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case title
        case productPromoDescription = "description"
        case price, loved
    }
}
