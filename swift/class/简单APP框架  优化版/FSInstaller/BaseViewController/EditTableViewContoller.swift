//
//  EditTableViewContoller.swift
//  formoney
//
//  Created by 火星人 on 16/1/1.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


//
//  CustomerTableViewController.swift
//  formoney
//
//  Created by 火星人 on 15/9/20.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class EditTableViewController: UITableViewController {
    
    var addedKeyboardObserver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = kAppBackgroundColor
        self.tableView.registerClass(BaseCell.classForCoder(), forCellReuseIdentifier: "vcCell")
        
        // 去除tableview 后面多余的分割线
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        
        self.setAppearance()
    }
    
    func setAppearance(){
        
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kGroupDividerHeight
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func pushVC(vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVC(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    deinit{
        print("-----deinit \(self.classForCoder)-----")
    }
    
}
