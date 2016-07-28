//
//  PCSettingItem.m
//  PCGuokrChoice
//
//  Created by pczhu on 16/6/19.
//  Copyright © 2016年 pc. All rights reserved.
//

#import "PCSettingItem.h"

@implementation PCSettingItem

+ (instancetype)itemWithTitle:(NSString *)title
{
    PCSettingItem *item = [[self alloc] init];
    
    item.title = title;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title andSubTitle:(NSString *)subtitle{
    
    PCSettingItem *item = [[self alloc] init];
    item.title = title;
    item.subTitle = subtitle;
    return item;
}

@end

