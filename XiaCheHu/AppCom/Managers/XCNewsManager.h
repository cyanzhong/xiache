//
//  XCNewsManager.h
//  XiaCheHu
//
//  Created by cyan on 15/4/23.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCNewsModel.h"
#import "XCQuestionModel.h"

@interface XCNewsManager : NSObject

+ (instancetype)manager;

- (void)getIndexes:(void (^)(XCNewsModel *newsModel))success;

- (void)getQuestions:(XCNewsModel *)newsModel success:(void (^)(NSArray *questions))success;

@end
