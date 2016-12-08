//
//  MainViewController.swift
//  sina框架
//
//  Created by 火星人 on 16/7/18.
//  Copyright © 2016年 火星人. All rights reserved.
//

class MessageViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var tableView: UITableView!
    private var slideBar: FDSlideBar!
    private var contentView: SlideBarContentView!
    
    lazy var data = {
        return NSMutableArray()
    }()
    var refreshHeader: RefreshNormalHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = ""
        setup()
         
    }
    
    let types = ["系统消息","公司通告","公司派单"]
    
    fileprivate func setup(){
        
        slideBar = FDSlideBar(frame: CGRect(x: 0, y: 0, width: self.view.sizeWidth, height: self.navigationController!.navigationBar.sizeHeight))
        
        slideBar.itemsTitle = ["要闻", "视频", "上海", "娱乐", "体育NBA", "财经", "科技", "社会", "军事", "时尚", "汽车", "游戏", "图片", "股票"]
        slideBar.slideBarItemSelectedCallback { [weak self] (index) in
            appPrint("\(index)")
            
            let rect = CGRect(x: index.floatValue * self!.contentView.sizeWidth, y: 0, width: self!.contentView.sizeWidth, height: self!.contentView.sizeHeight)
            self?.contentView.collectionView.scrollRectToVisible(rect, animated: true)
        }
        
        slideBar.itemColor = kAppTitleColor
        slideBar.itemSelectedColor = UIColor.brown
        slideBar.sliderColor = UIColor.brown
        
        self.navigationController?.navigationBar.addSubview(slideBar)
        
        
        
        contentView = SlideBarContentView(frame: self.view.bounds)
        contentView.numberOfSections = slideBar.itemsTitle.count
        self.view.addSubview(contentView)
        
        
        contentView.collectionViewWillShowCellHandle = {
            [weak self] (cell: SlideBarContentViewCell, indexPath: IndexPath) -> Void  in
            
            cell.tableView.backgroundColor = UIColor.randomColor()
            weak var wcell = cell
            cell.tableView.mj_header = RefreshNormalHeader(refreshingBlock: {
                [weak self] in
                
                doInMainThreadAfter(0.5, task: {
                    wcell?.tableView.mj_header.endRefreshing()
                })
                return
            })
            
            cell.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
            cell.tableView.delegate = self
            cell.tableView.dataSource = self
            
            
            self?.initData(index: indexPath.section)
            cell.tableView.reloadData()
            
            return
        }
        
        contentView.collectionViewDidShowCellHandle = {
            [weak self] (cell: SlideBarContentViewCell, indexPath: IndexPath) -> Void  in
            
            self?.slideBar.selectItem(at: indexPath.section.uIntValue)
            
            
            return
        }
        
        
        contentView.collectionView.reloadData()
        
        
        
        
//        tableView = UITableView(frame: self.view.bounds, style: .grouped)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.backgroundColor = kAppBackgroundColor
////        self.view.addSubview(tableView)
//        
//        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
//        
//        var contentInset = tableView.contentInset
//        contentInset.bottom = 130
//        tableView.contentInset = contentInset
//        
//        
//        
        // 下拉刷新
        refreshHeader = RefreshNormalHeader(refreshingBlock: {
            [weak self] in
            
            doInMainThreadAfter(0.5, task: {
                self?.refreshHeader.endRefreshing()
            })
            return
        })

//        tableView.mj_header = refreshHeader
    }
    
    override func initData() {
        data.removeAllObjects()
        
    }
    
    func initData(index: Int) {
        data.removeAllObjects()
        
        if self.slideBar == nil {
            return
        }
        let title = self.slideBar.itemsTitle[index]
        for i in 0 ... 10 {
            data.add("\(title)---------\(i)")
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = data[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeightZero
    }
     
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    
    
    // 选中某一行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}
