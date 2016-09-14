//
//  CheckButton.swift
//  FSInstaller
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

class CheckButton: UIButton {
    
    private let imgView = UIImageView()
    private let imgCheckView = UIImageView()
    
    var checked = false {
        didSet{
            UIView.animateWithDuration(0.2) {
                var al: CGFloat = 1
                if self.checked {
                    al = 1
                }
                else {
                    al = 0
                }
                self.imgCheckView.alpha = al
            }
            
        }
    }

    var imgChecked = UIImage(named: "check")
    var imgNormal = UIImage(named: "radio-button")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgView.frame = self.imageRectForContentRect(self.bounds)
        imgCheckView.frame = self.imageRectForContentRect(self.bounds)
        imgCheckView.originY = 5
        imgCheckView.originX = 5
    }
    
    private func setup(){
        self.addSubview(imgView)
        self.addSubview(imgCheckView)
        imgView.contentMode = .ScaleToFill
        imgCheckView.contentMode = .ScaleAspectFill
        
        imgView.image = imgNormal
        imgCheckView.image = imgChecked
        
        self.checked = false
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let x: CGFloat = 4
        let y: CGFloat = 8
        let h: CGFloat = self.frame.size.height - 2 * y
        let w: CGFloat = h
        return CGRectMake(x , y , w , h)
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let imgRect = self.imageRectForContentRect(contentRect)
        
        let x: CGFloat = CGRectGetMaxX(imgRect) + 6
        let y: CGFloat = 0
        let h: CGFloat = self.frame.size.height
        let w: CGFloat = self.frame.size.width - x
        return CGRectMake(x , y , w , h)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        self.checked = !checked
    }

}
