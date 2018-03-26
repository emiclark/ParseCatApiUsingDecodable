//
//  MyTableViewController.swift
//  CatApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    var catArray = [Cat]()
    var pageNum = 1
    var continuousScrollIndexPath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try ApiClient.getData(completion: { (catArr) in
                DispatchQueue.main.async {
                    self.catArray.append(contentsOf: catArr)
                    self.tableView.reloadData()
                }
            })
        } catch let error {
            print("error in getData - \(error)")
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if continuousScrollIndexPath != indexPath.row {
            continuousScrollIndexPath = indexPath.row
            let lastElement = catArray.count - 3
            if indexPath.row == lastElement {
                print("retrieving more images")
                do {
                    try ApiClient.getDataWithPageNum(pageNum: pageNum, completion: { (catArr) in
                        DispatchQueue.main.async {
                            self.catArray.append(contentsOf: catArr)
                            self.tableView.reloadData()
                        }
                    })
                } catch let error {
                    print(error.localizedDescription)
                }
                pageNum += 1
            }
        }
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
}
