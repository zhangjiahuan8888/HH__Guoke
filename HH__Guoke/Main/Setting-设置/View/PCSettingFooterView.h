//
//  PCSettingFooterView.h
//  PCGuokrChoice
//
//  Created by pczhu on 16/6/19.
//  Copyright © 2016年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCSettingFooterView : UITableViewHeaderFooterView

/** 文字数据 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)footerViewWithTableView:(UITableView *)tableView;

@end
