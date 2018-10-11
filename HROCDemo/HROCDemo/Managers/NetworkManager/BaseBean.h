//
//  BaseBean.h
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 2017/1/19.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseBean : NSObject



/**
 服务器返回的状态code
 */
@property(nonatomic, assign) NSInteger status;


/**
 服务器返回的message
 */
@property(nonatomic, strong) NSString *message;


/**
 当前请求是否成功

 @return staus为1时才返回YES
 */
-(BOOL)isSuccessed;

@end
