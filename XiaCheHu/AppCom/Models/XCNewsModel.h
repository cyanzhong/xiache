//
//  XCNewsModel.h
//  XiaCheHu
//
//  Created by cyan on 15/4/23.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCNewsModel : NSObject

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSString *title;

- (instancetype)initWithJSON:(NSDictionary *)json;

@end
