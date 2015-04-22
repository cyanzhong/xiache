//
//  AppMacros.h
//  XiaCheHu
//
//  Created by cyanzhong on 15/2/5.
//  Copyright (c) 2015年 FunCube. All rights reserved.
//  一些比较常用的宏

#ifndef XiaCheHu_AppMacros_h
#define XiaCheHu_AppMacros_h

//  data
#define kAppGroupId         @"group.xiache.share"
#define ComDefaults         [[NSUserDefaults alloc] initWithSuiteName:kAppGroupId]
#define kSharedContainerUrl [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kAppGroupId]

// 满足条件直接返回
#define RETURN_IF(condition) \
if (condition) { \
    return ; \
} \

// 不满足条件直接返回
#define RETURN_IF_NOT(condition) \
if (!(condition)) { \
    return ; \
} \

// 如果obj为nil 直接return
#define RETURN_IF_NIL(obj) \
if (nil == (obj)) { \
    return ; \
} \

// 满足条件 continue
#define CONTINUE_IF(condition) \
if (condition) { \
    continue ; \
} \

// 不满足条件 continue
#define CONTINUE_IF_NOT_(condition) \
if (!(condition)) { \
    continue ; \
} \

// 用于生成单例
#define DEF_SINGLETON(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
    _sharedObject = block(); \
}); \
return _sharedObject; \

//#define DebugLog

// 输出
#ifdef DebugLog
#   define Log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define Log(...)
#endif

// 屏幕
#define SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SCALE        ([UIScreen mainScreen].scale)

// 颜色
#define RGBA(R, G, B, A)    [UIColor colorWithRed: R/255.0 green: G/255.0 blue: B/255.0 alpha: A]
#define RGB(R, G, B)        RGBA(R, G, B, 1.0)
#define HexColor(v)         RGB((double)((v&0xff0000)>>16), (double)((v&0xff00)>>8), (double)(v&0xff))

// 机型判定 这个地方注意横竖屏会影响判断结果
#define DEVICE_PORTRAIT     (SCREEN_WIDTH < SCREEN_HEIGHT)
#define DEVICE_LANDSCAPE    (!DEVICE_PORTRAIT)
#define DEVICE_HEIGHT       (DEVICE_PORTRAIT ? SCREEN_HEIGHT : SCREEN_WIDTH)
#define DEVICE_WIDTH        (DEVICE_PORTRAIT ? SCREEN_WIDTH : SCREEN_HEIGHT)
#define IS_IPHONE4_TO_5S    (DEVICE_WIDTH  <= 320)
#define IS_IPHONE5_OR_LATER (DEVICE_HEIGHT >= 568)
#define IS_IPHONE4          (DEVICE_HEIGHT <= 480)
#define IS_IPHONE6          (DEVICE_HEIGHT >= 667 && DEVICE_HEIGHT < 736)
#define IS_IPHONE6_PLUS     (DEVICE_HEIGHT >= 736)

#define IOS_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_OS_5_OR_LATER    (IOS_VERSION >= 5.0)
#define IS_OS_6_OR_LATER    (IOS_VERSION >= 6.0)
#define IS_OS_7_OR_LATER    (IOS_VERSION >= 7.0)
#define IS_OS_8_OR_LATER    (IOS_VERSION >= 8.0)

// 获取本地化字符串
#define i18n(text)          NSLocalizedStringFromTable(text , @"InfoPlist", nil)
// 返回不为空的字符串
#define NON_EMPTY_STR(str)  (str ? str: @"")
// 判断字符串是否为空
#define IS_EMPTY_STR(str)       (str == nil || [str isEqualToString:@""])
#define IS_NOT_EMPTY_STR(str)   (!IS_EMPTY_STR(str))
// 得到一个不为null的NSNumber
#define NS_NUM(x)           @([x intValue])

// 时间相关
#define CURRENT_TIME_SEC    ([[NSDate date] timeIntervalSince1970])
#define CURRENT_SYSUP_SEC   ([[NSProcessInfo processInfo] systemUptime])

// App/Documents文件夹
#define DOC_PATH(name)      [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:name]

// App Bundle文件夹
#define BUNDLE_PATH(name, type) [[NSBundle mainBundle] pathForResource:name ofType:type]

// 生成一个a~b闭区间的随机数
#define RANDOM_NUM(from, to)    (arc4random_uniform(to - from + 1) + from)

// 计时
#define TIME_BEGIN \
double beginTime = CURRENT_TIME_SEC; \

#define TIME_END \
double endTime = CURRENT_TIME_SEC; \
NSLog(@"time used: %lf", (endTime - beginTime)); \


#endif
