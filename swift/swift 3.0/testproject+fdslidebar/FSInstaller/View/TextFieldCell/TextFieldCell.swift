//
//  TextFieldCell.swift
//  FSInstaller
//
//  Created by Apple on 16/8/5.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//
 

class TextFieldCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak fileprivate var marginLeftConstraint: NSLayoutConstraint!
    
    
    var textFieldDidBeginEditingHandle = {
        (textField: UITextField) -> Void in
        return
    }
    
    var model: TextFieldCellModel! {
        didSet{
            guard model != nil else {
                return
            }
            imageView?.image = model.icon
            titleLabel.text = model.title
            contentTextField.text = model.content
            contentTextField.keyboardType = model.keyboardType
            contentTextField.delegate = self
            contentTextField.placeholder = model.placeholder
            contentTextField.clearButtonMode = .whileEditing
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if imageView?.image != nil {
            marginLeftConstraint.constant = imageView!.frame.origin.x + imageView!.frame.size.width
        }
    }
    
    
 
    fileprivate func setup(){
        
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        contentTextField.borderStyle = .none
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.textFieldDidBeginEditingHandle(textField)
    }
    
    
}
