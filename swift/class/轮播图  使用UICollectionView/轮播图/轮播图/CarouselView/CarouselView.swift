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
    private var timer: NSTimer!
    var timeInterval: NSTimeInterval = 1
    
    var isAutoPlay: Bool = false {
        didSet{
            self.updateAutoDisplay()
        }
    }
    
    private var preIsAutoPlay: Bool!
    
    var didClickItemAt = {
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
        return NSBundle.mainBundle().loadNibNamed("CarouselView", owner: nil, options: nil).first as! CarouselView
    }
    
    
    private func setup(){
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let nib = UINib(nibName: "CarouselCollectionViewCell", bundle: NSBundle.mainBundle())
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        self.userInteractionEnabled = true
        self.collectionView.backgroundColor = UIColor.whiteColor()
    }
    
    
    var models: NSArray! {
        didSet{
            self.pageControll.numberOfPages = self.models.count
            self.pageControll.currentPage = 0
            
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        let offset = CGPointMake(self.frame.size.width * CGFloat(kNumberOfItemCarouselView / 2 * self.models.count), 0)
        self.collectionView.setContentOffset(offset , animated: false)
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count * kNumberOfItemCarouselView
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CarouselCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CarouselCollectionViewCell", forIndexPath: indexPath) as! CarouselCollectionViewCell
         
        let mo = models[indexPath.row % self.models.count] as! CarouselCollectionViewCellModel
        cell.model = mo
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        
        return self.bounds.size
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.didClickItemAt(indexPath.row % self.models.count)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.pageControll.currentPage = Int(self.collectionView.contentOffset.x / self.frame.size.width) % self.models.count
        // 避免到头 手动调整  实现无限循环效果
        if self.collectionView.contentOffset.x > CGFloat(self.models.count * (kNumberOfItemCarouselView - 1)) * self.frame.size.width
            || self.collectionView.contentOffset.x < CGFloat(self.models.count) * self.frame.size.width {
            
            let offset1 = CGPointMake(self.frame.size.width * CGFloat(self.models.count + self.pageControll.currentPage), 0)
            self.collectionView.setContentOffset(offset1 , animated: false)
//            print("-----shoudong调整------")
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {

        self.preIsAutoPlay = self.isAutoPlay
        self.isAutoPlay = false
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isAutoPlay = self.preIsAutoPlay
        self.preIsAutoPlay = nil
    }
    
    private func updateAutoDisplay(){
        if isAutoPlay{
            if self.timer != nil {
                self.timer.invalidate()
            }
            self.timer = NSTimer.scheduledTimerWithTimeInterval(self.timeInterval, target: self, selector: #selector(CarouselView.sutoScroll), userInfo: nil, repeats: true)
        }
        else {
            if self.timer != nil {
                self.timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    @objc private func sutoScroll(){
        // 避免自动播放到头
        if self.collectionView.contentOffset.x > CGFloat(self.models.count * (kNumberOfItemCarouselView - 1)) * self.frame.size.width {
            
            let offset1 = CGPointMake(self.frame.size.width * CGFloat(self.models.count + self.pageControll.currentPage), 0)
            self.collectionView.setContentOffset(offset1 , animated: false)
//            print("-----自动播放调整------")
        }
        
        var offset = self.collectionView.contentOffset
        offset.x += self.frame.size.width
        print(offset.x)
        self.collectionView.setContentOffset(offset, animated: true)
        
        self.pageControll.currentPage = (self.pageControll.currentPage + 1) % self.models.count
    }
    
    
}
