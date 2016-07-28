//
//  PCHomeViewController.m
//  GuokrChoiceness
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 pc. All rights reserved.
//

#import "PCHomeViewController.h"
#import "HomeCell.h"
#import "presentedVC.h"
#import "NetworkService.h"
#import "HomeModel.h"
#import "SDCycleScrollView.h"
#import "FCXRefreshFooterView.h"
#import "FCXRefreshHeaderView.h"
#import "UIScrollView+FCXRefresh.h"
@interface PCHomeViewController () <UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
    FCXRefreshHeaderView *headerView;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *models; /**< models */
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) NSMutableArray *sdTitles;
@property (nonatomic,strong) NSMutableArray *sdImageUrls;
@end

@implementation PCHomeViewController

static NSString * const PCArticleId = @"article";
static NSString *identifer = @"HomeCell";
- (void)viewDidLoad {
    [super viewDidLoad];

    self.models = [NSMutableArray array];
    self.sdTitles = [NSMutableArray array];
    self.sdImageUrls = [NSMutableArray array];
    
    [self requestData];
    [self creatSubviews];
    
    __weak __typeof(self)weakSelf = self;
    headerView = [_tableView addHeaderWithRefreshHandler:^(FCXRefreshBaseView *refreshView) {
        [weakSelf requestData];
    }];

}
- (void)requestData{
    
//    [self.sdImageUrls removeAllObjects];
//    [self.sdTitles removeAllObjects];
    
    [NetworkService requestWithURL:adUrl params:nil success:^(id result) {
        NSLog(@"%@",result);
        NSArray *imgArray = result[@"result"];
        for (NSDictionary *dic in imgArray) {
            if (![dic[@"custom_title"]isEqualToString:@""]) {
                
                [self.sdTitles addObject:dic[@"custom_title"]];
                [self.sdImageUrls addObject:dic[@"picture"]];
            }
        }
        _cycleScrollView.titlesGroup = self.sdTitles;
        _cycleScrollView.imageURLStringsGroup = self.sdImageUrls;
        [headerView endRefresh];
    } failure:^(NSError *error) {
        NSLog(@"----%@",error);
        [headerView endRefresh];
    }];

//    [_models removeAllObjects];
    NSDictionary *paramDic = @{@"category":@"all",
                               @"since":@1469519796,
                               @"ad":@1,
                               @"orientation":@"before",
                               @"limit":@20,
                               @"retrieve_type":@"by_since"};
    [NetworkService requestWithURL:homeUrl params:paramDic success:^(id result) {
        NSLog(@"----%@",result);
        [headerView endRefresh];
        [_models removeAllObjects];
        NSArray *array = result[@"result"];
        for (NSDictionary *dic in array) {
            HomeModel *model = [HomeModel yy_modelWithDictionary:dic];
            [_models addObject:model];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [headerView endRefresh];
        NSLog(@"----%@",error);
    }];
}
- (void)creatSubviews{
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH,
                                                           kSCREEN_WIDTH * 300 / 640)
                       delegate:self
                       placeholderImage:[UIImage imageNamed:@"image-holder"]];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    _cycleScrollView.autoScrollTimeInterval = 3;
    _cycleScrollView.titlesGroup = nil;

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 85;
    _tableView.tableHeaderView = _cycleScrollView;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[HomeCell class] forCellReuseIdentifier:identifer];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.model = _models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [keyWindow convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    
    presentedVC *rootVC = [[presentedVC alloc]init];
    HomeModel *model = _models[indexPath.row];
    rootVC.link = model.link_v2;
    [self animationTo:rootVC from:rect];
}

/**
 *  扩展展示
 *
 *  @param viewController 要展示的VC
 *  @param frame          白色展开条的初始位置
 */
-(void)animationTo:(UIViewController*)viewController from:(CGRect)frame{
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    
    //黑色遮罩
    UIView *backgroudView = [[UIView alloc]initWithFrame:keyWindow.bounds];
    backgroudView.backgroundColor = [UIColor blackColor];
    backgroudView.alpha = 0.7;
    [keyWindow addSubview:backgroudView];
    
    //白色展开块
    UIView *whiteView = [[UIView alloc]initWithFrame:frame];
    whiteView.backgroundColor = [UIColor whiteColor];
    [keyWindow addSubview:whiteView];
    
    NSTimeInterval timeInterval = 0.5;
    
    [UIView animateWithDuration:timeInterval animations:^{
        whiteView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        //这两句可以保证，下一个视图覆盖了当前视图的时候，当前视图依然在渲染
        viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:nav animated:NO completion:^{
            [whiteView removeFromSuperview];
            [backgroudView removeFromSuperview];
        }];
    }];
    
    [UIView animateWithDuration:timeInterval animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        self.navigationController.view.transform = CGAffineTransformIdentity;
    }];
    
}

@end
