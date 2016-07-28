//
//  Common.h
//  HH__Guoke
//
//  Created by 张家欢 on 16/7/25.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#ifndef Common_h
#define Common_h
//屏幕宽度
#define kSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define kSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

// COLOR

#define MainGreenColor                              [UIColor colorWithHexString:@"#09ae5d"]
#define MainWhiteColor                              [UIColor colorWithHexString:@"#ffffff"]
#define MaindarkColor                               [UIColor colorWithHexString:@"#47515e"]
#define LineGrayColor                               [UIColor colorWithHexString:@"#626b76"]
#define SelectedGrayColorColor                      [UIColor colorWithHexString:@"#39414b"]
#define BackgroundColor                             [UIColor colorWithHexString:@"#f0f0f0"]
#define BorderGrayColor                             [UIColor colorWithHexString:@"#bfbfbf"]
#define PlaceholderGrayColor                        [UIColor colorWithHexString:@"#b3b3b3"]

//通知
#define kOpenSideNotification                       @"openSideNotification"

//URL
#define adUrl                                       @"http://apis.guokr.com/flowingboard/item/handpick_carousel.json"
#define homeUrl                                     @"http://apis.guokr.com/handpick/article.json"
#endif /* Common_h */
