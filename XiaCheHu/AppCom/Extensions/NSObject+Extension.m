//
//  NSObject+Extension.m
//  XiaCheHu
//
//  Created by cyanzhong on 14/12/11.
//  Copyright (c) 2014年 FunCube. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (void)perform:(void (^)(void))action afterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(fireAfterDelay:)
               withObject:action
               afterDelay:delay];
}

- (void)fireAfterDelay:(void (^)(void))block {
    block();
}

- (void)perform:(void (^)(void))action tag:(NSString *)tag {
    double begin = [[NSDate date] timeIntervalSince1970];
    action();
    double end = [[NSDate date] timeIntervalSince1970];
    NSLog(@"%@, time: %lf", tag, end - begin);
}

@end
