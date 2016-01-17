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

        view.backgroundColor = .whiteColor()
        
        tableView = viewManager.element("tableView")
        
        tableView.registerClass(LazyBaseTableViewCell<Cell>.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! LazyBaseTableViewCell<Cell>
        
        if let title: UILabel = cell.viewManager.element("title") {
        
            title.text = "new title"
        }
        
        return cell
    }
}
