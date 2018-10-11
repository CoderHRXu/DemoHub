//
//  MD5Encryption.h
//  dingdong
//
//  Created by clubo on 16/5/17.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Encryption : NSObject
/**
 *  string转换成md5
 *
 *  @param str str description
 *
 *  @return 待加密字符串
 */
+ (NSString *)stringToMD5:(NSString *)str;
@end
