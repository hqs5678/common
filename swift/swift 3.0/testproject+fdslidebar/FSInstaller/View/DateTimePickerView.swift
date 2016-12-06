//
//  DateTimePickerView.swift
//  selectdate
//
//  Created by Apple on 16/9/7.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class DateTimePickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate {
    
    var didSelectDatetimeHandle = {
        (year: Int, mon: Int, day: Int, hour: Int, minute: Int) -> Void in return
    }
    
    // 出于外观考虑 使用5个picker view
    fileprivate let pickerYear = UIPickerView()
    fileprivate let pickerMonth = UIPickerView()
    fileprivate let pickerDay = UIPickerView()
    fileprivate let pickerHour = UIPickerView()
    fileprivate let pickerMinute = UIPickerView()
    
    // 数据源
    fileprivate let years = NSMutableArray()
    fileprivate let mons = NSMutableArray()
    fileprivate let days = NSMutableArray()
    fileprivate let hours = NSMutableArray()
    fileprivate let minutes = NSMutableArray()
    
    // 当前选中的值
    fileprivate var year: Int = 0
    fileprivate var month: Int = 1
    fileprivate var day: Int = 0
    fileprivate var hour: Int = 0
    fileprivate var minute: Int = 0
    
    fileprivate var firstLayout = 0
    fileprivate var pCount = 3
    
    // 字体颜色
    var titleColor = UIColor.darkGray
    var titleSelectedColor = UIColor.blue
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup(){
        addPicker(pickerYear)
        addPicker(pickerMonth)
        addPicker(pickerDay)
        addPicker(pickerHour)
        addPicker(pickerMinute)
        
        initData()
          
        let date = Date()
        setDatetime(date.year, mon: 1, day: 1, hour: 0, minute: 0)
    }
    
    fileprivate func setDefaultDatetime(_ year: Int, mon: Int, day: Int, hour: Int, minute: Int, animate: Bool){
        
        let date = Date()
        var y = 0
        if year > date.year {
            y = 1
        }
        pickerYear.selectRow(y, inComponent: 0, animated: animate)
        pickerMonth.selectRow(mon - 1, inComponent: 0, animated: animate)
        pickerDay.selectRow(day - 1, inComponent: 0, animated: animate)
        pickerHour.selectRow(hour, inComponent: 0, animated: animate)
        pickerMinute.selectRow(minute, inComponent: 0, animated: animate)
        
        didSelectDatetimeHandle(year, month, day, hour, minute)
    }
    
    fileprivate func setDefaultDatetime(_ year: Int, mon: Int, day: Int, hour: Int, minute: Int){
        setDefaultDatetime(year, mon: mon, day: day, hour: hour, minute: minute, animate: false)
    }
    
    func setDatetime(_ year: Int, mon: Int, day: Int, hour: Int, minute: Int){
        setDatetime(year, mon: mon, day: day, hour: hour, minute: minute, animate: false)
    }
    
    func setDatetime(_ year: Int, mon: Int, day: Int, hour: Int, minute: Int, animate: Bool){
        
        self.year = year
        self.month = mon
        self.day = day
        self.hour = hour
        self.minute = minute
        
        doInAfter(200) {
            [weak self] in
            if animate {
                self?.pCount = 1
                self?.resetPCountAfter1SEC()
            }
            self?.setDefaultDatetime(year, mon: mon, day: day, hour: hour, minute: minute, animate: animate)
        }
    }
    
    
    
    fileprivate func initData(){
        for i in 1 ... 12 {
            mons.add("\(i)月")
        }
        
        for i in 1 ... 31 {
            days.add("\(i)日")
        }
        
        for i in 0 ... 23 {
            hours.add("\(i)时")
        }
        
        for i in 0 ... 59 {
            minutes.add("\(i)分")
        }
        
        let date = Date()
        let year: Int = date.year
        years.add("\(year)年")
        years.add("\(year + 1)年")
        
    }
    
    fileprivate func addPicker(_ picker: UIPickerView){
        self.addSubview(picker)
        picker.dataSource = self
        picker.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = CGRect(x: 0, y: 0, width: self.frame.size.width / 5, height: self.frame.size.height)
        pickerYear.frame = frame
        
        frame.origin.x = frame.size.width
        pickerMonth.frame = frame
        
        frame.origin.x += frame.size.width
        pickerDay.frame = frame
        
        frame.origin.x += frame.size.width
        pickerHour.frame = frame
        
        frame.origin.x += frame.size.width
        pickerMinute.frame = frame
        
    }
    
    // 设置中间部分标题的颜色
    fileprivate func setMiddleLabelColor(){
        
        setMiddleColorForPickerView(pickerYear)
        setMiddleColorForPickerView(pickerMonth)
        setMiddleColorForPickerView(pickerDay)
        setMiddleColorForPickerView(pickerHour)
        setMiddleColorForPickerView(pickerMinute)
        
        // 添加 监听器,   遍历pickerview中的子控件, 找到中间的标题控件时 设置他的字体颜色
        for v in tablesNew {
            let view = v as! UIScrollView
            view.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
            
            travesalView222222(view)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 设置中间部分标题的颜色
        setMiddleLabelColor()
    }
    
    fileprivate func setMiddleColorForPickerView(_ picker: UIPickerView){
        tables.removeAllObjects()
        travesalView(picker)
        tablesNew.add(tables[2])
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let newValue = change![.newKey]   // 这个是nspoint 目前版本无法直接转换  以后版本注意更新
        
        // 需要实时设置标题颜色   不然会被系统的颜色覆盖
        if newValue != nil {
            let str = "\(newValue)" as NSString
            let d = str.range(of: ",").location
            let e = str.range(of: "}").location
            let value = str.substring(with: NSRange(location: d + 2, length: e - d - 2))
            let y = Int((value as NSString).intValue)
            if y % pCount == 0 {
                //appPrint(pCount)
                travesalView222222(object as! UIView)
            }
        }
        
    }
    
    // 找到pickerview中的关键控件 保持到这里
    fileprivate var tables = NSMutableArray()
    fileprivate var tablesNew = NSMutableArray()
    
    // 第一层遍历  遍历picker view
    fileprivate func travesalView(_ view: UIView){
        let vs = view.subviews
        //appPrint(view.classForCoder)
        for v in vs {
            if "\(v.classForCoder)".contains("UIPickerTableView") {
                tables.add(v)
            }
            else{
                travesalView(v)
            }
        }
    }
    
    // 第二层遍历 找到titleLabel 设置颜色
    fileprivate func travesalView222222(_ view: UIView){
        let vs = view.subviews
        for v in vs {
            
            if v is UILabel {
                let label = v as! UILabel
                label.textColor = titleSelectedColor
            }
            else{
                travesalView222222(v)
            }
        }
    }
    
    // 返回picker view 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 返回行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case pickerYear:
            return years.count
        case pickerMonth:
            return mons.count
        case pickerDay:
            return Date.dateSizeOfMonth(month, year: year)
        case pickerHour:
            return hours.count
        case pickerMinute:
            return minutes.count
        default:
            return 0
        }
    }
    
    // title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case pickerYear:
            return years[row] as? String
        case pickerMonth:
            return mons[row] as? String
        case pickerDay:
            return days[row] as? String
        case pickerHour:
            return hours[row] as? String
        case pickerMinute:
            return minutes[row] as? String
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var titleView = view as? UILabel
        if titleView == nil {
            titleView = UILabel()
            titleView?.font = UIFont.systemFont(ofSize: kFontSizeSmall)
            titleView?.textAlignment = .center
            titleView?.textColor = titleColor
        }
        titleView?.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        
        return titleView!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        resetValues()
        
        // 协调 年月 对 日 的数量关系
        var seleRow = pickerDay.selectedRow(inComponent: 0)
        let count = Date.dateSizeOfMonth(month, year: year)
        
        switch pickerView {
        case pickerYear, pickerMonth:
            
            
            if seleRow > count - 1 {
                
                pickerDay.reloadComponent(0)
                seleRow = count - 1
                pickerDay.selectRow(seleRow, inComponent: 0, animated: false)
            }
            else {
                
                if pickerDay.numberOfRows(inComponent: 0) != count && seleRow > 15 {
                    
                    pickerDay.reloadComponent(0)
                    pickerDay.selectRow(seleRow, inComponent: 0, animated: false)
//                    doInAfter(50, {
//                        [weak self] in
//                        self?.pickerDay.selectRow(seleRow, inComponent: 0, animated: false)
//                        })
                }
            }
            
        case pickerDay:
            if count != pickerDay.numberOfRows(inComponent: 0) {
                if seleRow == pickerDay.numberOfRows(inComponent: 0) - 1 {
                    pickerDay.reloadComponent(0)
                    
                    seleRow = count - 1
                    pickerDay.selectRow(seleRow - 1, inComponent: 0, animated: false)
                    doInAfter(50, {
                        [weak self] in
                        self?.pickerDay.selectRow(seleRow, inComponent: 0, animated: false)
                    })
                }
                else{
                    if seleRow > 25 {
                        pickerDay.reloadComponent(0)
                        
                        pickerDay.selectRow(seleRow + 1, inComponent: 0, animated: true)
                    }
                }
            }
        default:
            break
        } 
        
        didSelectDatetimeHandle(year, month, day, hour, minute)
    }
    
    fileprivate func resetValues(){
        let y = Date().year
        year = y + pickerYear.selectedRow(inComponent: 0)
        
        month = pickerMonth.selectedRow(inComponent: 0) + 1
        day = pickerDay.selectedRow(inComponent: 0) + 1
        hour = pickerHour.selectedRow(inComponent: 0)
        minute = pickerMinute.selectedRow(inComponent: 0)
    }
    
    fileprivate func resetPCountAfter1SEC(){
        doInAfter(1000) { 
            [weak self] in
            self?.pCount = 3
        }
    }
    
    fileprivate func doInAfter(_ millisecond: UInt64, _ block: @escaping ()->()){
          
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(millisecond * NSEC_PER_MSEC)) / Double(NSEC_PER_SEC), execute: block)
    }
    
    
    deinit{
        // 移除监听
        for v in tablesNew {
            let view = v as? UIScrollView
            if view != nil {
                view?.removeObserver(self, forKeyPath: "contentOffset", context: nil)
            }
        }
    }

}


