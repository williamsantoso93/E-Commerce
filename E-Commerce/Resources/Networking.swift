//
//  Networking.swift
//  E-Commerce
//
//  Created by William Santoso on 26/06/21.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case decodingError
    case noData
}
 
class Networking {
    private init() { }
    
    static let shared = Networking()
    
    func getData(from urlString: String, completion: @escaping (Result<Commerce, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(.badUrl))
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print(urlString)
                return completion(.failure(.noData))
            }
            
            guard let decoded = try? JSONDecoder().decode([Commerce].self, from: data) else {
                print(urlString)
                print(String(data: data, encoding: .utf8) ?? "no data")
                return completion(.failure(.decodingError))
            }
            completion(.success(decoded.first!))
        }.resume()
    }
}
