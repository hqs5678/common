//
//  TaskProgressCell.swift
//  FSInstaller
//
//  Created by Apple on 16/8/5.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


enum TaskProgressCellPosition {
    case top;
    case middle;
    case bottom;
}

class TaskProgressCell: UITableViewCell {
    
    var position = TaskProgressCellPosition.top
    
    var taskStatusModel: TaskStatusModel! {
        didSet{
            textLabel?.text = taskStatusModel.stauts
            detailTextLabel?.text = taskStatusModel.datetime
            
            if taskStatusModel.stauts.length() == 0 {
                circleLayer.hidden = true
            }
            else {
                circleLayer.hidden = false
            }
        }
    }
    
    
    private let circleLayer = CALayer()
    private let lineLayer = CALayer()
    
    var progressTintColor = UIColor.RGB(26, g: 185, b: 99) {
        didSet{
            circleLayer.backgroundColor = progressTintColor.CGColor
            lineLayer.backgroundColor = progressTintColor.CGColor
        }
    }
    var titleColor = UIColor.darkGrayColor() {
        didSet {
            textLabel?.textColor = titleColor
            detailTextLabel?.textColor = titleColor
        }
    }
    
    private let circleRadius: CGFloat = 6
    private let lineWidth: CGFloat = 2
    
    private let marginLeft: CGFloat = 30
    private let textMarginLeft: CGFloat = 10
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func setup(){
        
        textLabel?.font = UIFont.systemFontOfSize(14)
        textLabel?.textColor = titleColor
        
        detailTextLabel?.font = UIFont.systemFontOfSize(10)
        detailTextLabel?.textColor = titleColor
        
        circleLayer.frame = CGRectMake(0, 0, circleRadius * 2, circleRadius * 2)
        circleLayer.cornerRadius = circleRadius
        circleLayer.borderWidth = 0
        circleLayer.backgroundColor = progressTintColor.CGColor
        
        lineLayer.frame = CGRectMake(0, 0, lineWidth, 0)
        lineLayer.backgroundColor = progressTintColor.CGColor
        
        self.contentView.layer.addSublayer(circleLayer)
        self.contentView.layer.addSublayer(lineLayer)
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = circleLayer.frame
        frame.origin.y = (self.frame.size.height - frame.size.height) * 0.5
        frame.origin.x = marginLeft
        circleLayer.frame = frame
        
        switch position {
        case .top:
            iconTop()
            break
        case .middle:
            iconMiddle()
            break
        case .bottom:
            iconBottom()
            break
        }
        
        textLabel?.originX = marginLeft + circleRadius * 2 + textMarginLeft
        detailTextLabel?.originX = detailTextLabel!.originX - textMarginLeft
    }
    
    private func iconTop(){
        
        var frame = lineLayer.frame
        frame.origin.x = circleLayer.frame.origin.x + circleRadius - lineWidth * 0.5
        frame.origin.y = self.contentView.frame.height * 0.5
        frame.size.height = frame.origin.y
        lineLayer.frame = frame
    }
    
    private func iconBottom(){
        var frame = lineLayer.frame
        frame.origin.x = circleLayer.frame.origin.x + circleRadius - lineWidth * 0.5
        frame.origin.y = 0
        frame.size.height = self.contentView.frame.height * 0.5
        lineLayer.frame = frame
    }
    
    private func iconMiddle(){
        
        var frame = lineLayer.frame
        frame.origin.x = circleLayer.frame.origin.x + circleRadius - lineWidth * 0.5
        frame.origin.y = 0
        frame.size.height = self.frame.size.height
        lineLayer.frame = frame
    }
}
