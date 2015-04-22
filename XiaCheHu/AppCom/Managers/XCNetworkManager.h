//
//  XCNetworkManager.h
//  HisToday
//
//  Created by cyan on 15/4/22.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

static NSString * const kAPIURL = @"http://news-at.zhihu.com/api/3/news/latest";

@interface XCNetworkManager : NSObject

+ (instancetype)manager;

- (void)get:(NSString *)url success:(void (^)(NSString *response))success failure:(void (^)(NSString *errMsg))failure;

@end
