//
//  ProductListService.swift
//  MercadoLibreApp
//
//  Created by Ema Rivero on 01/08/2022.
//

import Foundation

class ProductListService {
    func getList(query: String, completionHandler: @escaping ([Product]) -> Void, errorHandler: @escaping (Error?) -> Void) {
        
        ApiManager.shared.getCall(query: query) { response in
            guard let data = response.data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(ProductList.self, from: data)
                completionHandler(result.results)
            } catch {
                print(error.localizedDescription)
            }
        } errorHandler: { error in
            errorHandler(error)
        }
    }
}
