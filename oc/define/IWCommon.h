

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define IWLog(...) NSLog(__VA_ARGS__)
#else
#define IWLog(...)
#endif

// 4.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)



// 7.常用的对象
#define IWNotificationCenter [NSNotificationCenter defaultCenter]