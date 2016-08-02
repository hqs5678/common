//
//  UITextFielExtension_Extension.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



extension UIView{
    
    func makeToast(message:String){
        self.makeToast(message, duration: 0, position: CGPointZero, fontSize: 0, animate: true)
    }
    
    func makeToast(message:String, animate:Bool){
        self.makeToast(message, duration: 0, position: CGPointZero, fontSize: 0, animate: animate)
    }
    
    func makeToast(message:String, position:CGPoint){
        self.makeToast(message, duration: 0, position: position, fontSize: 0, animate: true)
    }
    
    func makeToast(message:String, duration:UInt32){
        self.makeToast(message, duration: duration, position: CGPointZero, fontSize: 0, animate: true)
    }
    
    func makeToast(message:String, duration:UInt32, animate:Bool){
        self.makeToast(message, duration: duration, position: CGPointZero, fontSize: 0, animate: animate)
    }
    
    func makeToast(message:String, position:CGPoint, animate:Bool){
        self.makeToast(message, duration: 0, position: position, fontSize: 0, animate: animate)
    }
    
    func makeToast(message:String, duration:UInt32, position:CGPoint, animate:Bool){
        self.makeToast(message, duration: duration, position: position, fontSize: 0, animate: animate)
    }
    
    func makeToast(message:String, duration:UInt32, position:CGPoint, fontSize:CGFloat, animate:Bool){
        
        let toastLabel = UILabel()
        let toast = UIView()
        
        var fsize = fontSize
        if fsize <= 0 {
            fsize = 16
        }
        toastLabel.font = UIFont(name: toastLabel.font.fontName, size: fsize)
        toastLabel.textAlignment = NSTextAlignment.Center
        toastLabel.backgroundColor = UIColor.clearColor()
        toastLabel.textColor = UIColor.whiteColor()
        toastLabel.text = message
        toastLabel.sizeToFit()
        toast.addSubview(toastLabel)
        
        var frame = toastLabel.frame
        frame.size.width += 20
        frame.size.height += 15
        toast.frame = frame
        toastLabel.frame = frame
        if CGPointEqualToPoint(position, CGPointZero) {
            toast.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height - frame.size.height)
        }
        else {
            toast.center = position
        }
        
        toast.backgroundColor = UIColor.blackColor()
        toast.layer.cornerRadius = 5
        self.addSubview(toast)
        
        if animate {
            toast.alpha = 0
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                toast.alpha = 1
            }, completion: { (Bool) -> Void in
                
            })
        }
       
        
        let queue = dispatch_queue_create("toast_queue", DISPATCH_QUEUE_SERIAL)
        dispatch_async(queue, { () -> Void in
            if duration <= 0 {
                sleep(2)
            }
            else{
                sleep(duration)
            }
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.removeToast(toast, animate: true)
            })
        })
    }
    
    private func removeToast(toast:UIView, animate:Bool) {
        if animate{
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                toast.alpha = 0
            }, completion: { (Bool) -> Void in
                toast.removeFromSuperview()
            })
        }
        else{
            toast.removeFromSuperview()
        }
        
    }
   
    
}
