//
//  UIBarButtonItem+Extension.m
//  Weibo
//
//  Created by mac on 15/12/15.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建玩的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    
    button.size = CGSizeMake(50,50);
    
//    //让按钮内部所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    //调整内边距，是按钮再向左移
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
