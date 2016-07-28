//
//  AppDelegate.m
//  HH__Guoke
//
//  Created by 张家欢 on 16/7/25.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#import "AppDelegate.h"
#import "IIViewDeckController.h"
#import "PCBaseViewController.h"
#import "PCHomeViewController.h"
#import "PCLeftViewController.h"

@interface AppDelegate ()<IIViewDeckControllerDelegate>
@property (nonatomic,strong) IIViewDeckController *deckController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //创建中间的视图控制器
    PCBaseViewController * centerVC = [[PCBaseViewController alloc] init];
    UINavigationController * navVC = [[UINavigationController alloc] initWithRootViewController:centerVC];
    
    //创建左菜单栏视图控制器
    PCLeftViewController * leftVC = [[PCLeftViewController alloc] init];
    
    //创建deckController
    _deckController = [[IIViewDeckController alloc] initWithCenterViewController:navVC leftViewController:leftVC rightViewController:nil];
    _deckController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    _deckController.elastic = NO;//去掉centerVC的弹性效果
    _deckController.shadowEnabled = YES;//去掉centerVC与leftVC之间的阴影过渡
    _deckController.leftSize = [UIScreen mainScreen].bounds.size.width / 4 ;
    _deckController.delegate = self;
    self.window.rootViewController = _deckController;
    [_deckController setPanningMode:IIViewDeckAllViewsPanning];
    return YES;
}
- (void)viewDeckController:(IIViewDeckController *)viewDeckController willOpenSide:(IIViewDeckSide)side{
    [[NSNotificationCenter defaultCenter] postNotificationName:kOpenSideNotification object:nil];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
