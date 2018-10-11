//
//  Utils.h
//  XiangFa
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn) on 09/02/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

/**
 设备型号
 */
+ (NSString*)deviceVersion;

/**
 获取网络状态 0=无网络, 1=WIFI, 2=2G, 3=3G, 4=4G, -1=不可识别的网络
 
 @return number
 */
+ (int)getNetStatus;

/**
 网络运营商类型
 
 @return 1中国移动 2中国电信 3中国联通 4其他
 */
+ (int)serviceProvider;

/**
 指定年和月，返回指定月的天数

 @param year 指定的年
 @param month 指定的月份
 @return 返回月的天数
 */
+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month;

/**
 压缩图片

 @param image 要压缩的图片
 @return 压缩后的Data
 */
+ (NSData *)compressImage:(UIImage *)image;
@end
