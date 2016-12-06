//
//  CustomerTableViewController.swift
//  formoney
//
//  Created by 火星人 on 15/9/20.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

import MJRefresh

class BaseTableViewController: UITableViewController {
    
    var data:NSMutableArray = NSMutableArray()
    
    var tableViewStyle = UITableViewStyle.grouped
    
    
    fileprivate var rightBarButtonHandle = { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = EditTableView(frame: self.tableView.frame, style: tableViewStyle)
        
        self.tableView.backgroundColor = kAppBackgroundColor
        self.tableView.separatorStyle = .none
        
        tableView.register(BaseCell.classForCoder(), forCellReuseIdentifier: "BaseCell")
        
        // 去除tableview 后面多余的分割线
        let view = UIView()
        view.backgroundColor = UIColor.clear
        
        // 设置界面数据
        initData()
    }
    
    func mj_refresh() -> MJRefreshNormalHeader{
        let header = MJRefreshNormalHeader()
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(BaseTableViewController.headerRefresh))
        // 现在的版本要用mj_header
        self.tableView.mj_header = header
        return header
    }
    
    
    // 顶部刷新
    func headerRefresh(){
        appPrint("下拉刷新")
        // 结束刷新
        self.tableView.mj_header.endRefreshing()
    }
    
    func showRightBarButtonWithTitle(_ title: String, handler: @escaping (Void)->(Void)){
        let rightBtn = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(BaseTableViewController.save))
        self.navigationItem.rightBarButtonItem = rightBtn
        self.rightBarButtonHandle = handler
    }
    
    @objc fileprivate func save(){
        self.view.endEditing(true)
        rightBarButtonHandle()
    }
    
    // 初始化界面数据 即model
    func initData(){
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        return (data.object(at: section) as! NSArray).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:BaseCell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as! BaseCell
        let cellModel:BaseCellModel = (data.object(at: indexPath.section) as AnyObject).object(at: indexPath.row) as! BaseCellModel
        cell.model = cellModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let cellModel = (data.object(at: indexPath.section) as AnyObject).object(at: indexPath.row) as! BaseCellModel
        cellModel.onSelected()
    }
    
    func modelForIndexPath(_ indexPath: IndexPath) -> AnyObject {
        
        let array = self.data.object(at: indexPath.section) as! NSArray
        let model = array.object(at: indexPath.row)
        return model as AnyObject
    }
     
    
    func modelForSection(_ section: Int, row: Int) -> AnyObject {
        
        let indexPath = IndexPath(row: row, section: section)
        return self.modelForIndexPath(indexPath)
    }
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view:UIView = UIView(frame: CGRectMake(0, 0, 100, 10))
//        view.backgroundColor = App.appGroupTableViewBackgroundColor
//        return view
//    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kGroupDividerHeight
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeightZero
    }
//
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return ""
//    }
    
    // 跳转界面
    func pushViewControllerWithId(_ storyBoardId:String){
        self.pushViewControllerWithId(storyBoardId, storyBoardName: "Main")
    }
    
    // 跳转界面
    func pushViewControllerWithId(_ storyBoardId:String, storyBoardName:String){
        let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier(storyBoardId, storyBoardName: storyBoardName)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 跳转界面
    func presentViewControllerWithId(_ storyBoardId:String){
        self.pushViewControllerWithId(storyBoardId, storyBoardName: "Main")
    }
    
    // 跳转界面
    func presentViewControllerWithId(_ storyBoardId:String, storyBoardName:String){
        let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier(storyBoardId, storyBoardName: storyBoardName)
        self.present(vc, animated: true, completion: nil)
    }
    
    // 设置状态栏的样式
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.LightContent
//    }
    
    func tableViewReloadDataAtIndexPath(_ indexPath: IndexPath){
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableViewReloadDataAtSection(_ section: Int, row: Int){
        let indexPath = IndexPath(row: row, section: section)
        self.tableViewReloadDataAtIndexPath(indexPath) 
    }
      
    deinit{
        appPrint("-----deinit \(self.classForCoder)-----")
    }
     
}

