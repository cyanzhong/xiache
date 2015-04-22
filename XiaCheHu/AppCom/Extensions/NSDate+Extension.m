//
//  NSDate+Extension.m
//  XiaCheHu
//
//  Created by cyan on 15/3/27.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "NSDate+Extension.h"
#import "AppComHeaders.h"

@implementation NSDate (Extension)

- (NSUInteger)currentHour {
    return [self defaultComponents].hour;
}

- (NSUInteger)currentMinute {
    return [self defaultComponents].minute;
}

- (NSUInteger)currentSecond {
    return [self defaultComponents].second;
}

- (NSUInteger)currentYear {
    return [self currentYearComponents].year;
}

- (NSUInteger)currentMonth {
    return [self currentYearComponents].month;
}

- (NSUInteger)currentDay {
    return [self currentYearComponents].day;
}

- (NSArray *)currentYearMonthDay {
    NSDateComponents *comp = [self currentYearComponents];
    return @[ @(comp.year), @(comp.month), @(comp.day) ];
}

- (NSDateComponents *)defaultComponents {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    return components;
}

- (NSDateComponents *)currentYearComponents {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    return components;
}

- (NSInteger)year {
    NSCalendarUnit options = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:options
                                                                   fromDate:self];
    return [components year];
}

- (NSInteger)month {
    NSCalendarUnit options = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:options
                                                                   fromDate:self];
    return [components month];
}

- (NSInteger)day {
    NSCalendarUnit options = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:options
                                                                   fromDate:self];
    return [components day];
}

- (NSInteger)week {
    NSCalendarUnit options = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:options
                                                                   fromDate:self];
    return [components weekday];
}

- (NSInteger)weekOfYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [[calendar components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month ofYear:(NSInteger)year {
    int leap = (!(year%4)&&(year%100))||!(year%400);
    const int days[2][12] = {
        { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
        { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
    };
    return days[leap][month - 1];
}

- (NSInteger)daysOfYear {
    return [NSDate numberOfDaysInMonth:self.month ofYear:self.year];
}

- (NSURL *)calshowURL {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = self.year; comps.month = self.month; comps.day = self.day;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeInterval interval = [[calendar dateFromComponents:comps] timeIntervalSinceReferenceDate];
    // trick
    NSString *s1 = @"how"; NSString *s2 = @"s"; NSString *s3 = @"cal";
    NSString *url = [NSString stringWithFormat:@"%@%@%@:%ld", s3,s2,s1, (long)interval];
    return [NSURL URLWithString:url];
}

@end
