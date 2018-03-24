//
//  MyTableViewController.swift
//  CatApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

//struct Cats: Decodable {
//    var cats: [Cat]?
//}

struct Cat: Decodable {
    var title: String?
    var image_url: String?
    var description: String?
}

//==========================================

class MyTableViewController: UITableViewController {
    var catArray = [Cat]()

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try getData(completion: { (catArr) in
                DispatchQueue.main.async {
                    self.catArray.append(contentsOf: catArr)
                    self.tableView.reloadData()
                }
            })
        } catch let error {
            print("error in getData")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        let url = URL(string: self.catArray[indexPath.row].image_url!)
        
        // download images async
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                cell.catImage.image = UIImage(data: data!)
            }
        }).resume()
    
        cell.title.text = self.catArray[indexPath.row].title
        cell.catDescription.text = self.catArray[indexPath.row].description
        return cell
    }
    
    //======================================
    
    // get data
    func getData(completion: @escaping([Cat])->()) throws {
        let jsonUrlString = "https://chex-triplebyte.herokuapp.com/api/cats?page=1"
        guard let urlRequest = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else { print("error- data is nil"); return }
            print(data)
            
            do {
                let catArr =  try JSONDecoder().decode([Cat].self, from: data)
                completion(catArr)
            } catch let error {
                print("error converting json")
            }
            
        }.resume()
    }
    
}
