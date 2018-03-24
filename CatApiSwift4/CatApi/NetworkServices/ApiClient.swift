//
//  ApiClient.swift
//  CatApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import Foundation

class ApiClient {
    
    static var catsA = [Cat]()

//    func getCoursesInfo() {
    
    class func getData(completion: @escaping(Array<Any>)->()) {
        let jsonUrlString = "https://chex-triplebyte.herokuapp.com/api/cats?page=1"
        guard let urlRequest = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else { print("error- data is nil"); return }
            print(data)
            
            do {
                let catsArray =  try JSONDecoder().decode([Cat].self, from: data)
//                print("\n [Cats]\n", websiteDescription.name as Any, websiteDescription.description as Any, websiteDescription.courses as Any )
                
                
//                DispatchQueue.main.async {
                    for cat in catsArray {
                        print(cat.title, cat.description, cat.image_url)
                    }
                    completion(catsArray)
//                }
                
            } catch {
                print("error converting json")
            }
            
            }.resume()
    }
    
 //==================================
    
    
    
    
    
//    class func getData(completion: @escaping(Array<Any>)->()) {
//        let urlString = "https://chex-triplebyte.herokuapp.com/api/cats?page=1"
//        
//        let urlConverted = URL(string: urlString)
//        
//        guard let url = urlConverted else {print("error in url"); return }
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            guard let data = data else { print("data nil"); return }
//            
//            guard let cats = try? JSONDecoder().decode([Cat].self, from: data) else {print("decodable failed"); return }
//
//            DispatchQueue.main.async {
//                for cat in cats {
//                    print(cat.title, cat.description, cat.image_url)
//                }
//                completion(catsA)
//            }
//            
//        }.resume()
//    }
}

//=========

// vc ==
//ApiClient.getData(completion: { (CatArray) in
//    print(CatArray)
//    DispatchQueue.main.async {
//        self.tableView.reloadData()
//    }
//})

//class func getData(completion: @escaping(Array<Any>)->()) {
//    let urlString = "https://chex-triplebyte.herokuapp.com/api/cats?page=1"
//
//    let urlConverted = URL(string: urlString)
//
//    guard let url = urlConverted else {print("error in url"); return }
//
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//        guard let data = data else { print("data nil"); return }
//
//
//        completion(json)
//
//        }
//        .resume()
//
//}
//=======================
//class ApiClient {
//
//    class func getData(completion: @escaping(Array<Any>)->()) {
//        let urlString = "https://chex-triplebyte.herokuapp.com/api/cats?page=1"
//
//        let urlConverted = URL(string: urlString)
//
//        guard let url = urlConverted else {print("error in url"); return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            guard let data = data else { print("data nil"); return }
//
//            let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as! Array<Any>
//
//            guard let json = jsonDict else {print("json nil"); return }
//            completion(json)
//
//            }
//            .resume()
//
//    }
//}

