//
//  SimpleInputCell.swift
//  formoney
//
//  Created by 火星人 on 16/4/10.
//  Copyright © 2016年 hqs. All rights reserved.
//

// 一个只有一个输入框的cell

class SimpleInputCell: UITableViewCell, UITextFieldDelegate {
    
    let textField: UITextField = UITextField()
    let button: UIButton = UIButton(type: UIButtonType.ContactAdd)
    let switchButton: UISwitch = UISwitch()
    
    private let leftView: UIView = UIView()
    
    var model: SimpleInputModel! {
        didSet{
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
    
     
    private func setup(){
        self.textField.frame = self.bounds 
        self.textField.delegate  = self
        self.textField.leftViewMode = .Always
        self.textField.clearButtonMode = .Always
        self.addSubview(self.textField)
        
        self.addSubview(switchButton)
        self.switchButton.addTarget(self, action: #selector(SimpleInputCell.valueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        self.addSubview(button)
        button.addTarget(self, action: #selector(SimpleInputCell.buttonClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        let newTransform = CGAffineTransformScale(self.button.transform, 2.0, 2.0);
        self.button.transform = newTransform
    }
    
    func valueChanged(switchButton: UISwitch){
        self.model.isOn = switchButton.on
        model.valueChanged(switchButton.on)
    }
    
    func buttonClick(){
        model.buttonDidClick(self.button)
    }
    
    private func setupModel(){
        
        if model.inputType == SimpleInputType.Image {
            self.textField.hidden = true
            self.button.hidden = false
            self.switchButton.hidden = true
            
            self.imageView?.image = model.image
            let w: CGFloat = 80
            self.button.frame = CGRectMake(self.frame.size.width - w, 0, w, self.frame.size.height)
        }
        else if model.inputType == SimpleInputType.Switch {
            self.switchButton.hidden = false
            self.button.hidden = true
            self.textField.hidden = true
            
            let p: CGFloat = self.switchButton.frame.size.width * 0.5 + 12
            self.switchButton.center = CGPointMake(self.frame.size.width - p, self.frame.size.height * 0.5)
            
            if model.isOn == nil {
                self.switchButton.on = false
            }
            else{
                self.switchButton.on = model.isOn!
            }
            
            if model.switchEnabel != nil {
                self.switchButton.enabled = model.switchEnabel!
            }
            else {
                self.switchButton.enabled = true
            }
            self.textLabel?.text = model.text
        }
        else{
            self.textField.hidden = false
            self.button.hidden = true
            self.switchButton.hidden = true
            
            self.imageView?.image = nil
            self.textField.text = model.text
            self.textField.placeholder = model.placeholder
            self.leftView.frame = CGRectMake(0, 0, self.model.marginLeft, self.frame.size.height)
            self.textField.leftView = self.leftView
            if model.keyboardType != nil {
                self.textField.keyboardType = model.keyboardType!
            }
            if model.secureTextEntry != nil {
                self.textField.secureTextEntry = model.secureTextEntry!
            }
        }
    }
    
    func setModel(_model: SimpleInputModel, indexPath:NSIndexPath){
        self.model = _model
        self.button.tag = indexPath.section
    }
    
    
    /// text field delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.model.text = self.textField.text! + string
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.model.text = self.textField.text
    }
    

}
