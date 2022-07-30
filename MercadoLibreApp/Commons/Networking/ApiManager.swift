//
//  ApiManager.swift
//  MercadoLibreApp
//
//  Created by Ema Rivero on 28/07/2022.
//

import Foundation
import Alamofire

class ApiManager {
    
    static let shared = ApiManager()
    
    func getList(query: String, completion: @escaping ([Product]) -> Void) {
        let url = "\(Constants.urlSearch)\(query)"
        AF.request(url).responseData { response in
            guard let data = response.data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(ProductList.self, from: data)
                completion(result.results)
            } catch {
                print (error.localizedDescription)
            }
        }
    }
}
