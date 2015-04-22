//
//  XCNewsModel.m
//  XiaCheHu
//
//  Created by cyan on 15/4/23.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "XCNewsModel.h"
#import "JSONKit.h"
#import "NSString+Extension.h"

@implementation XCNewsModel

- (instancetype)initWithJSON:(NSDictionary *)json {
    if (self = [super init]) {
        self.images = json[@"images"];
        self.title = [json[@"title"] trim];
        self.type = [json[@"type"] intValue];
        self.newsId = json[@"id"];
        self.ga_prefix = json[@"ga_prefix"];
    }
    return self;
}

@end
