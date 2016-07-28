//
//  PCSettingSection.h
//  PCGuokrChoice
//
//  Created by pczhu on 16/6/19.
//  Copyright © 2016年 pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCSettingSection : NSObject

// items(PCSettingItem)
@property (nonatomic, strong) NSArray *items;

//@property (nonatomic, strong) NSString *headTitle;

@property (nonatomic, strong) NSString *footTitle;

+ (instancetype)sectionWithItems:(NSArray *)items;

@end