//
//  NetworkService.m
//  MyWeibo
//
//  Created by JohnJack on 16/1/27.
//  Copyright (c) 2016年 zjh. All rights reserved.
//

#import "NetworkService.h"
#import "AppDelegate.h"
#import "AFNetworking.h"

@implementation NetworkService

+ (NSURLSessionDataTask *)requestWithURL:(NSString *)url
                                  params:(NSDictionary *)params
                                 success:(SuccessBlock)sBlock
                                 failure:(FailureBlock)fBlock{
    //1.拼接完整字符串
//    url = [NSString stringWithFormat:@"%@%@",ApiDomain,url];
    
    //2.设置完整的参数
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:params];
//    NSString *mid = [[NSUserDefaults standardUserDefaults] objectForKey:@"mid"];
//    if (!mid) {
//        NSString *token = [NSString stringWithFormat:@"vip.ofim.com.cn?Mobile_token@%@",mid];
//        
//        [mDic setObject:[CJMD5 md5:token] forKey:@"token"];
//    }else{
//        [mDic setObject:LogoutToken forKey:@"token"];
//    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableLeaves];
 
//    NSURLSessionDataTask *dataTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//         
//     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         sBlock(responseObject);
//     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         fBlock(error);
//     }];
    NSURLSessionDataTask *dataTask = [manager GET:url parameters:mDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         fBlock(error);
    }];
    return dataTask;

}
@end
