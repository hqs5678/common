//
//  SearchViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/8/3.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class SearchViewController: BaseTableViewController, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    let titleView = UIView()
    let model = BaseCellModel()
    var workSheetStatus: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.title = "搜索"
        
        self.setup()
    }
    
    fileprivate func setup(){
        
        // 设置搜索框
        titleView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 80, height: 40)
        let p: CGFloat = 3
        searchBar.frame = CGRect(x: 0, y: -p, width: SCREEN_WIDTH - 80, height: titleView.frame.size.height + p * 2)
        searchBar.barTintColor = self.navigationController?.navigationBar.barTintColor
        searchBar.tintColor = UIColor.orange
        searchBar.setTextColor(color: kAppTitleColor)
        searchBar.delegate = self
        searchBar.placeholder = "搜索"
        titleView.layer.masksToBounds = true
        
        titleView.addSubview(searchBar)
        self.navigationItem.titleView = titleView
        
        let bgview = UIView(frame: self.view.bounds)
        bgview.addTapWithHandle {[weak self] (tap) in
            self?.searchBar.resignFirstResponder()
        }
        
        self.tableView.insertSubview(bgview, at: 0)
    }
    
   
    override func initData() {
        
        let tmpArray = NSMutableArray()
        model.title = "请输入搜索条件"
        model.showSeparator = false
        tmpArray.add(model)
        data.add(tmpArray)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
  
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.textColor = UIColor.gray
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.title = "搜索: " + searchText
        if searchText.length() == 0 {
            model.title = "请输入搜索条件"
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        appPrint(self.model.title)
        
        if model.title == "请输入搜索条件" {
            self.makeToast(model.title)
            return
        }
        
        searchBarSearchButtonClicked(self.searchBar)
        
    }
    
    
}
