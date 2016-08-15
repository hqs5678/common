//
//  ViewController.swift
//  WaterfallFlowLayout
//
//  Created by Eric Cerney on 7/21/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, CollectionViewWaterfallLayoutDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    lazy var cellSizes: [CGSize] = {
        var _cellSizes = [CGSize]()
        
        for _ in 0...100 {
            let random = Int(arc4random_uniform((UInt32(100))))
//            _cellSizes.append(CGSize(width: 120, height: 120))
            _cellSizes.append(CGSize(width: 120, height: 50 + random))
        }
        
        return _cellSizes
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let layout = CollectionViewWaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.headerInset = UIEdgeInsetsMake(20, 0, 0, 0)
        layout.headerHeight = 50
        layout.footerHeight = 20
        layout.columnCount = 3
        layout.minimumColumnSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        collectionView.collectionViewLayout = layout
        collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.registerClass(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionFooter, withReuseIdentifier: "Footer")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellSizes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.whiteColor()
        if let label = cell.contentView.viewWithTag(1) as? UILabel {
            label.text = String(indexPath.row)
        }
        
        let selectedView = UIView(frame: CGRectMake(0, 0, 10, 10))
        selectedView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableView: UICollectionReusableView? = nil
        
        if kind == CollectionViewWaterfallElementKindSectionHeader {
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath)
            
            if let view = reusableView {
                view.backgroundColor = UIColor.redColor()
            }
        }
        else if kind == CollectionViewWaterfallElementKindSectionFooter {
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Footer", forIndexPath: indexPath)
            if let view = reusableView {
                view.backgroundColor = UIColor.blueColor()
            }
        }
        
        return reusableView!
    }
    
    // MARK: WaterfallLayoutDelegate
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return cellSizes[indexPath.item]
    }
}

