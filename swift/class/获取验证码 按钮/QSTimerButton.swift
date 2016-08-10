//
//  QSTimerButton.swift
//  FSInstaller
//
//  Created by Apple on 16/8/10.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

class QSTimerButton: UIView {
    
    var titleLabel = UILabel()
    
    private var timer: NSTimer!
    
    var titleForNormal = "获取验证码" {
        didSet{
            titleLabel.text = titleForNormal
        }
    }
    var titleForDisable = "%ds"
    
    var backgroundColorForNormal = UIColor.greenColor(){
        didSet{
            self.backgroundColor = backgroundColorForNormal
        }
    }
    var backgroundColorForDisable = UIColor.darkGrayColor()
    
    var titleColorForNormal = UIColor.whiteColor()
    var titleColorForDisable = UIColor.whiteColor()
    
    
    var onClickHandle = {
        (button: QSTimerButton) -> Void in
        
        return
    }
    
    var time = 60
    // 计时临时变量
    private var t = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    @objc private func onTap(){
        if time > 0 && t == 0 {
            titleLabel.textColor = titleColorForDisable
            titleLabel.text = NSString(format: titleForDisable, time) as String
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(QSTimerButton.updateTitle), userInfo: nil, repeats: true)
            t = time
            self.backgroundColor = backgroundColorForDisable
        }
        
        onClickHandle(self)
    }
    
    @objc private func updateTitle(){
        
        t -= 1
        titleLabel.text = NSString(format: titleForDisable, t) as String
        if t == 0 {
            timer.invalidate()
            timer = nil
            reset()
        }
    }
    
    private func reset(){
        self.titleLabel.text = titleForNormal
        self.backgroundColor = backgroundColorForNormal
        self.titleLabel.textColor = titleColorForNormal
    }
    
    private func setup(){
        
        self.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFontOfSize(12)
        
        self.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(QSTimerButton.onTap))
        self.addGestureRecognizer(tap)
        
        titleLabel.textColor = titleColorForNormal
        self.titleLabel.text = titleForNormal
        titleLabel.textAlignment = .Center
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
