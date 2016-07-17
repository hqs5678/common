# 简单使用


    MJNewsView *newsView = [MJNewsView newsView];
    newsView.x = 10;
    newsView.y = 40;
    newsView.timeInterval = 10;
    newsView.news = self.newses;

    [newsView setDidClickNewsAtIndex:^(int index) {
        NSLog(@"%d",index);
    }];

    [self.view addSubview:newsView];

    [newsView startTimer];
