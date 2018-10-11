//
//  RequestHelper.h
//  XiangFa
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn) on 09/02/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 用于 调用使用频率较高的 网络请求，比如 绑定和解绑 推送的clientId
 用于 网络请求的嵌套调用
 */
@interface RequestHelper : NSObject


+ (void)bindClientId;

+ (void)unbindClientId;



@end
