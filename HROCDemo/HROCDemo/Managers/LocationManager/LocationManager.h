//
//  LocationManager.h
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 06/02/2017.
//  Copyright © 2017 RJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef __block void (^LocatedSuccessBlcok)(NSString *locationStr);

@interface LocationManager : NSObject


/**
 是否有位置权限

 @return 返回
 */
+ (BOOL)hasLocationPermission;


/**
 开始定位

 @param locatedSuccessBlcok 定位成功的Block，返回坐标字符串
 */
- (void)startLocation:(LocatedSuccessBlcok) locatedSuccessBlcok;



@end
