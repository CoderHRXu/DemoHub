//
//  NSString+PinyinConversion.h
//  NaXinHaoDai
//
//  Created by Jeremy on 2017/9/13.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PinyinConversion)


/**
 判断字符串是否是中文

 @return YES or NO
 */
- (BOOL)isIncludeChineseInString;

/**
 转换为拼音

 @return pinyin
 */
- (NSString *)chineseConvertToPinYin;

/**
 转换为拼音首字母

 @return py
 */
- (NSString *)chineseConvertToPinYinHead;

@end
