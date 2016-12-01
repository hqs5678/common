//
//  SGImagesPickerController.m
//  SGImagePickerController
//
//  Created by yyx on 15/9/17.
//  Copyright (c) 2015年 yyx. All rights reserved.
//

#import "SGImagePickerController.h"
#import "SGAssetsGroupController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface SGImagePickerController ()
@property (nonatomic,strong) SGAssetsGroupController *assetsGroupVC;
@property (nonatomic,strong) UIView *separatorOverView;
@end

@implementation SGImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _separatorOverView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationBar.frame.size.height - 1, self.view.frame.size.width, 2)];
    _separatorOverView.backgroundColor = _barTintColor;
    [self.navigationBar addSubview:_separatorOverView];
}

- (instancetype)init{

    if (self = [super initWithRootViewController:self.assetsGroupVC]) { 
        
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    if (self.statusBarStyleLightContent) {
        return UIStatusBarStyleLightContent;
    }
    else{
        return UIStatusBarStyleDefault;
    }
}
 

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    return  [self init];
}
- (SGAssetsGroupController *)assetsGroupVC{
    if (_assetsGroupVC == nil) {
        _assetsGroupVC = [[SGAssetsGroupController alloc] init];
        _assetsGroupVC.navigationItem.title = @"选择相册";
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
        _assetsGroupVC.navigationItem.leftBarButtonItem = cancelItem;
    }
    return _assetsGroupVC;
}

- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:tintColor forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;
    
    self.navigationBar.tintColor = tintColor;
}


- (void)setBarTintColor:(UIColor *)barTintColor{
    _barTintColor = barTintColor;
    
    if (_separatorOverView ) {
        _separatorOverView.backgroundColor = barTintColor;
    }
    
    self.navigationBar.barTintColor = barTintColor;
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    NSLog(@"---- dealloc SGImagePickerController ----");
}

@end
