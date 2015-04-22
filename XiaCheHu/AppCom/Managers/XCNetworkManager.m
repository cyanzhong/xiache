//
//  XCNetworkManager.m
//  HisToday
//
//  Created by cyan on 15/4/22.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "XCNetworkManager.h"
#import "AppComHeaders.h"

@implementation XCNetworkManager

+ (instancetype)manager {
    DEF_SINGLETON(^{
        return [[self alloc] init];
    });
}

- (void)get:(NSString *)url success:(void (^)(NSString *response))success failure:(void (^)(NSString *))failure {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    [mgr GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        success(string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.localizedDescription);
    }];
}

@end
