//
//  ScoreViewController.swift
//  MKTViewer
//
//  Created by Didier Plaindoux on 27/04/2017.
//
//

import UIKit
import Foundation


import UIKit

class ScoreViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView  =  UITableView()
    var items: [String] = ["Viper", "X", "Games"]

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame         =   CGRect(x: 0, y: 0, width: 500, height: 200)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
    }
    
}
