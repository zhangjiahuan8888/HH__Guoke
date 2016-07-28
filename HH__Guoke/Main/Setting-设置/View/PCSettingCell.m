//
//  PCSettingCell.m
//  PCGuokrChoice
//
//  Created by pczhu on 16/6/19.
//  Copyright © 2016年 pc. All rights reserved.
//

#import "PCSettingCell.h"
#import "PCArrowSettingItem.h"
#import "PCSwitchSettingItem.h"

@interface PCSettingCell ()

@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) UISwitch *switchView;

@end


@implementation PCSettingCell

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
        
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    PCSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[PCSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setItem:(PCSettingItem *)item
{
    _item = item;
    
    // 设置控件上的内容
    [self setUpData];
    
    // 设置辅助视图
    [self setUpAccessoryView];
    
}

- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
}

- (void)setUpAccessoryView
{
    if ([_item isKindOfClass:[PCArrowSettingItem class]]) {
        // 箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else if ([_item isKindOfClass:[PCSwitchSettingItem class]]){
        // 开关
        self.accessoryType = UITableViewCellAccessoryNone;
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        // 还原
        self.accessoryType = UITableViewCellAccessoryNone;
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}


@end