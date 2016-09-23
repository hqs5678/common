//
//  MeViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/8/1.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    fileprivate var tableView: UITableView!
    fileprivate let data = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.title = "我"
    }
 
   
    fileprivate func setup(){
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        var nib = UINib(nibName: "UserHeaderCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "UserHeaderCell")
        nib = UINib(nibName: "BaseCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "BaseCell")
        
        tableView.register(BaseCell.classForCoder(), forCellReuseIdentifier: "BaseCell");
        
        tableView.separatorStyle = .none
        
        var contentInset = tableView.contentInset
        contentInset.bottom = 130
        tableView.contentInset = contentInset
        
        // 初始化菜单列表
        setupData()
        
        setupRightItem()
    }
    
    fileprivate func setupData(){
        let user = User()
        user.userName = "盖伦"
        let bundle = Bundle.main
        user.avatar = bundle.path(forResource: "avatar.png", ofType: nil)!
        data.add(user)
        
        var group = NSMutableArray()
        
        var cellModel = BaseCellModel()
        cellModel.title = "新任务"
        cellModel.tail = "3"
        cellModel.iconImage = UIImage(named: "task-s")
        cellModel.showIndicator = true
        cellModel.showSeparator = true
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "进行中的任务"
        cellModel.tail = "1"
        cellModel.iconImage = UIImage(named: "task-s")
        cellModel.showSeparator = true
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "累计任务数"
        cellModel.tail = "43"
        cellModel.iconImage = UIImage(named: "task-s")
        cellModel.showSeparator = false
        group.add(cellModel)
        
        data.add(group)
        
        group = NSMutableArray()
        
        cellModel = BaseCellModel()
        cellModel.title = "我的订单"
        cellModel.iconImage = UIImage(named: "task-s")
        cellModel.showIndicator = true
        cellModel.showSeparator = true
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "我的钱包"
        cellModel.tail = "231.5元"
        cellModel.iconImage = UIImage(named: "task-s")
        cellModel.showSeparator = true
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "积分商城"
        cellModel.iconImage = UIImage(named: "task-s")
        cellModel.showSeparator = false
        group.add(cellModel)
        
        data.add(group)
        
        group = NSMutableArray()
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "服务地址管理"
        cellModel.iconImage = UIImage(named: "task-s")
        cellModel.showSeparator = true
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "联系客服"
        cellModel.iconImage = UIImage(named: "task-s")
        cellModel.showSeparator = true
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "推荐给好友"
        cellModel.iconImage = UIImage(named: "task-s")
        cellModel.showSeparator = true
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "更多设置"
        cellModel.iconImage = UIImage(named: "task-s")
        cellModel.showSeparator = false
        group.add(cellModel)
        
        
        data.add(group)
    }
    
    fileprivate func setupRightItem(){
        let rightItem = UIBarButtonItem(title: "设置", style: .plain, target: self, action: #selector(MeViewController.onRightBarItemClick))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc fileprivate func onRightBarItemClick(){
        let settingVC = SettingTableViewController(style: .grouped)
        settingVC.hidesBottomBarWhenPushed = true
        pushVC(settingVC)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return (data.object(at: section) as! NSArray).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserHeaderCell", for: indexPath) as! UserHeaderCell
            cell.user = data[0] as! User
            return cell
        }
        else {
            let cell: BaseCell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as! BaseCell
            let model = self.modelForIndexPath(indexPath)
            
            cell.model = model
            
            cell.imageMargin = 15
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).section == 0 {
            return 160
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.000001
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    fileprivate func modelForIndexPath(_ indexPath: IndexPath) -> BaseCellModel {
        let model = (data.object(at: (indexPath as NSIndexPath).section) as! NSArray).object(at: (indexPath as NSIndexPath).row) as! BaseCellModel
        return model
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}
