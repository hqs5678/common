//
//  CarouselView.swift
//  轮播图
//
//  Created by 火星人 on 16/7/18.
//  Copyright © 2016年 火星人. All rights reserved.
//

import UIKit

let kNumberOfItemCarouselView = 5

class CarouselView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControll: UIPageControl!
    
    var repeatAble = true
    
    fileprivate var timer: Timer!
    var timeInterval: TimeInterval = 1
    
    var isAutoPlay: Bool = false {
        didSet{
            self.updateAutoDisplay()
        }
    }
    
    fileprivate var preIsAutoPlay: Bool!
    
    var didClickItemAt = {
        (index: Int) -> Void in
        return
    }
    
    var didPageValueChanged = {
        (index: Int) -> Void in
        return
    }
    
    
    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    
    class func  viewFromNib() -> CarouselView {
        return Bundle.main.loadNibNamed("CarouselView", owner: nil, options: nil)!.first as! CarouselView
    }
    
    
    fileprivate func setup(){
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let nib = UINib(nibName: "CarouselCollectionViewCell", bundle: Bundle.main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        self.isUserInteractionEnabled = true
        self.collectionView.backgroundColor = UIColor.white
        self.pageControll.isUserInteractionEnabled = false 
    }
    
    var models: NSArray! {
        didSet{
            self.pageControll.numberOfPages = self.models.count
            self.pageControll.currentPage = 0
            
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if repeatAble {
            let offset = CGPoint(x: self.frame.size.width * CGFloat(kNumberOfItemCarouselView / 2 * self.models.count), y: 0)
            self.collectionView.setContentOffset(offset , animated: false)
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if repeatAble {
            return self.models.count * kNumberOfItemCarouselView
        }
        else{
            return self.models.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarouselCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
         
        let mo = models[indexPath.row % self.models.count] as! CarouselCollectionViewCellModel
        cell.model = mo
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: IndexPath!) -> CGSize{
        
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didClickItemAt(indexPath.row % self.models.count)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControll.currentPage = Int(self.collectionView.contentOffset.x / self.frame.size.width) % self.models.count
        
        if repeatAble {
            // 避免到头 手动调整  实现无限循环效果
            if self.collectionView.contentOffset.x > CGFloat(self.models.count * (kNumberOfItemCarouselView - 1)) * self.frame.size.width
                || self.collectionView.contentOffset.x < CGFloat(self.models.count) * self.frame.size.width {
                
                let offset1 = CGPoint(x: self.frame.size.width * CGFloat(self.models.count + self.pageControll.currentPage), y: 0)
                self.collectionView.setContentOffset(offset1 , animated: false)
                //            appPrint("-----shoudong调整------")
            }
        }
         
        
        self.didPageValueChanged(pageControll.currentPage)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        self.preIsAutoPlay = self.isAutoPlay
        self.isAutoPlay = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isAutoPlay = self.preIsAutoPlay
        self.preIsAutoPlay = nil
    }
    
    fileprivate func updateAutoDisplay(){
        if isAutoPlay{
            if self.timer != nil {
                self.timer.invalidate()
            }
            self.timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(CarouselView.sutoScroll), userInfo: nil, repeats: true)
        }
        else {
            if self.timer != nil {
                self.timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    @objc fileprivate func sutoScroll(){
        // 避免自动播放到头
        if self.collectionView.contentOffset.x > CGFloat(self.models.count * (kNumberOfItemCarouselView - 1)) * self.frame.size.width {
            
            let offset1 = CGPoint(x: self.frame.size.width * CGFloat(self.models.count + self.pageControll.currentPage), y: 0)
            self.collectionView.setContentOffset(offset1 , animated: false)
//            appPrint("-----自动播放调整------")
        }
        
        var offset = self.collectionView.contentOffset
        offset.x += self.frame.size.width
        appPrint(offset.x)
        self.collectionView.setContentOffset(offset, animated: true)
        
        self.pageControll.currentPage = (self.pageControll.currentPage + 1) % self.models.count
    }
    
    
}
