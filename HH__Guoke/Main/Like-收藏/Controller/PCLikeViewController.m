//
//  PCCollectionViewController.m
//  GuokrChoiceness
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 pc. All rights reserved.
//

#import "PCLikeViewController.h"

@interface PCLikeViewController ()

@end

@implementation PCLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}



@end
