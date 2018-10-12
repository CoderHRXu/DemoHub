//
//  Constants.h
//  HROCDemo
//
//  Created by Jeremy Pan on 16/7/15.
//  Copyright © 2018年 XHR. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#if   SIT
#define CookieDomain                @"172.16.88.167"
#elif UAT
#define CookieDomain                @"172.16.88.168"
#elif PRO
#define CookieDomain                @".naxintech.cn"
#endif

#endif

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface Constants:NSObject

/**
 获取H5页面基础Path

 @return pathString
 */
+ (NSString *)basePath;
@end
