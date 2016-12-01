//
//  CheckButton.swift
//  FSInstaller
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

class CheckButton: UIButton {
    
    fileprivate let imgCheckView = CheckedBtn(type: .system)
    
    var checked = false {
        didSet{
            UIView.animate(withDuration: 0.2, animations: {
                var al: CGFloat = 1
                if self.checked {
                    al = 1
                }
                else {
                    al = 0
                }
                self.imgCheckView.alpha = al
            }) 
            
        }
    }

    lazy var imgChecked = UIImage(named: "check")
    lazy var imgNormal = UIImage(named: "radio-button")
    
    var titleColor = UIColor.blue {
        didSet{
            self.setTitleColor(titleColor, for: .normal)
        }
    }
    
    override var tintColor: UIColor! {
        didSet{
            imgCheckView.tintColor = tintColor
        }
    }
    
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
        
        self.imageView?.frame = self.imageRect(forContentRect: self.bounds)
        imgCheckView.frame = self.imageRect(forContentRect: self.bounds)
        imgCheckView.originY = 5
        imgCheckView.originX = 5
    }
    
    fileprivate func setup(){
        
        self.setImage(imgNormal, for: .normal)
        self.addSubview(imgCheckView)
        self.imageView?.contentMode = .scaleToFill
        imgCheckView.contentMode = .scaleAspectFill
         
        imgCheckView.setImage(imgChecked, for: .normal)
        
        self.checked = false
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let x: CGFloat = 4
        let y: CGFloat = 8
        let h: CGFloat = self.frame.size.height - 2 * y
        let w: CGFloat = h
        return CGRect(x: x , y: y , width: w , height: h)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let imgRect = self.imageRect(forContentRect: contentRect)
        
        let x: CGFloat = imgRect.maxX + 6
        let y: CGFloat = 0
        let h: CGFloat = self.frame.size.height
        let w: CGFloat = self.frame.size.width - x
        return CGRect(x: x , y: y , width: w , height: h)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.checked = !checked
    }
      
}

fileprivate class CheckedBtn: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        self.isUserInteractionEnabled = false
    }
    
    internal override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return self.bounds
    }
}

