//
//  MJNewsCell.m
//  预习-03-无限滚动
//
//  Created by MJ Lee on 14-5-30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJNewsCell.h"
#import "MJNews.h"

@interface MJNewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation MJNewsCell


- (void)setNews:(MJNews *)news
{
    _news = news;
    
    self.iconView.image = [UIImage imageNamed:news.icon];
    self.titleLabel.text = [NSString stringWithFormat:@"  %@", news.title];
}

@end
