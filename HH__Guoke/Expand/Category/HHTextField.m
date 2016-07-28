//
//  HHTextField.m
//  HH__Guoke
//
//  Created by 张家欢 on 16/7/26.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#import "HHTextField.h"

@implementation HHTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}
@end
