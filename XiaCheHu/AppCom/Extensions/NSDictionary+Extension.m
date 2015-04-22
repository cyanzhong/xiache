//
//  NSDictionary+Extension.m
//  AirWatch
//
//  Created by cyan on 15/3/10.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSArray *)sortedKeys {
    return [self.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

@end
