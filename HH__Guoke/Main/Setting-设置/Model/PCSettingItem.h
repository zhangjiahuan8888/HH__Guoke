//
//  PCSettingItem.h
//  PCGuokrChoice
//
//  Created by pczhu on 16/6/19.
//  Copyright © 2016年 pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCSettingItem : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *subTitle;

+ (instancetype)itemWithTitle:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title andSubTitle:(NSString *)subtitle;

// 用来保存每一行cell的功能
@property (nonatomic, strong) void(^itemOpertion)();

@end
