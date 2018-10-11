//
//  NotificationManager.h
//  XiangFa
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn) on 09/02/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import <Foundation/Foundation.h>

// 后期实现单例 -〉 新建MutableArray实现哪里注册了通知，就要在哪里移除通知，和通知log, 便于APP内通知的调试
@interface NotificationManager : NSObject


/**
 发送通知

 @param name 通知的名字
 @param anObject 传递的对象
 */
+ (void)postWithName:(NSString *)name object:(id)anObject;


/**
 注册通知

 @param observer 通知接受者
 @param aSelector 调用方法
 @param aName 通知名字
 */
+ (void)addObsrever:(id)observer selector:(SEL)aSelector name:(NSString *)aName;


/**
 移除通知

 @param observer 给接收者移除所有通知
 */
+ (void)removeObserver:(id)observer;

@end
