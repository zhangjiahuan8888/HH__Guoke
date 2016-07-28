//
//  FCXRefreshFooterView.m
//  RefreshPrj
//
//  Created by fcx on 15/8/21.
//  Copyright (c) 2015年 fcx. All rights reserved.
//

#import "FCXRefreshFooterView.h"

@implementation FCXRefreshFooterView

@synthesize refreshState = _refreshState;

+ (instancetype)footerWithRefreshHandler:(FCXRefreshedHandler)refreshHandler {

    FCXRefreshFooterView *footer = [[FCXRefreshFooterView alloc] init];
    footer.refreshHandler = refreshHandler;
    return footer;
}

- (void)setStateText {
    self.normalStateText = @"上拉加载更多";
    self.pullingStateText = @"松开可加载更多";
    self.loadingStateText = @"正在加载更多...";
    self.noMoreDataStateText = @"没有更多数据";
}

- (void)addRefreshContentView {
    
    [super addRefreshContentView];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    //刷新状态
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.frame = CGRectMake(0, 0, screenWidth, FCXLoadingOffsetHeight);
    _statusLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    _statusLabel.textColor = FCXREFRESHTEXTCOLOR;
    _statusLabel.backgroundColor = [UIColor clearColor];
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_statusLabel];
    
    //箭头图片
    _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueArrow"]];
    _arrowImage.frame = CGRectMake(screenWidth/2.0 - 100, 12.5, 15, 40);
    [self addSubview:_arrowImage];
    
    //转圈动画
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.frame = _arrowImage.frame;
    [self addSubview:_activityView];

}

- (void)setAutoLoadMore:(BOOL)autoLoadMore {
    
    _autoLoadMore = autoLoadMore;
    if (_autoLoadMore) {//自动加载更多不显示箭头
        [_arrowImage removeFromSuperview];
        _arrowImage = nil;
        self.normalStateText = @"正在加载更多...";
        self.pullingStateText = @"正在加载更多...";
        self.loadingStateText = @"正在加载更多...";
    }
}

- (void)scrollViewContentSizeDidChange {
    
    CGRect frame = self.frame;
    frame.origin.y =  MAX(self.scrollView.frame.size.height, self.scrollView.contentSize.height);
    self.frame = frame;
}


- (void)scrollViewContentOffsetDidChange {

    if (self.refreshState == FCXRefreshStateNoMoreData) {//没有更多数据
        return;
    }
    
    if (self.autoLoadMore) {//如果是自动加载更多
        if ([self exceedScrollviewContentSizeHeight] > 1) {//大于偏移量1，转为加载更多loading
            self.refreshState = FCXRefreshStateLoading;
        }
        return;
    }
    
    if (self.scrollView.isDragging) {

        if ([self exceedScrollviewContentSizeHeight] > FCXLoadingOffsetHeight) {//大于偏移量，转为pulling
            self.refreshState = FCXRefreshStatePulling;
        }else {//小于偏移量，转为正常normal
            self.refreshState = FCXRefreshStateNormal;
        }
        
    } else {
    
        if (self.refreshState == FCXRefreshStatePulling) {//如果是pulling状态，改为加载更多loading
            
            self.refreshState = FCXRefreshStateLoading;
            
        }else if ([self exceedScrollviewContentSizeHeight] < FCXLoadingOffsetHeight) {//如果小于偏移量，转为正常normal
            
            self.refreshState = FCXRefreshStateNormal;
        }

    }
}

//超过scrollview的contentSize高度
- (CGFloat)exceedScrollviewContentSizeHeight {
    
    //获取scrollview实际显示内容高度
    CGFloat actualShowHeight = self.scrollView.frame.size.height - _originalEdgeInset.bottom - _originalEdgeInset.top;
    return self.scrollView.contentOffset.y - (self.scrollView.contentSize.height - actualShowHeight);
}

- (void)setRefreshState:(FCXRefreshState)refreshState {
    
    FCXRefreshState lastRefreshState = _refreshState;

    if (_refreshState != refreshState) {
        _refreshState = refreshState;
        
        __weak __typeof(self)weakSelf = self;
        
        switch (refreshState) {
            case FCXRefreshStateNormal:
            {                
                _statusLabel.text = self.normalStateText;
                if (lastRefreshState == FCXRefreshStateLoading) {//之前是刷新过
                    _arrowImage.hidden = YES;
                } else {
                    _arrowImage.hidden = NO;
                }
                _arrowImage.hidden = NO;

                [_activityView stopAnimating];
                
                [UIView animateWithDuration:0.2 animations:^{
                    _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                    weakSelf.scrollView.contentInset = _originalEdgeInset;
                }];
                
                
            }
                break;
                
            case FCXRefreshStatePulling:
            {
                _statusLabel.text = self.pullingStateText;
                
                [UIView animateWithDuration:0.2 animations:^{
                    _arrowImage.transform = CGAffineTransformIdentity;
                }];
                
            }
                break;
            case FCXRefreshStateLoading:
            {
                _statusLabel.text = self.loadingStateText;
                [_activityView startAnimating];
                _arrowImage.hidden = YES;
                _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);

                [UIView animateWithDuration:0.2 animations:^{

                    UIEdgeInsets inset = weakSelf.scrollView.contentInset;
                    inset.bottom += FCXLoadingOffsetHeight;
                    weakSelf.scrollView.contentInset = inset;
                    inset.bottom = self.frame.origin.y - weakSelf.scrollView.contentSize.height + FCXLoadingOffsetHeight;
                    weakSelf.scrollView.contentInset = inset;
                    
                }];
                
                if (self.refreshHandler) {
                    self.refreshHandler(self);
                }

            }
                break;
            case FCXRefreshStateNoMoreData:
            {
                _statusLabel.text = self.noMoreDataStateText;
            }
                break;
        }
    }
}

- (void)endRefresh {
    [self scrollViewContentSizeDidChange];
    [super endRefresh];
}

- (void)showNoMoreData {
    self.refreshState = FCXRefreshStateNoMoreData;
}

- (void)resetNoMoreData {
    self.refreshState = FCXRefreshStateNormal;
}

@end
