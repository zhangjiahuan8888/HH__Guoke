//
//  PCSettingCell.h
//  PCGuokrChoice
//
//  Created by pczhu on 16/6/19.
//  Copyright © 2016年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCSettingItem;
@interface PCSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) PCSettingItem *item;

@end
