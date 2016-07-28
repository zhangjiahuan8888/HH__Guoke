//
//  UIScrollView+FCXRefresh.h
//  RefreshDemo
//
//  Created by fcx on 15/8/25.
//  Copyright (c) 2015年 fcx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCXRefreshBaseView.h"

@class FCXRefreshHeaderView;
@class FCXRefreshFooterView;

@interface UIScrollView (FCXRefresh)

- (FCXRefreshHeaderView *)addHeaderWithRefreshHandler:(FCXRefreshedHandler)refreshHandler;
- (FCXRefreshFooterView *)addFooterWithRefreshHandler:(FCXRefreshedHandler)refreshHandler;

@end
