//
//  SimpleInputModel.swift
//  formoney
//
//  Created by 火星人 on 16/4/10.
//  Copyright © 2016年 hqs. All rights reserved.
//

enum  SimpleInputType{
    case Image
    case Switch
    case Text
}

class SimpleInputModel: NSObject {
    
    var title: String!
    var text: String!
    var placeholder: String!
    var marginLeft: CGFloat = 10.0
    var image: UIImage!
    var keyboardType: UIKeyboardType?
    var secureTextEntry: Bool?
    var isOn: Bool?
    var switchEnabel: Bool?
    
    var buttonDidClick = {
        (button: UIButton?) -> Void in
        return
    }
    
    var valueChanged = {
        (isOn: Bool) -> Void in
        return
    }
    
    var inputType: SimpleInputType = .Text

}
