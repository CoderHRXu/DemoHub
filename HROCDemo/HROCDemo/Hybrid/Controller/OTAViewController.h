//
//  OTAViewController.h
//  HROCDemo
//
//  Created by Jeremy on 16/8/25.
//  Copyright © 2018年 XHR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTAViewController : XFBaseViewController
/**
 下载文件url
 */
@property (nonatomic) NSString *fileUrl;
/**
 Zip包最新版本号
 */
@property (nonatomic,retain) NSString *zipCode;
@end
