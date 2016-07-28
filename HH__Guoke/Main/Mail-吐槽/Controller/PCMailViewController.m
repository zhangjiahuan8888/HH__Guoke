//
//  PCMailViewController.m
//  GuokrChoiceness
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 pc. All rights reserved.
//

#import "PCMailViewController.h"
#import "HHTextField.h"

@interface PCMailViewController ()<UITextViewDelegate>
{
    UILabel *placeholderLabel;
    HHTextField *emailTextField;
    UITextView *feedbackTextView;
}
@end

@implementation PCMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;

    [self creatSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignFirst) name:kOpenSideNotification object:nil];
}

- (void)creatSubviews{
    
    emailTextField = [[HHTextField alloc] init];
    emailTextField.backgroundColor = MainWhiteColor;
    emailTextField.placeholder = @"请留下您的QQ或邮箱";
    emailTextField.layer.borderWidth = 0.5;
    emailTextField.layer.cornerRadius = 3;
    emailTextField.layer.borderColor = [UIColor colorWithHexString:@"#bfbfbf"].CGColor;
    [emailTextField setValue:PlaceholderGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:emailTextField];
    [emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.view.mas_top).offset(15);
    }];
    
    feedbackTextView = [[UITextView alloc] init];
    feedbackTextView.backgroundColor = MainWhiteColor;
    feedbackTextView.layer.borderWidth = 0.5;
    feedbackTextView.layer.cornerRadius = 3;
    feedbackTextView.delegate = self;
    feedbackTextView.font = [UIFont systemFontOfSize:17];
    feedbackTextView.layer.borderColor = [UIColor colorWithHexString:@"#bfbfbf"].CGColor;
    [self.view addSubview:feedbackTextView];
    [feedbackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(120);
        make.top.equalTo(emailTextField.mas_bottom).offset(15);
    }];
    
    placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.text = @"请写下您的反馈";
    placeholderLabel.textColor = PlaceholderGrayColor;
    [feedbackTextView addSubview:placeholderLabel];
    [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(feedbackTextView.mas_left).offset(10);
        make.top.equalTo(feedbackTextView.mas_top).offset(10);
    }];
    
}
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        placeholderLabel.text = @"请写下您的反馈";
    } else {
        placeholderLabel.text = @"";
    }
}
- (void)resignFirst{
    [emailTextField resignFirstResponder];
    [feedbackTextView resignFirstResponder];
}
- (void)publishAction{
    NSLog(@"提交成功");
}

@end
