//
//  XFTabBarController.h
//  HROCDemo
//
//  Created by Jeremy on 2016/12/13.
//  Copyright © 2018年 XHR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFTabBarController : UITabBarController

+ (instancetype)shareInstance;

/**
 切换用户模式

 @param appType 用户模式
 */
- (void)switchAppTypeTo:(DDTUserType)appType;
/**
 加载借款人
 */
- (void)loadBorrowerControllers;

/**
 加载客户经理模式
 */
- (void)loadManagerControllers;
@end
