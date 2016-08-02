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
    
    private var rightBarButtonHandle = { }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = EditTableView(frame: self.tableView.frame, style: self.tableView.style)
        
        self.tableView.backgroundColor = App.appBackgroundColor
        
        tableView.registerClass(BaseCell.classForCoder(), forCellReuseIdentifier: "BaseCell")
        
        // 去除tableview 后面多余的分割线
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        
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
    
    func showRightBarButtonWithTitle(title: String, handler: (Void)->(Void)){
        let rightBtn = UIBarButtonItem(title: title, style: .Plain, target: self, action: #selector(BaseTableViewController.save))
        self.navigationItem.rightBarButtonItem = rightBtn
        self.rightBarButtonHandle = handler
    }
    
    @objc private func save(){
        self.view.endEditing(true)
        rightBarButtonHandle()
    }
    
    // 初始化界面数据 即model
    func initData(){
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        return (data.objectAtIndex(section) as! NSArray).count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:BaseCell = tableView.dequeueReusableCellWithIdentifier("BaseCell", forIndexPath: indexPath) as! BaseCell
        let cellModel:BaseCellModel = data.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! BaseCellModel
        cell.model = cellModel
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let cellModel = data.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! BaseCellModel
        cellModel.clickAction()
    }
    
    func modelForIndexPath(indexPath: NSIndexPath) -> AnyObject {
        
        let array = self.data.objectAtIndex(indexPath.section) as! NSArray
        let model = array.objectAtIndex(indexPath.row)
        return model
    }
    
    func modelForSection(section: Int, row: Int) -> AnyObject {
        
        let indexPath = NSIndexPath(forRow: row, inSection: section)
        return self.modelForIndexPath(indexPath)
    }
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view:UIView = UIView(frame: CGRectMake(0, 0, 100, 10))
//        view.backgroundColor = App.appGroupTableViewBackgroundColor
//        return view
//    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return App.groupDividerHeight
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
//
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return ""
//    }
    
    // 跳转界面
    func pushViewControllerWithId(storyBoardId:String){
        self.pushViewControllerWithId(storyBoardId, storyBoardName: "Main")
    }
    
    // 跳转界面
    func pushViewControllerWithId(storyBoardId:String, storyBoardName:String){
        let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier(storyBoardId, storyBoardName: storyBoardName)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 跳转界面
    func presentViewControllerWithId(storyBoardId:String){
        self.pushViewControllerWithId(storyBoardId, storyBoardName: "Main")
    }
    
    // 跳转界面
    func presentViewControllerWithId(storyBoardId:String, storyBoardName:String){
        let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier(storyBoardId, storyBoardName: storyBoardName)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // 设置状态栏的样式
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func tableViewReloadDataAtIndexPath(indexPath: NSIndexPath){
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
    }
    
    func tableViewReloadDataAtSection(section: Int, row: Int){
        let indexPath = NSIndexPath(forRow: row, inSection: section)
        self.tableViewReloadDataAtIndexPath(indexPath) 
    }
    
    func makeToast(message: String) {
        self.navigationController?.view.makeToast(message)
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

