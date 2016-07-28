//
//  TestViewController.m
//  PCGuokrChoice
//
//  Created by pczhu on 16/6/19.
//  Copyright © 2016年 pc zhu. All rights reserved.
//

#import "AboutViewController.h"
#import "IIViewDeckController.h"


@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    naviView.backgroundColor = MainGreenColor;
    [self.view addSubview:naviView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"bar_back_icon_36x36_"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(naviView.mas_left);
        make.bottom.equalTo(naviView.mas_bottom);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"关于我们";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = MainWhiteColor;
    [naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(naviView.mas_centerX);
        make.centerY.equalTo(backBtn.mas_centerY);
    }];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about_us_logo_136x136_"]];
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.text = @"果壳精选 iOS4.2.0";
    versionLabel.font = [UIFont systemFontOfSize:15];
    versionLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgView.mas_centerX);
        make.top.equalTo(imgView.mas_bottom).offset(20);
    }];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
