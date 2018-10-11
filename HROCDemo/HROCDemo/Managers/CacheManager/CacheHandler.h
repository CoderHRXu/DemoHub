//
//  CacheHandler.h
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 05/02/2017.
//  Copyright © 2017 RJS. All rights reserved.
//

#import <Foundation/Foundation.h>


// 取 CacheHandler 对象
#define CacheHandlerInstance [CacheHandler sharedHandler]

@interface CacheHandler : NSObject

+ (instancetype) sharedHandler;


/**
 取当前登录的用户
 */
//@property (strong, nonatomic) User          *currentUser;

/**
 返回用户是否登录
 */
@property (assign, nonatomic) BOOL          userLoggedin;

/**
 返回APP的设置信息
 */
//@property (strong, nonatomic) AppSetting    *currentSetting;



/**
 登出时 重置
 */
- (void)resetCache;

- (void)deleteAllFormalLoan;
@end
