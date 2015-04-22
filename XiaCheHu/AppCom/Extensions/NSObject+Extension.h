//
//  NSObject+Extension.h
//  XiaCheHu
//
//  Created by cyanzhong on 14/12/11.
//  Copyright (c) 2014年 FunCube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

// 延时执行
- (void)perform:(void (^)(void))action afterDelay:(NSTimeInterval)delay;

// 执行并且计时
- (void)perform:(void (^)(void))action tag:(NSString *)tag;

@end
