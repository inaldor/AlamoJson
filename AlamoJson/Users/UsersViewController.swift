//
//  UsersViewController.swift
//  AlamoJson
//
//  Created by inaldo on 02/09/2018.
//  Copyright © 2018 InaldoRRibeiro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var usersData: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        self.tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        fetchUsersData()
    }

    
    func fetchUsersData() {
        DispatchQueue.main.async {
             Alamofire.request("https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc").responseJSON(completionHandler: { (response) in
                
                switch response.result {
                    
                case .success(let value):
                    print(response.description)
                    let json = JSON(value)
                    let items = json["items"]
                    items[].array?.forEach({ (user) in
                        let user = UserModel(name: user["name"].stringValue, language: user["language"].stringValue)
                    self.usersData.append(user)
                    })
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
             })
        }
    }
    
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.usersData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UsersTableViewCell
            cell.nameLabel.text = self.usersData[indexPath.row].name
            cell.emailLabel.text = self.usersData[indexPath.row].language
            return cell
        }
    }
    

