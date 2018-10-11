//
//  XFCommonFuncs.h
//  XiangFa
//
//  Created by WeiWei on 17/2/23.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , MLFormatTimeStyle) {
    MLFormatTimeStyleBackSlash = 1,      //反斜线格式 0000/00/00 00:00
    MLFormatTimeStyleCharSeg = 2,        //年月日格式 0000年00月00日 00:00
    MLFormatTimeStyleHyphen = 3          //连接符格式 0000-00-00 00:00
};

@interface XFCommonFuncs : NSObject

+ (XFCommonFuncs *)sharedInstance;

- (NSString *)formatTimeWithTimeStamp:(NSTimeInterval)timeStamp Style:(MLFormatTimeStyle)style;

- (CGSize)getImageSizeWithURL:(id)imageURL;

+ (UIViewController *)getCurrentVC;

@end
