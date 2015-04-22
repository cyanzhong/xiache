//
//  XCNewsManager.h
//  XiaCheHu
//
//  Created by cyan on 15/4/23.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCNewsModel.h"
#import "XCContentModel.h"

@interface XCNewsManager : NSObject

+ (instancetype)manager;

- (void)getLatest:(void (^)(XCNewsModel *newsModel))success;

- (void)getContent:(XCNewsModel *)newsModel success:(void (^)(NSArray *contents))success;

@end
