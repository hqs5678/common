//
//  MainViewController.swift
//  sina框架
//
//  Created by 火星人 on 16/7/18.
//  Copyright © 2016年 火星人. All rights reserved.
//
 

class TaskViewController: BaseTabViewController {
    
    fileprivate var menuView: QSSlideMenuView!
    
    var refreshHeader: RefreshNormalHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.tabBarItem.title
        
    }
    
    override func setup(){
        super.setup()
        
        tableView.register(BaseCell.classForCoder(), forCellReuseIdentifier: "BaseCell"); 
        
        setupData()
        
        // 下拉刷新
        refreshHeader = RefreshNormalHeader(refreshingBlock: {
            [weak self] in
            doInMainThreadAfter(1, task: {
                self?.refreshHeader.endRefreshing()
            })
            return
        }) 
        
        tableView.mj_header = refreshHeader
        
        // 添加搜索框
        addSearchBar()
        
    }
    
    fileprivate func addSearchBar(){
    
        let margin: CGFloat = 20
        var frame = CGRect(x: margin, y: 10, width: self.view.frame.size.width - margin * 2, height: 30)
        let searchView = UIView(frame: frame)
        self.tableView.addSubview(searchView)
        
        let borderColor = UIColor(hexString: "e5ddc6")
        searchView.setRoundAppearance(borderColor, cornerRadius: 5, backgroundColor: UIColor.white)
        
        let wh: CGFloat = searchView.sizeHeight * 0.43
        let offset: CGFloat = 40
        let imgView = UIImageView(frame: CGRect(x: frame.size.width * 0.5 - offset, y: (frame.size.height - wh) * 0.5, width: wh, height: wh))
        imgView.image = UIImage(named: "search")
        imgView.contentMode = .scaleAspectFit
        searchView.addSubview(imgView)
        
        frame.size.width = frame.size.width * 0.5
        frame.origin.y = imgView.originY
        frame.size.height = searchView.sizeHeight - imgView.originY * 2
        frame.origin.x = frame.size.width - offset + wh + 6
        let titleLabel = UILabel(frame: frame)
        titleLabel.text = "搜索任务"
        titleLabel.font = UIFont.systemFont(ofSize: wh)
        titleLabel.textAlignment = .left
        titleLabel.textColor = kAppTitleColor
        searchView.addSubview(titleLabel)
        
        searchView.addTapWithHandle { [weak self](tap) in
            let vc = SearchViewController()
            vc.hidesBottomBarWhenPushed = true
            self?.pushVC(vc)
        }
        
    }
    
    fileprivate func setupData(){
        
        let group = NSMutableArray()
        
        var cellModel = BaseCellModel()
        cellModel.title = "待上门"
        cellModel.iconImage = UIImage(named: "wait_door")
        cellModel.showIndicator = true
        cellModel.showSeparator = true
        cellModel.onSelected = {
            [weak self] in
            
        }
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.title = "进行中"
        cellModel.iconImage = UIImage(named: "ongoing")
        cellModel.showIndicator = true
        cellModel.showSeparator = true
        cellModel.onSelected = {
            [weak self] in
            
        }
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.showSeparator = true
        cellModel.title = "审核中"
        cellModel.iconImage = UIImage(named: "checking")
        cellModel.onSelected = {
            [weak self] in
            
        }
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.showSeparator = true
        cellModel.title = "审核失败"
        cellModel.iconImage = UIImage(named: "check_failure")
        cellModel.onSelected = {
            [weak self] in
            
        }
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.title = "已完成"
        cellModel.iconImage = UIImage(named: "completed")
        cellModel.showIndicator = true
        cellModel.showSeparator = true
        cellModel.onSelected = {
            [weak self] in
            
        }
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.showSeparator = true
        cellModel.title = "超时"
        cellModel.iconImage = UIImage(named: "overtime")
        cellModel.onSelected = {
            [weak self] in
             
            
        }
        group.add(cellModel)
        
        data.add(group)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = data[section] as! NSArray
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kAppRowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BaseCell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as! BaseCell
        let model = self.modelForIndexPath(indexPath)
        
        cell.model = model
        cell.imageMarginLeft = 10
        cell.imagePadding = 15
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelForIndexPath(indexPath)
        model.onSelected()
    }
    
    fileprivate func modelForIndexPath(_ indexPath: IndexPath) -> BaseCellModel {
        let model = (data.object(at: indexPath.section) as! NSArray).object(at: indexPath.row) as! BaseCellModel
        return model
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeightZero
    }

}
