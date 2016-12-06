//
//  MeViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/8/1.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//
  
class MeViewController: BaseTabViewController {
    
    fileprivate var tapUserHead: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我"
    }
    
    override func setup(){
        super.setup()
        
        
        let nib = UINib(nibName: "UserHeaderCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "UserHeaderCell")
        
        tableView.register(BaseCell.classForCoder(), forCellReuseIdentifier: "BaseCell");
        
        
        // 初始化菜单列表
        setupData()
        
        tapUserHead = UITapGestureRecognizer(target: self, action: #selector(MeViewController.onTapUserHead(_:)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
    
     
    
    fileprivate func setupData(){
        
        data.add(User.shared)
        
        let group = NSMutableArray()
        
        var cellModel = BaseCellModel()
        cellModel.title = "新任务"
        cellModel.tail = ""
        cellModel.iconImage = UIImage(named: "a-new-task")
        cellModel.showIndicator = true
        cellModel.showSeparator = true
//        cellModel.onSelected = {
//            [weak self] in
//            
//            let vc = TaskTableViewController()
//            vc.title = "新任务"
//            vc.statusString = "新任务"
//            self?.pushVCHidesBottomBar(vc)
//        }
        group.add(cellModel)
        
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "累计任务"
        cellModel.tail = ""
        cellModel.iconImage = UIImage(named: "the-cumulative")
//        cellModel.onSelected = {
//            [weak self] in
//            
//            let vc = TaskTableViewController()
//            vc.title = "累计任务"
//            vc.statusString = "累计任务"
//            self?.pushVCHidesBottomBar(vc)
//        }
        cellModel.showSeparator = true
        group.add(cellModel)
        
        
        cellModel = BaseCellModel()
        cellModel.title = "关于"
        cellModel.showIndicator = false
        cellModel.iconImage = UIImage(named: "about")
        cellModel.showSeparator = true
        cellModel.showIndicator = true
        cellModel.onSelected = {
            [weak self] in
            
            
            let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier("AboutUsViewController") as! AboutUsViewController
            self?.pushVCHidesBottomBar(vc)
            return
        }
        group.add(cellModel)
        
          
        cellModel = BaseCellModel()
        cellModel.showIndicator = true
        cellModel.title = "设置"
        cellModel.iconImage = UIImage(named: "set-up")
        cellModel.showSeparator = true
        cellModel.onSelected = {
            [weak self] in
            
            
            let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier("SettingViewController") as! SettingViewController
            
            self?.pushVCHidesBottomBar(vc)
            
            return
        }
        group.add(cellModel)
        
        data.add(group)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return (data.object(at: section) as! NSArray).count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserHeaderCell", for: indexPath) as! UserHeaderCell
            cell.user = data[0] as! User
            
            cell.imgView?.isUserInteractionEnabled = true
            cell.imgView?.addGestureRecognizer(tapUserHead)
            return cell
        }
        else {
            let cell: BaseCell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as! BaseCell
            let model = self.modelForIndexPath(indexPath)
            
            cell.model = model
            
            cell.imageMarginLeft = 10
            cell.imagePadding = 15
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return self.view.sizeWidth * 0.54
        }
        return kAppRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    
    fileprivate func modelForIndexPath(_ indexPath: IndexPath) -> BaseCellModel {
        let model = (data.object(at: indexPath.section) as! NSArray).object(at: indexPath.row) as! BaseCellModel
        return model
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
//            let vc = SettingUserInfoViewController()
//            self.pushVCHidesBottomBar(vc)
//            
            
            
//            let loginVC = ControllerHelper.controllerFromStoryBoardWithIdentifier("LoginViewController")
//            
//            self.pushVCHidesBottomBar(loginVC)
        }
        else {
            let tmpArray = data.object(at: indexPath.section) as! NSArray
            let model = tmpArray.object(at: indexPath.row) as! BaseCellModel
            model.onSelected()
        }
    }

    @objc func onTapUserHead(_ tap: UITapGestureRecognizer){
        self.selectSinglePic()
    }
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        // 上次图片
        
        
        // 保存到本地
        let path = Helper.userDocumentDir() + "/avatar.png"
        image.writeToFile(path)
        
        User.shared.avatar = path
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
