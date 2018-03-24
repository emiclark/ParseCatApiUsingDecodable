//
//  MyTableViewController.swift
//  CatApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    var catArray: [Cat]?

    override func viewDidLoad() {
        super.viewDidLoad()

        ApiClient.getData(completion: { (CatArray) in

            DispatchQueue.main.async {
                print(CatArray)
                self.catArray = ApiClient.catsA

                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return catArray?.count
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        let url = URL(string: self.catArray![indexPath.row].image_url!)
        
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
    
        cell.title.text = self.catArray![indexPath.row].title
        cell.catDescription.text = self.catArray![indexPath.row].description
        return cell
    }    
}
