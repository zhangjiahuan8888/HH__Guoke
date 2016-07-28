//
//  PCSettingFooterView.m
//  PCGuokrChoice
//
//  Created by pczhu on 16/6/19.
//  Copyright © 2016年 pc. All rights reserved.
//

#import "PCSettingFooterView.h"

@interface PCSettingFooterView()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;
@end

@implementation PCSettingFooterView

+ (instancetype)footerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"footer";
    PCSettingFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 缓存池中没有, 自己创建
        header = [[PCSettingFooterView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //        self.contentView.backgroundColor = [UIColor greenColor];
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.y = 5;
        //        label.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
        label.width = [UIScreen mainScreen].bounds.size.width;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}


@end