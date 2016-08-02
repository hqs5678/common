//
//  MeViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/8/1.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    private var tableView: UITableView!
    private let data = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.title = "我"
    }
 
   
    private func setup(){
        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        var nib = UINib(nibName: "UserHeaderCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(nib, forCellReuseIdentifier: "UserHeaderCell")
        nib = UINib(nibName: "BaseCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(nib, forCellReuseIdentifier: "BaseCell")
        
        tableView.registerClass(BaseCell.classForCoder(), forCellReuseIdentifier: "BaseCell");
        
        tableView.separatorStyle = .None
        
        var contentInset = tableView.contentInset
        contentInset.bottom = 130
        tableView.contentInset = contentInset
        
        let user = User()
        user.userName = "莫甘娜"
        user.avatar = "head"
        data.addObject(user)
        
        let group1 = NSMutableArray()
        
        var cellModel = BaseCellModel()
        cellModel.title = "我的订单"
        cellModel.showIndicator = true
        cellModel.showSeparator = true
        group1.addObject(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "我的钱包"
        cellModel.tail = "231.5元"
        cellModel.showSeparator = true
        group1.addObject(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "积分商城"
        cellModel.showSeparator = false
        group1.addObject(cellModel)
        
        data.addObject(group1)
        
        let group2 = NSMutableArray()
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "服务地址管理"
        cellModel.showSeparator = true
        group2.addObject(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "联系客服"
        cellModel.showSeparator = true
        group2.addObject(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "推荐给好友"
        cellModel.showSeparator = true
        group2.addObject(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "更多设置"
        cellModel.showSeparator = false 
        group2.addObject(cellModel)
        
        
        data.addObject(group2)
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return (data.objectAtIndex(section) as! NSArray).count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UserHeaderCell", forIndexPath: indexPath)
            return cell
        }
        else {
            let cell: BaseCell = tableView.dequeueReusableCellWithIdentifier("BaseCell", forIndexPath: indexPath) as! BaseCell
            let model = self.modelForIndexPath(indexPath)
            
            cell.model = model
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        }
        return 50
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.000001
        }
        return 20
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    private func modelForIndexPath(indexPath: NSIndexPath) -> BaseCellModel {
        let model = (data.objectAtIndex(indexPath.section) as! NSArray).objectAtIndex(indexPath.row) as! BaseCellModel
        return model
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}
