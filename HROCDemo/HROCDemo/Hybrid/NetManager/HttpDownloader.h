//
//  Downloader.h
//  HROCDemo
//
//  Created by clubo on 16/5/12.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpDownloadeCompletionBlock)(NSURL * __nullable location, NSError * __nullable error);
typedef void (^HttpDownloaderDidWriteDataBlock)(int64_t totalBytesWritten,int64_t totalBytesExpectedToWrite);

@interface HttpDownloader : NSObject<NSURLSessionDownloadDelegate>

/**
 *  下载
 *
 *  @param url          url
 *  @param completion   下载完成
 *  @param downloading 下载中
 */
-(void)download:( NSURL * _Nonnull )url completion:(void (^ _Nullable )(NSURL * _Nullable location, NSError *  _Nullable error))completion downloading:(void (^ _Nullable )(int64_t totalBytesWritten,int64_t totalBytesExpectedToWrite))downloading;

@end
