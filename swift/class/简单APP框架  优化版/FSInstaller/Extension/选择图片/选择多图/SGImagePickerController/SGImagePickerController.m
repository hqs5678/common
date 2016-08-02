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
@end

@implementation SGImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
   
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

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:self.titleColor forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
