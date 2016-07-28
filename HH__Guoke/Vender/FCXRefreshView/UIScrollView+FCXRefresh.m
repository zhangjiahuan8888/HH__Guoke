//
//  UIScrollView+FCXRefresh.m
//  RefreshDemo
//
//  Created by fcx on 15/8/25.
//  Copyright (c) 2015年 fcx. All rights reserved.
//

#import "UIScrollView+FCXRefresh.h"
#import "FCXRefreshHeaderView.h"
#import "FCXRefreshFooterView.h"

@implementation UIScrollView (FCXRefresh)

- (FCXRefreshHeaderView *)addHeaderWithRefreshHandler:(FCXRefreshedHandler)refreshHandler {
    
    FCXRefreshHeaderView *header = [FCXRefreshHeaderView headerWithRefreshHandler:refreshHandler];
    header.scrollView = self;
    return header;
    
}

- (FCXRefreshFooterView *)addFooterWithRefreshHandler:(FCXRefreshedHandler)refreshHandler {

    FCXRefreshFooterView *footer = [FCXRefreshFooterView footerWithRefreshHandler:refreshHandler];
    footer.scrollView = self;
    return footer;
}

@end
