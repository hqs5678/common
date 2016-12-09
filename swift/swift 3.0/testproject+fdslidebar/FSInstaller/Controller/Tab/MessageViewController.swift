//
//  MainViewController.swift
//  sina框架
//
//  Created by 火星人 on 16/7/18.
//  Copyright © 2016年 火星人. All rights reserved.
//

class MessageViewController: BaseViewController {
    
    private var slideBar: FDSlideBar!
    private var contentView: SlideBarContentView!
    
    lazy var agencyArray = {
        return NSMutableArray()
    }()
    var refreshHeader: RefreshNormalHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = ""
        setup()
         
    }
    
    fileprivate func setup(){
        
        slideBar = FDSlideBar(frame: CGRect(x: 0, y: 0, width: self.view.sizeWidth, height: self.navigationController!.navigationBar.sizeHeight))
        
        slideBar.itemsTitle = ["要闻", "视频", "上海", "娱乐", "体育NBA", "财经", "科技", "社会", "军事", "时尚", "汽车", "游戏", "图片", "股票"]
        slideBar.slideBarItemSelectedCallback { [weak self] (index) in
            appPrint("slideBar   \(index)")
            
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
        
        for _ in 0 ..< slideBar.itemsTitle.count {
            agencyArray.add(TableViewAgency())
        }
        
        contentView.collectionViewWillShowCellHandle = {
            
            [weak self] (cell: SlideBarContentViewCell, indexPath: IndexPath) -> Void  in
            
            weak var wcell = cell
            cell.tableView.mj_header = RefreshNormalHeader(refreshingBlock: {
                //[weak self] in
                
                doInMainThreadAfter(0.5, task: {
                    wcell?.tableView.mj_header.endRefreshing()
                })
            })
            cell.tableView.backgroundColor = kAppBackgroundColor
            
            let agency = self?.agencyArray.object(at: indexPath.section) as! TableViewAgency
            agency.data = self?.initData(index: indexPath.section)
            
            agency.tableView = cell.tableView
            cell.heightForRow = agency.heightForRow
            cell.tableView.reloadData()
            
            var contentInset = cell.tableView.contentInset
            contentInset.bottom = 130
            cell.tableView.contentInset = contentInset
            
            appPrint("\(indexPath.section)")
            return
        }
        
        contentView.collectionViewDidShowCellHandle = {
            [weak self] (cell: SlideBarContentViewCell, indexPath: IndexPath) -> Void  in
            
            self?.slideBar.selectItem(at: indexPath.section.uIntValue)
            appPrint("collectionViewDidShowCellHandle")
            
            return
        }
        
        
        contentView.collectionView.reloadData()
        
    }
    
    
    func initData(index: Int) -> NSArray {
        let dataArray = NSMutableArray()
        
        if self.slideBar == nil {
            return dataArray
        }
        let title = self.slideBar.itemsTitle[index]
        for i in 0 ... 10 {
            dataArray.add("\(title)---------\(i)")
        }
        return dataArray
    }
    
    
    
}

private class TableViewAgency: NSObject, UITableViewDataSource {
    
    var data: NSArray?
    var heightForRow = {
        (tableView: UITableView, indexPath: IndexPath) -> CGFloat in return 66
    }
    
    var tableView: UITableView? {
        didSet{
            didSetTableView()
        }
    }
    
    private func didSetTableView(){
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        tableView?.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = data {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.textLabel?.text = data?[indexPath.row] as? String
        return cell
    }
    
    
}
