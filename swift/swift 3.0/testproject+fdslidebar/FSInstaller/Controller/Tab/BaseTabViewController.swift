//
//  BaseTabViewController.swift
//  FSInstaller
//
//  Created by Apple on 2016/11/4.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class BaseTabViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tableView: UITableView!
    
    lazy var data = {
        return NSMutableArray()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup() 
    }
    
    func setup(){
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = kAppBackgroundColor
        self.view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        tableView.contentInset  = UIEdgeInsetsMake(0, 0, 140, 0)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
