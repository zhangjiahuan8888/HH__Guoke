//
//  PCLeftViewController.m
//  GuokrChoiceness
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 pc. All rights reserved.
//

#import "PCLeftViewController.h"
#import "PCLeftView.h"
#import "IIViewDeckController.h"
#import "PCHomeViewController.h"

@interface PCLeftViewController ()<LeftListViewSelectedDelegate>

/**
 *  上次选中的行
 */
@property (nonatomic, assign) NSInteger preSelectedRow;


@property (nonatomic, strong) PCLeftView *leftView;

@end

@implementation PCLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MaindarkColor;
    
    //默认选中第0行
    self.preSelectedRow = 0;
    
    PCLeftView *leftView = [[PCLeftView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:leftView];
    leftView.delegate = self;
    self.leftView = leftView;

}

#pragma mark - <LeftListViewSelectedDelegate>
- (void)selectedInLeftViewAtIndexOfRow:(NSInteger)row{
    
    if (self.preSelectedRow == row) {//选中同一行,直接关闭左视图
        [self.viewDeckController closeLeftViewAnimated:YES];
        return;
    } else{//选中不同行,发送通知,切换center显示
        self.preSelectedRow = row;
        NSDictionary *dict = @{@"row":[NSString stringWithFormat:@"%ld",(long)row]};
        [[NSNotificationCenter defaultCenter] postNotificationName:CloseLeftView object:dict];
    }
}





@end
