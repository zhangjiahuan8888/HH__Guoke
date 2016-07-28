//
//  NetworkService.h
//  MyWeibo
//
//  Created by JohnJack on 16/1/27.
//  Copyright (c) 2016年 zjh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(NSError *error);

@interface NetworkService : NSObject

+ (NSURLSessionDataTask *)requestWithURL:(NSString *)url
                                  params:(NSDictionary *)params
                                 success:(SuccessBlock)sBlock
                                 failure:(FailureBlock)fBlock;
@end
