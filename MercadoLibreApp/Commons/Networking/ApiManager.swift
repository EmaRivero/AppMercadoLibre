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
    
    func getCall(query: String, completionHandler: @escaping (AFDataResponse<Data?>) -> Void, errorHandler: @escaping (AFError) -> Void) {
        let url = "\(Constants.urlSearch)\(query)"

        AF.request(url).validate().response { response in
            if let error = response.error {
                errorHandler(error)
            } else {
                completionHandler(response)
            }
        }
    }
}


