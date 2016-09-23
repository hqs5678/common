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
    var hiddenTabBar = true
    
    fileprivate var rightBarButtonHandle = { }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = EditTableView(frame: self.tableView.frame, style: self.tableView.style)
        
        self.tableView.backgroundColor = kAppBackgroundColor
        
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
        print("下拉刷新")
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
        let cellModel:BaseCellModel = (data.object(at: (indexPath as NSIndexPath).section) as AnyObject).object(at: (indexPath as NSIndexPath).row) as! BaseCellModel
        cell.model = cellModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let cellModel = (data.object(at: (indexPath as NSIndexPath).section) as AnyObject).object(at: (indexPath as NSIndexPath).row) as! BaseCellModel
        cellModel.clickAction()
    }
    
    func modelForIndexPath(_ indexPath: IndexPath) -> AnyObject {
        
        let array = self.data.object(at: (indexPath as NSIndexPath).section) as! NSArray
        let model = array.object(at: (indexPath as NSIndexPath).row)
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
        return 0.0001
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
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func tableViewReloadDataAtIndexPath(_ indexPath: IndexPath){
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableViewReloadDataAtSection(_ section: Int, row: Int){
        let indexPath = IndexPath(row: row, section: section)
        self.tableViewReloadDataAtIndexPath(indexPath) 
    }
    
    func makeToast(_ message: String) {
        self.navigationController?.view.makeToast(message)
    }
    
    
    func pushVC(_ vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVC(){
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit{
        print("-----deinit \(self.classForCoder)-----")
        
    }
    
    
   
    
}

