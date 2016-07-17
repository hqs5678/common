//
//  MJNewsView.m
//  预习-03-无限滚动
//
//  Created by MJ Lee on 14-5-30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 每一组最大的行数
#define MJNewsTotalRowsInSection (5000 * self.news.count)
#define MJNewsDefaultRow (NSUInteger)(MJNewsTotalRowsInSection * 0.5)

#import "MJNewsView.h"
#import "MJNewsCell.h"

@interface MJNewsView()  <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL autoScorll;

@end

@implementation MJNewsView
+ (instancetype)newsView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MJNewsView" owner:nil options:nil] lastObject];
}



- (NSTimeInterval)timeInterval{
    if(_timeInterval < 1){
        _timeInterval = 2;
    }
    return _timeInterval;
}

- (void)startTimer{
    [self addTimer];
    self.autoScorll = YES;
}

- (void)stopTimer{
    [self removeTimer];
    self.autoScorll = NO;
}



- (void)awakeFromNib
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"MJNewsCell" bundle:nil] forCellWithReuseIdentifier:@"news"];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)addTimer
{
    if(self.timer){
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextNews) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextNews
{
    NSIndexPath *visiablePath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    
    NSUInteger visiableItem = visiablePath.item;
    if ((visiablePath.item % self.news.count)  == 0) { // 第0张图片
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:MJNewsDefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        visiableItem = MJNewsDefaultRow;
    }
    
    NSUInteger nextItem = visiableItem + 1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)setNews:(NSArray *)news
{
    _news = news;
    
    // 总页数
    self.pageControl.numberOfPages = self.news.count;
    // 刷新数据
    [self.collectionView reloadData];
    // 默认组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:MJNewsDefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MJNewsTotalRowsInSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"news";
    MJNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.news = self.news[indexPath.item % self.news.count];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *visiablePath = [[collectionView indexPathsForVisibleItems] firstObject];
    self.pageControl.currentPage = visiablePath.item % self.news.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.didClickNewsAtIndex){
        self.didClickNewsAtIndex(indexPath.row % self.news.count);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScorll){
        [self removeTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(self.autoScorll){
        [self addTimer];
    }
}

@end
