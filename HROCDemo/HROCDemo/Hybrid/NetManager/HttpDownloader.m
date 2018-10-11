//
//  Downloader.m
//  HROCDemo
//
//  Created by clubo on 16/5/12.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "HttpDownloader.h"
#import <UIKit/UIKit.h>
@interface HttpDownloader ()

/**
 *  下载完成事件
 */
@property (nonatomic, copy) HttpDownloadeCompletionBlock completionBlock;
/**
 *  下载中
 */
@property (nonatomic, copy) HttpDownloaderDidWriteDataBlock didWriteDataBlock;

@end

@implementation HttpDownloader
/**
 *  下载
 *
 *  @param url               <#url description#>
 *  @param completionHandler <#completionHandler description#>
 *  @param errorHandler      <#errorHandler description#>
 *  @param didWriteData      <#didWriteData description#>
 */
-(void)download:( NSURL * _Nonnull )url completion:(void (^ _Nullable )(NSURL * _Nullable location, NSError *  _Nullable error))completion downloading:(void (^ _Nullable )(int64_t totalBytesWritten,int64_t totalBytesExpectedToWrite))downloading
{
    NSURLSessionConfiguration  *sessionConfig =[NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建网络会话
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue new]];
    
    NSURLRequest *imgRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.f];
    
    //创建下载任务
    NSURLSessionDownloadTask * task = [session downloadTaskWithRequest:imgRequest];
    
    //启动下载任务
    [task resume];
    
    self.completionBlock=completion;
    self.didWriteDataBlock=downloading;
}

#pragma mark 下载委托

/**
 *  下载中
 *
 *  @param session                   session description
 *  @param downloadTask              <#downloadTask description#>
 *  @param bytesWritten              <#bytesWritten description#>
 *  @param totalBytesWritten         <#totalBytesWritten description#>
 *  @param totalBytesExpectedToWrite <#totalBytesExpectedToWrite description#>
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    if (self.didWriteDataBlock) {
        self.didWriteDataBlock(totalBytesWritten, totalBytesExpectedToWrite);
    }
}

/**
 *  下次完成
 *
 *  @param session <#session description#>
 *  @param task    <#task description#>
 *  @param error   <#error description#>
 */
-(void)URLSession:(NSURLSession *)session task: (NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error&&self.completionBlock) {
        dispatch_async(dispatch_get_main_queue(),^{
            self.completionBlock(nil,error);
        });
    }
}

/**
 *  下载成功
 *
 *  @param session      <#session description#>
 *  @param downloadTask <#downloadTask description#>
 *  @param location     <#location description#>
 */
-(void)URLSession:(NSURLSession *)session  downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    if (self.completionBlock) {
        self.completionBlock(location,nil);
    }
}

@end
