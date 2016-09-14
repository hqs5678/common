//
//  TaskProgressView.swift
//  FSInstaller
//
//  Created by Apple on 16/9/10.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class TaskProgressView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var progressTintColor = kAppGreenColor
    
    var rowHeight: CGFloat = 44
    
    var taskModel: TaskModel! {
        didSet{
            if tableView != nil {
                tableView.frame = CGRectMake(0, 0, self.frame.size.width, 60 * CGFloat(taskModel.statusArray.count))
                tableView.reloadData()
            }
        }
    }
    
    override var frame: CGRect {
        didSet{
            if tableView != nil {
                tableView.frame = self.bounds
            }
        }
    }
    
    private var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup(){
        
        self.backgroundColor = UIColor.clearColor()
        
        self.tableView = UITableView(frame: self.bounds, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.bounces = false
        tableView.separatorStyle = .None
        tableView.scrollEnabled = false
        tableView.allowsSelection = false
        self.addSubview(tableView)
        
        tableView.registerClass(TaskProgressCell.classForCoder(), forCellReuseIdentifier: "TaskProgressCell")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard taskModel != nil else {
            return 0
        }
        return taskModel.statusArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 任务进度
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskProgressCell", forIndexPath: indexPath) as! TaskProgressCell
        
        let tmpArray = taskModel.statusArray
        let model = tmpArray.objectAtIndex(indexPath.row) as! TaskStatusModel
        
        cell.progressTintColor = progressTintColor
        
        cell.taskStatusModel = model
        
        if indexPath.row == 0 {
            cell.position = TaskProgressCellPosition.top
        }
        else if indexPath.row == tmpArray.count - 1  {
            cell.position = TaskProgressCellPosition.bottom
        }
        else {
            cell.position = TaskProgressCellPosition.middle
        }
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
    

}
