//
//  PCLeftView.m
//  GuokrChoiceness
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 pc. All rights reserved.
//

#import "PCLeftView.h"
#import "PCHomeViewController.h"

#define PreviousIndexPath @"previousIndexPath"

#define LeftWidth [UIScreen mainScreen].bounds.size.width / 3 * 2
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PCLeftView()
{
    UIView *selectedView;
}
@end

@implementation PCLeftView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self creatButtons];
    }
    return self;
}
- (void)creatButtons{
    selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = SelectedGrayColorColor;
    [self addSubview:selectedView];
    [selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(55);
        make.width.mas_equalTo(3/4.f*kSCREEN_WIDTH);
        make.top.equalTo(self.mas_top).offset(162);
    }];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.tag = 100;
    [homeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:homeBtn];
    [homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(55);
        make.width.mas_equalTo(3/4.f*kSCREEN_WIDTH);
        make.top.equalTo(self.mas_top).offset(162);
    }];
    
    UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [favoriteBtn setTitle:@"收藏" forState:UIControlStateNormal];
    favoriteBtn.tag = 101;
    [favoriteBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:favoriteBtn];
    [favoriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(55);
        make.width.mas_equalTo(3/4.f*kSCREEN_WIDTH);
        make.top.equalTo(homeBtn.mas_bottom);
    }];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    settingBtn.tag = 102;
    [settingBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingBtn];
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(55);
        make.width.mas_equalTo(3/4.f*kSCREEN_WIDTH);
        make.top.equalTo(favoriteBtn.mas_bottom);
    }];
    
    UIButton *feedbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [feedbackBtn setTitle:@"反馈" forState:UIControlStateNormal];
    feedbackBtn.tag = 103;
    [feedbackBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:feedbackBtn];
    [feedbackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(55);
        make.width.mas_equalTo(3/4.f*kSCREEN_WIDTH);
        make.top.equalTo(settingBtn.mas_bottom);
    }];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_guokr_logo_105x31_"]];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-40);
        make.centerX.equalTo(self.mas_left).offset(3.f/4.f*kSCREEN_WIDTH/2);
    }];
    
    for (NSInteger i=0; i<3; i++) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = LineGrayColor;
        UIButton *btn = [self viewWithTag:i+100];
        [btn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(btn.mas_left).offset(15);
            make.height.mas_equalTo(0.5);
            make.right.equalTo(btn.mas_right).offset(-15);
            make.bottom.equalTo(btn.mas_bottom);
        }];
    }
}

- (void)buttonClick:(UIButton *)button{
    selectedView.center = button.center;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedInLeftViewAtIndexOfRow:)]) {
        [self.delegate selectedInLeftViewAtIndexOfRow:button.tag-100];
    }
}


@end
















