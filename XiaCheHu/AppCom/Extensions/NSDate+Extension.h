//
//  NSDate+Extension.h
//  XiaCheHu
//
//  Created by cyan on 15/3/27.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    ChineseDateFieldYear = 0,
    ChineseDateFieldMonth,
    ChineseDateFieldDay,
    ChineseDateFieldAll,
    ChineseDateFieldYearMonth,
    ChineseDateFieldMonthDay
}ChineseDateField;

@interface NSDate (Extension)

// current
- (NSUInteger)currentHour;
- (NSUInteger)currentMinute;
- (NSUInteger)currentSecond;
- (NSUInteger)currentYear;
- (NSUInteger)currentMonth;
- (NSUInteger)currentDay;
- (NSArray *)currentYearMonthDay;

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)week;
- (NSInteger)weekOfYear;
- (NSInteger)daysOfYear;

- (NSURL *)calshowURL;

@end
