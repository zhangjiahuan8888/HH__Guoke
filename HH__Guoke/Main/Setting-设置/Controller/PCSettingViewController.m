//
//  PCSettingViewController.m
//  GuokrChoiceness
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 pc. All rights reserved.
//

#import "PCSettingViewController.h"
#import "PCSwitchSettingItem.h"
#import "PCArrowSettingItem.h"
#import "PCSettingCell.h"
#import "PCSettingSection.h"
#import "PCSettingFooterView.h"
#import "AboutViewController.h"

@interface PCSettingViewController ()

// 记录当前tableView的所有数组
@property (nonatomic, strong) NSMutableArray *sections;

@end

@implementation PCSettingViewController

- (NSMutableArray *)sections
{
    if (!_sections) {
        self.sections = [NSMutableArray array];
    }
    return _sections;
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = nil;
    
    // 添加第一组
    [self setUpSection0];
    
    [self setUpSection1];
    
    [self setUpSection2];
    
    [self setUpSection3];
    
}

- (void)setUpSection0{
    PCArrowSettingItem *loginItem = [PCArrowSettingItem itemWithTitle:@"点击登录"];
    
    PCSettingSection *section = [PCSettingSection sectionWithItems:@[loginItem]];
    
    [self.sections addObject:section];
}

- (void)setUpSection1{
    PCSwitchSettingItem *download = [PCSwitchSettingItem itemWithTitle:@"自动离线下载"];
    
    PCSettingSection *section = [PCSettingSection sectionWithItems:@[download]];
    section.footTitle = @"打开后，WiFi下将自动下载最新20篇文章供离线查看";
    
    [self.sections addObject:section];
}

- (void)setUpSection2{
    PCSwitchSettingItem *largeFont = [PCSwitchSettingItem itemWithTitle:@"大字体"];
    PCSettingItem *cleanCache = [PCSettingItem itemWithTitle:@"清理缓存" andSubTitle:@"0.2M"];
    
    PCSettingSection *section = [PCSettingSection sectionWithItems:@[largeFont,cleanCache]];
    
    [self.sections addObject:section];
}

- (void)setUpSection3{
    
    PCArrowSettingItem *about = [PCArrowSettingItem itemWithTitle:@"关于我们"];
    about.destVc = [AboutViewController class];
    PCSettingSection *section = [PCSettingSection sectionWithItems:@[about]];
    
    [self.sections addObject:section];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PCSettingSection *settingSection = self.sections[section];
    return settingSection.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCSettingCell *cell = [PCSettingCell cellWithTableView:tableView];
    
    PCSettingSection *section = self.sections[indexPath.section];
    
    PCSettingItem *item = section.items[indexPath.row];
    cell.item = item;
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    PCSettingFooterView *footer;
    // 设置label的数据
    if (section == 1) {
        footer = [PCSettingFooterView footerViewWithTableView:tableView];
        PCSettingSection *settingSection = self.sections[section];
        footer.title = settingSection.footTitle;
    } else {
        footer = nil;
    }
    return footer;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == 1) ? 25 : 8;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出哪一组
    PCSettingSection *section = self.sections[indexPath.section];
    
    // 取出哪一行
    PCSettingItem *item = section.items[indexPath.row];
    
    if (item.itemOpertion) {
        item.itemOpertion();
        return;
    }
    
    if ([item isKindOfClass:[PCArrowSettingItem class]]) {
        PCArrowSettingItem *arrowItem = (PCArrowSettingItem *)item;
        
        if (arrowItem.destVc) {
            // 才需要跳转
            AboutViewController *vc = [[arrowItem.destVc alloc] init];
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
    }
}

@end


