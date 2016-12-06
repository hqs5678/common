//
//  BaseStaticTableViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class BaseStaticTableViewController: UITableViewController {

    let separatorLayer = CALayer()
    
    fileprivate var rightBarButtonHandle = {
        () -> () in
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = kAppBackgroundColor
        
        // 去除tableview 后面多余的分割线
        let view = UIView()
        view.backgroundColor = UIColor.clear
        
        separatorLayer.backgroundColor = kSeparatorColor.cgColor
        self.tableView.layer.insertSublayer(separatorLayer, at: 0)
        
        setup()
    }
    
    func setup(){
        
    }
    
    func showRightBarButtonWithTitle(_ title: String, handler: @escaping ()->()){
        let rightBtn = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(BaseStaticTableViewController.rightItemClick))
        self.navigationItem.rightBarButtonItem = rightBtn
        self.rightBarButtonHandle = handler
    }
    
    @objc fileprivate func rightItemClick(){
        rightBarButtonHandle()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kAppRowHeight
    }
    
    deinit{
        appPrint("-----deinit \(self.classForCoder)-----")
    }
}
