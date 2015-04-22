//
//  AppNotifications.h
//  XiaCheHu
//
//  Created by cyan on 15/1/21.
//  Copyright (c) 2015年 FunCube. All rights reserved.
//  通知

#ifndef XiaCheHu_AppNotifications_h
#define XiaCheHu_AppNotifications_h

#define XCAddNotification(funSelector, notificationName)    [[NSNotificationCenter defaultCenter] addObserver:self selector:funSelector name:notificationName object:nil]

#define XCPostNotification(name)                            [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil]

#define XCPostNotifcationWithObj(name, obj)                 [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj]

#define XCRemoveNotification(name)                          [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil]

#define XCRemoveAllNotifications()                          [[NSNotificationCenter defaultCenter] removeObserver:self]

#endif
