//
//  ForgetPasswordViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/8/10.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

class ForgetPasswordViewController: BaseTableViewController {

    fileprivate let modifyButton = UIButton()
    fileprivate let verButton = QSTimerButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "忘记密码"
    }
    
    override func initData() {
        let nib = UINib(nibName: "TextFieldCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "TextFieldCell")
        tableView.separatorStyle = .none
        
        var model = TextFieldCellModel()
        model.title = "手机号"
        model.content = "13100000000"
        model.icon = UIImage(named: "user")
        model.placeholder = "请输入手机号"
        model.keyboardType = .numberPad
        data.add(model)
        
        model = TextFieldCellModel()
        model.title = "验证码"
        model.content = ""
        model.icon = UIImage(named: "verificationcode")
        model.placeholder = "请填写验证码"
        model.keyboardType = .numberPad
        data.add(model)
        
        model = TextFieldCellModel()
        model.title = "新密码"
        model.content = ""
        model.icon = UIImage(named: "lock")
        model.placeholder = "请输入新密码,4~6位数字"
        model.keyboardType = .numberPad
        data.add(model)
        
        model = TextFieldCellModel()
        model.title = "新密码"
        model.content = ""
        model.icon = UIImage(named: "lock")
        model.placeholder = "请重新输入新密码"
        model.keyboardType = .numberPad
        data.add(model)
        
        // 添加修改按钮
        modifyButton.backgroundColor = UIColor.RGB(5, g: 161, b: 21)
        modifyButton.layer.cornerRadius = kCornerRadius
        let marginLeft: CGFloat = 20
        modifyButton.frame = CGRect(x: marginLeft, y: 0, width: self.view.frame.size.width -  2 * marginLeft, height: 33)
        modifyButton.setTitle("重  置", for: UIControlState())
        modifyButton.addTarget(self, action: #selector(ForgetPasswordViewController.modifyAction), for: .touchUpInside)
        modifyButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        modifyButton.titleLabel?.font = UIFont.systemFont(ofSize: kFontSizeNormal)
        self.view.addSubview(modifyButton)
        
        // 添加获取验证码按钮
        verButton.backgroundColorForNormal = UIColor.RGB(102, g: 66, b: 200)
        verButton.backgroundColorForDisable = UIColor.RGB(156, g: 130, b: 250)
        verButton.titleForNormal = "获取验证码"
        verButton.time = 5
        verButton.layer.cornerRadius = kCornerRadius
        verButton.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        verButton.titleLabel.font = UIFont.systemFont(ofSize: kFontSizeSmall)
        self.view.addSubview(verButton)
    }
    
    @objc fileprivate func modifyAction(){
        
        Helper.showProgressHUD()
        
        doInMainThreadAfter(2) {
            Helper.hideProgressHUD()
            self.popVC()
        }
    }
    
    @objc fileprivate func getVerificationCode(){
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var index = IndexPath(row: 0, section: 3)
        var cell = tableView.cellForRow(at: index)
        
        var frame = modifyButton.frame
        let marginTop: CGFloat = 20
        frame.origin.y  = cell!.frame.maxY + marginTop
        modifyButton.frame = frame
        
        index = IndexPath(row: 0, section: 1)
        cell = tableView.cellForRow(at: index)
        frame = verButton.frame
        frame.origin.x = self.view.frame.size.width - frame.size.width - 10
        frame.origin.y = (cell!.frame.size.height - frame.size.height) * 0.5 + cell!.frame.origin.y
        verButton.frame = frame
        
        verButton.onClickHandle = {
            [weak self] (button: QSTimerButton) -> Void in
            
            self?.view.endEditing(true)
            return
        }
    }
    
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
        cell.selectionStyle = .none
        
        let model = data[indexPath.section] as! TextFieldCellModel
        cell.model = model
        
        
        if indexPath.section >  1 {
            cell.contentTextField.isSecureTextEntry = true
        }
        else {
            cell.contentTextField.isSecureTextEntry = false
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0  || section == 2 {
            return 20
        }
        return 0.1
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kSeparatorHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
