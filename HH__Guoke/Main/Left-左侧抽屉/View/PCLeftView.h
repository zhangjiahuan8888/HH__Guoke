//
//  PCLeftView.h
//  GuokrChoiceness
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftListViewSelectedDelegate <NSObject>

- (void)selectedInLeftViewAtIndexOfRow:(NSInteger)row;

@end


@interface PCLeftView : UIView

@property(nonatomic,assign)id <LeftListViewSelectedDelegate>delegate;
@property(nonatomic,strong)UITableView *leftTableView;

@end
