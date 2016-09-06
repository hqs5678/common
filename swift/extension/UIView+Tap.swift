 

import UIKit
 
extension UIView {
    
    private struct AssociatedKeys {
        static var tapHandlePer = "tapHandlePer"
    }
    
    public func addTapWithHandle(tapHandle: (tap: UITapGestureRecognizer) -> Void){
        
        self.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTapGestureRecognizerHandle(_:)))
        self.addGestureRecognizer(tap)
        
        let tmpClass = TmpHandleClass()
        tmpClass.tapHandle = tapHandle
        setTapHandle(tmpClass)
    }
    
    @objc private func onTapGestureRecognizerHandle(tap: UITapGestureRecognizer){
        
        let tmpClass = objc_getAssociatedObject(self, &AssociatedKeys.tapHandlePer) as? TmpHandleClass
        if tmpClass != nil {
            tmpClass!.tapHandle(tap)
        }
    }
    
    private func setTapHandle(tapHandle: TmpHandleClass){
        objc_setAssociatedObject(self, &AssociatedKeys.tapHandlePer, tapHandle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
 
 
 }
 
class TmpHandleClass {
    
    var tapHandle = {
        (tap: UITapGestureRecognizer) -> Void in return
    }
 }

