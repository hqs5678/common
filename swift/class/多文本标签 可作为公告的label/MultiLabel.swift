//
//  AnnouncementLabel.swift
//  swift pro
//
//  Created by 火星人 on 16/8/13.
//  Copyright © 2016年 火星人. All rights reserved.
//  公共
//  显示滚动的  多文本标签

import UIKit

class MultiLabel: UIView {
    
    // MARK: 内容
    var textArray: NSArray! {
        didSet{
            guard textArray != nil else {
                return
            }
            
            startTimer()
        }
    }
    
    // MARK: 值改变闭包
    var didValueChanged = {
        (text: String, index: Int) -> Void in
        
        return
    }
    // MARK: 点击事件 闭包
    var onClickHandle = {
        (text: String) -> Void in
        
        return
    }
    
    // MARK:当前index
    var currentIndex = 0

    // 滚动时间间隔
    var timeInterval: NSTimeInterval = 3 {
        didSet{
            startTimer()
        }
    }
    
    private var timer: NSTimer!

    // 当前正在显示的字符串
    var text: String!
    
    var font = UIFont.systemFontOfSize(14) {
        didSet{
            textLabel1.font = font
            textLabel2.font = font
        }
    }
    var textColor = UIColor.blackColor() {
        didSet{
            textLabel1.textColor = textColor
            textLabel2.textColor = textColor
        }
    }
    
    var highlightedTextColor = UIColor.grayColor()
    
    var textAlignment: NSTextAlignment = NSTextAlignment.Left {
        didSet{
            textLabel1.textAlignment = textAlignment
            textLabel2.textAlignment = textAlignment
        }
    }
    var lineBreakMode: NSLineBreakMode = NSLineBreakMode.ByWordWrapping
    
    var attributedText: NSAttributedString? {
        didSet{
            guard attributedText != nil else {
                return
            }
            
            self.textLabel1.attributedText = attributedText
            self.textLabel2.attributedText = attributedText
        }
    }
    
    private let textLabel1 = UILabel()
    private let textLabel2 = UILabel()
    
    private var hiddenLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup(){
        
        self.addSubview(textLabel1)
        self.addSubview(textLabel2) 
          
        self.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MultiLabel.onTap))
        self.addGestureRecognizer(tap)
    }
    
    // MARK: 点击事件
    @objc private func onTap(){
        self.onClickHandle(text)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = self.bounds
        textLabel1.frame = frame
        
        frame.origin.y = frame.size.height
        textLabel2.frame = frame
       
    }

    // MARK: 计时任务
    @objc private func timerAction(timer: NSTimer){
        
        UIView.animateWithDuration(1, animations: {
            [weak self] in
            self?.setupFrame()
            
            }) { (complete) in
                self.text = self.textArray[self.currentIndex] as! String
                self.didValueChanged(self.text, self.currentIndex)
                
                self.currentIndex = (self.currentIndex + 1) % self.textArray.count
                
                var frame = self.bounds
                frame.origin.y = frame.size.height
                self.hiddenLabel.frame = frame
                
                self.hiddenLabel.text = self.textArray[self.currentIndex] as? String
        }
    }
    
    // MARK: 修改Frame
    private func setupFrame(){
        var frame = self.textLabel1.frame
        frame.origin.y -= frame.size.height
        self.textLabel1.frame = frame
        
        frame = self.textLabel2.frame
        frame.origin.y -= frame.size.height
        self.textLabel2.frame = frame
        
        if frame.origin.y == 0 {
            self.hiddenLabel = textLabel1
        }
        else {
            self.hiddenLabel = textLabel2
        }
    }
    
    // MARK: 开始计时
    private func startTimer(){
        if textArray.count == 0 {
            return
        }
        self.text = textArray.firstObject as! String
        if textArray.count == 1 {
            textLabel1.text = textArray.firstObject as? String
        }
        else {
            textLabel1.text = textArray[currentIndex] as? String
            
            let index = (currentIndex + 1) % textArray.count
            textLabel2.text = textArray[index] as? String
            self.hiddenLabel = textLabel2
            
            self.currentIndex = 1
            
            if timer != nil {
                timer.invalidate()
                timer = nil
            }
            
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(MultiLabel.timerAction(_:)), userInfo: nil, repeats: true)
        }
    }
    
    // MARK: 开始动画
    func start(){
        startTimer()
    }
    
    // MARK: 结束动画
    func stop(){
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    // 销毁计时器
    deinit{
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        textLabel1.textColor = highlightedTextColor
        textLabel2.textColor = highlightedTextColor
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        textLabel1.textColor = textColor
        textLabel2.textColor = textColor
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        
        textLabel1.textColor = textColor
        textLabel2.textColor = textColor
    }

}
