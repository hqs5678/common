//
//  UITextFielExtension_Extension.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



extension String{
    
    func boundWithSize(size:CGSize ,font:UIFont) -> CGRect{
        let newStr:NSString = NSString(string: self)
        
        return newStr.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil)
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " "))
    }
    
    func length() -> Int {
        return (self as NSString).length
    }
    
    func data2String(data:NSData) -> String{
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)
        return str as! String
    }
    
    func toFArray() -> NSArray!{
        if self.length() > 3 {
            let array = self.componentsSeparatedByString(",,,")
            return array
        }
        else {
            return nil
        }
    }
    
}
