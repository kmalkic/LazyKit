//
//  MyViewControllerTableViewTest.swift
//  LazyKitDemo
//
//  Created by Kevin Malkic on 17/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit
import LazyKit

class MyViewControllerTableViewTest: LazyBaseViewController<MyTableConfigurations>, UITableViewDelegate, UITableViewDataSource {

    typealias Cell = MyCellConfigurations
    
    var tableView: UITableView!
    
    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = .white
        
        tableView = viewManager.element("tableView")
        
        tableView.register(LazyBaseTableViewCell<Cell>.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LazyBaseTableViewCell<Cell>
        
        cell.viewManager.label("title")?.text = "something"
        
        if let title: UILabel = cell.viewManager.element("title") {
        
            title.text = "new title"
        }
        
        return cell
    }
}
