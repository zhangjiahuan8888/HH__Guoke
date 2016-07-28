//
//  PCSettingSection.m
//  PCGuokrChoice
//
//  Created by pczhu on 16/6/19.
//  Copyright © 2016年 pc. All rights reserved.
//

#import "PCSettingSection.h"

@implementation PCSettingSection

+ (instancetype)sectionWithItems:(NSArray *)items
{
    PCSettingSection *section = [[self alloc] init];
    
    section.items = items;
    
    return section;
}

@end
