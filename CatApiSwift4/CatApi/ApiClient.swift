//
//  ApiClient.swift
//  CatApi
//
//  Created by Emiko Clark on 3/24/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import Foundation

class ApiClient {
    // get data
    class func getData(completion: @escaping([Cat])->()) throws {
        let jsonUrlString = "https://chex-triplebyte.herokuapp.com/api/cats?page=1"
        guard let urlRequest = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else { print("error- data is nil"); return }
            print(data)
            
            do {
                let catArr =  try JSONDecoder().decode([Cat].self, from: data)
                completion(catArr)
            } catch let error {
                print("error converting json - \(error.localizedDescription)")
            }
            
            }.resume()
    }
}

