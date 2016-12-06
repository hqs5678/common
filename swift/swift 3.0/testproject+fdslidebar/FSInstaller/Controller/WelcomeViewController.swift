//
//  WelcomeViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/8/3.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

class WelcomeViewController: BaseViewController {

    @IBOutlet weak var startButton: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    fileprivate var carouselView: CarouselView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let models = NSMutableArray()
        for i in 1...3 {
            let mo = CarouselCollectionViewCellModel()
            mo.imageName = "guide\(i)"
            models.add(mo)
        }
        
        startButton.image = UIImage(named: "click-to-enter") 
        
        self.bgView.addTapWithHandle { [weak self] (tap)  in
            
            self?.startAction()
        }
        
        self.carouselView = CarouselView.viewFromNib()
        self.carouselView.repeatAble = false
        self.carouselView.collectionView.bounces = false
        self.carouselView.frame = self.view.frame
        self.carouselView.models = models
        self.carouselView.collectionView.backgroundColor = UIColor(hexString: "413932")
        self.view.insertSubview(carouselView, at: 0)
        
        self.carouselView.didPageValueChanged = {
            [weak self]
            (index: Int) -> Void in
            if index == 2 {
                if self?.bgView.alpha == 0 {
                    UIView.animate(withDuration: 0.4, animations: {
                        self!.bgView.alpha = 1
                    })
                }
            }
            else{
                UIView.animate(withDuration: 0.4, animations: {
                    self?.bgView.alpha = 0
                })
            }
            return
        }
        
        self.bgView.alpha = 0
        
        self.bgView.cornerRadius = kCornerRadius
        self.bgView.backgroundColor = kAppMainColor
    }
  
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
     
    fileprivate func startAction() {
        
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        let window = appDelegate.window
        var mainVC = appDelegate.mainVC
        if mainVC == nil {
            mainVC = ControllerHelper.controllerFromStoryBoardWithIdentifier("BaseTabBarController")
        }
        
        UIView.transition(from: self.view, to: mainVC!.view, duration: 0.4, options: .transitionCurlUp) { (complete) in
            window?.rootViewController = mainVC
            window?.makeKeyAndVisible()
        }
        
    }
}
