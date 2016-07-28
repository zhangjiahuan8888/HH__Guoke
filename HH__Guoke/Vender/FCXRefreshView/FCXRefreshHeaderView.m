//
//  FCXRefreshHeaderView.m
//  RefreshPrj
//
//  Created by fcx on 15/8/21.
//  Copyright (c) 2015年 fcx. All rights reserved.
//

#import "FCXRefreshHeaderView.h"
@interface FCXRefreshHeaderView()

@property (nonatomic,strong) UIImageView *lightView;        //灯光束
@property (nonatomic,strong) UIImageView *ufoView;          //ufo视图
@end
@implementation FCXRefreshHeaderView

@synthesize refreshState = _refreshState;

+ (instancetype)headerWithRefreshHandler:(FCXRefreshedHandler)refreshHandler {
    
    FCXRefreshHeaderView *header = [[FCXRefreshHeaderView alloc] init];
    header.refreshHandler = refreshHandler;
    return header;
}

- (void)addRefreshContentView {
    
    [super addRefreshContentView];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.backgroundColor = [UIColor colorWithRed:4/225.f green:124/225.f blue:61/225.f alpha:1];
    
    _ufoView = [[UIImageView alloc] init];
    _ufoView.frame = CGRectMake((screenWidth-30)/2, 0+300, 30, 20);
    _ufoView.image = [UIImage imageNamed:@"refresh_ufo_49x27_@1x"];
    [self addSubview:_ufoView];
    
    _lightView = [[UIImageView alloc] init];;
    _lightView.frame = CGRectMake((screenWidth-80)/2+2, FCXLoadingOffsetHeight - 50+300, 80, 50);
    _lightView.image = [UIImage imageNamed:@"refresh_light_133x93_@1x"];
    [self addSubview:_lightView];

    
    //小牛图片
    _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_cow_side_57x41_@1x"]];
    _arrowImage.frame = CGRectMake((screenWidth-30)/2, FCXLoadingOffsetHeight - 30+300, 30, 30);
    [self addSubview:_arrowImage];

}

- (void)scrollViewContentOffsetDidChange {
    
    if (self.scrollView.isDragging) {//正在拖拽
        if (self.scrollView.contentOffset.y < -FCXLoadingOffsetHeight) {//大于偏移量，转为pulling
            
            self.refreshState = FCXRefreshStatePulling;
            
        }else {//小于偏移量，转为正常normal
            
            self.refreshState = FCXRefreshStateNormal;
        }
        
    } else {
        if (self.refreshState == FCXRefreshStatePulling) {//如果是pulling状态，改为刷新加载loading
            
            self.refreshState = FCXRefreshStateLoading;
            
        }else if (self.scrollView.contentOffset.y > -FCXLoadingOffsetHeight) {//如果小于偏移量，转为正常normal
            
            self.refreshState = FCXRefreshStateNormal;
        }
    }
    
}

- (void)setRefreshState:(FCXRefreshState)refreshState {

    FCXRefreshState lastRefreshState = _refreshState;
    
    if (_refreshState != refreshState) {
        _refreshState = refreshState;
        
        __weak __typeof(self)weakSelf = self;

        switch (refreshState) {
            case FCXRefreshStateNormal:
            {
                
                if (lastRefreshState == FCXRefreshStateLoading) {//之前是在刷新
                    
                }
                
                [_activityView stopAnimating];
                _arrowImage.image = [UIImage imageNamed:@"refresh_cow_side_57x41_@1x"];
                
                
                [UIView animateWithDuration:0.5 animations:^{
                    weakSelf.scrollView.contentInset = _originalEdgeInset;
                } completion:^(BOOL finished) {
                    _arrowImage.frame = CGRectMake((self.bounds.size.width-30)/2+5, FCXLoadingOffsetHeight+300 - 30, 30, 30);
                     _lightView.alpha = 1;
                    _arrowImage.alpha = 1;
                }];
            }
                break;
                
            case FCXRefreshStatePulling:
            {
 
                _arrowImage.image = [UIImage imageNamed:@"refresh_cow_front_57x41_@1x"];
            }
                break;
            case FCXRefreshStateLoading:
            {


                _arrowImage.image = [UIImage imageNamed:@"refresh_cow_front_57x41_@1x"];
                [UIView animateWithDuration:0.5 animations:^{

                    UIEdgeInsets edgeInset = _originalEdgeInset;
                    edgeInset.top += FCXLoadingOffsetHeight;
                    weakSelf.scrollView.contentInset = edgeInset;
                    _arrowImage.frame = CGRectMake((self.bounds.size.width-5)/2, 15+300, 5, 5);
                    _arrowImage.alpha = 0.1;
                    _lightView.alpha = 0.1;
                }];

                if (self.refreshHandler) {
                    self.refreshHandler(self);
                }
            }
                break;
            case FCXRefreshStateNoMoreData:
            {
            }
                break;
        }
    }
}

- (void)startRefresh {

    __weak __typeof(self)weakSelf = self;
    weakSelf.refreshState = FCXRefreshStateLoading;

    [UIView animateWithDuration:.2 animations:^{
       weakSelf.scrollView.contentOffset = CGPointMake(0, -FCXLoadingOffsetHeight);
    } completion:^(BOOL finished) {
        weakSelf.refreshState = FCXRefreshStateLoading;
    }];
}

@end
