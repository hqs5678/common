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
    let button: UIButton = UIButton(type: UIButtonType.ContactAdd)
    let switchButton: UISwitch = UISwitch()
    
    private let leftView: UIView = UIView()
    
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
        self.inputModel.isOn = switchButton.on
        inputModel.valueChanged(switchButton.on)
    }
    
    func buttonClick(){
        inputModel.buttonDidClick(self.button)
    }
    
    private func setupModel(){
        
        if inputModel.inputType == SimpleInputType.Image {
            self.textField.hidden = true
            self.button.hidden = false
            self.switchButton.hidden = true
            
            self.imageView?.image = inputModel.image
            let w: CGFloat = 80
            self.button.frame = CGRectMake(self.frame.size.width - w, 0, w, self.frame.size.height)
        }
        else if inputModel.inputType == SimpleInputType.Switch {
            self.switchButton.hidden = false
            self.button.hidden = true
            self.textField.hidden = true
            
            let p: CGFloat = self.switchButton.frame.size.width * 0.5 + 12
            self.switchButton.center = CGPointMake(self.frame.size.width - p, self.frame.size.height * 0.5)
            
            if inputModel.isOn == nil {
                self.switchButton.on = false
            }
            else{
                self.switchButton.on = inputModel.isOn!
            }
            
            if inputModel.switchEnabel != nil {
                self.switchButton.enabled = inputModel.switchEnabel!
            }
            else {
                self.switchButton.enabled = true
            }
            self.textLabel?.text = inputModel.text
        }
        else{
            self.textField.hidden = false
            self.button.hidden = true
            self.switchButton.hidden = true
            
            self.imageView?.image = nil
            self.textField.text = inputModel.text
            self.textField.placeholder = inputModel.placeholder
            self.leftView.frame = CGRectMake(0, 0, self.inputModel.marginLeft, self.frame.size.height)
            self.textField.leftView = self.leftView
            if inputModel.keyboardType != nil {
                self.textField.keyboardType = inputModel.keyboardType!
            }
            if inputModel.secureTextEntry != nil {
                self.textField.secureTextEntry = inputModel.secureTextEntry!
            }
        }
    }
    
    func setModel(_model: SimpleInputModel, indexPath:NSIndexPath){
        self.inputModel = _model
        self.button.tag = indexPath.section
    }
    
    
    /// text field delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.inputModel.text = self.textField.text! + string
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.inputModel.text = self.textField.text
    }
    

}
