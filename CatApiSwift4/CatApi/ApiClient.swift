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
    
    static func getDataWithPageNum(pageNum: Int, completion: @escaping([Cat])->()) throws {
        let urlString = "https://chex-triplebyte.herokuapp.com/api/cats?page=\(pageNum)"
        guard let url = URL(string:urlString) else {print("url unwrapping failed"); return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { print("data nil"); return }
            
                do {
                    let cats = try JSONDecoder().decode([Cat].self, from: data)
                    print("cats:\(cats)")
                    completion(cats)
                } catch let error {
                    print(error.localizedDescription)
                }
        }.resume()
    }

}

