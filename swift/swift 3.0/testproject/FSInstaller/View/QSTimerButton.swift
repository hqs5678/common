//
//  QSTimerButton.swift
//  FSInstaller
//
//  Created by Apple on 16/8/10.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

class QSTimerButton: UIView {
    
    var titleLabel = UILabel()
    
    fileprivate var timer: Timer!
    
    var titleForNormal = "获取验证码" {
        didSet{
            titleLabel.text = titleForNormal
        }
    }
    var titleForDisable = "%ds"
    
    var backgroundColorForNormal = UIColor.green{
        didSet{
            self.backgroundColor = backgroundColorForNormal
        }
    }
    var backgroundColorForDisable = UIColor.darkGray
    
    var titleColorForNormal = UIColor.white {
        didSet{
            if timer == nil {
                titleLabel.textColor = titleColorForNormal
            }
        }
    }
    var titleColorForDisable = UIColor.white
    
    
    var onClickHandle = {
        (button: QSTimerButton) -> Void in
        
        return
    }
    
    var time = 60
    // 计时临时变量
    fileprivate var t = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    @objc fileprivate func onTap(){
        if time > 0 && t == 0 {
            titleLabel.textColor = titleColorForDisable
            titleLabel.text = NSString(format: titleForDisable as NSString, time) as String
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(QSTimerButton.updateTitle), userInfo: nil, repeats: true)
            t = time
            self.backgroundColor = backgroundColorForDisable
            
            onClickHandle(self)
        }
    }
    
    @objc fileprivate func updateTitle(){
        
        t -= 1
        titleLabel.text = NSString(format: titleForDisable as NSString, t) as String
        if t == 0 {
            timer.invalidate()
            timer = nil
            reset()
        }
    }
    
    fileprivate func reset(){
        self.titleLabel.text = titleForNormal
        self.backgroundColor = backgroundColorForNormal
        self.titleLabel.textColor = titleColorForNormal
    }
    
    fileprivate func setup(){
        
        self.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(QSTimerButton.onTap))
        self.addGestureRecognizer(tap)
        
        titleLabel.textColor = titleColorForNormal
        self.titleLabel.text = titleForNormal
        titleLabel.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = self.bounds
    }
    
    deinit {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }

}
