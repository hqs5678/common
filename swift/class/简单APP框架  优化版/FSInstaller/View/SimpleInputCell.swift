//
//  SimpleInputCell.swift
//  formoney
//
//  Created by 火星人 on 16/4/10.
//  Copyright © 2016年 hqs. All rights reserved.
//

// 一个只有一个输入框的cell

class SimpleInputCell: BaseCell, UITextFieldDelegate {
    
    let textField: UITextField = UITextField()
    let button: UIButton = UIButton(type: UIButtonType.contactAdd)
    let switchButton: UISwitch = UISwitch()
    
    fileprivate let leftView: UIView = UIView()
    
    var inputModel: SimpleInputModel! {
        didSet{
            self.model = inputModel
            self.setupModel()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
    fileprivate func setup(){
        self.textField.frame = self.bounds 
        self.textField.delegate  = self
        self.textField.leftViewMode = .always
        self.textField.clearButtonMode = .always
        self.addSubview(self.textField)
        
        self.addSubview(switchButton)
        self.switchButton.addTarget(self, action: #selector(SimpleInputCell.valueChanged(_:)), for: UIControlEvents.valueChanged)
        
        self.addSubview(button)
        button.addTarget(self, action: #selector(SimpleInputCell.buttonClick), for: UIControlEvents.touchUpInside)
        
        let newTransform = self.button.transform.scaledBy(x: 2.0, y: 2.0);
        self.button.transform = newTransform
    }
    
    func valueChanged(_ switchButton: UISwitch){
        self.inputModel.isOn = switchButton.isOn
        inputModel.valueChanged(switchButton.isOn)
    }
    
    func buttonClick(){
        inputModel.buttonDidClick(self.button)
    }
    
    fileprivate func setupModel(){
        
        if inputModel.inputType == SimpleInputType.image {
            self.textField.isHidden = true
            self.button.isHidden = false
            self.switchButton.isHidden = true
            
            self.imageView?.image = inputModel.image
            let w: CGFloat = 80
            self.button.frame = CGRect(x: self.frame.size.width - w, y: 0, width: w, height: self.frame.size.height)
        }
        else if inputModel.inputType == SimpleInputType.switch {
            self.switchButton.isHidden = false
            self.button.isHidden = true
            self.textField.isHidden = true
            
            let p: CGFloat = self.switchButton.frame.size.width * 0.5 + 12
            self.switchButton.center = CGPoint(x: self.frame.size.width - p, y: self.frame.size.height * 0.5)
            
            if inputModel.isOn == nil {
                self.switchButton.isOn = false
            }
            else{
                self.switchButton.isOn = inputModel.isOn!
            }
            
            if inputModel.switchEnabel != nil {
                self.switchButton.isEnabled = inputModel.switchEnabel!
            }
            else {
                self.switchButton.isEnabled = true
            }
            self.textLabel?.text = inputModel.text
        }
        else{
            self.textField.isHidden = false
            self.button.isHidden = true
            self.switchButton.isHidden = true
            
            self.imageView?.image = nil
            self.textField.text = inputModel.text
            self.textField.placeholder = inputModel.placeholder
            self.leftView.frame = CGRect(x: 0, y: 0, width: self.inputModel.marginLeft, height: self.frame.size.height)
            self.textField.leftView = self.leftView
            if inputModel.keyboardType != nil {
                self.textField.keyboardType = inputModel.keyboardType!
            }
            if inputModel.secureTextEntry != nil {
                self.textField.isSecureTextEntry = inputModel.secureTextEntry!
            }
        }
    }
    
    func setModel(_ _model: SimpleInputModel, indexPath:IndexPath){
        self.inputModel = _model
        self.button.tag = (indexPath as NSIndexPath).section
    }
    
    
    /// text field delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.inputModel.text = self.textField.text! + string
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.inputModel.text = self.textField.text
    }
    

}
