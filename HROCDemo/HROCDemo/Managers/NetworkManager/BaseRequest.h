//
//  BaseRequest.h
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 2017/1/19.
//  Copyright © 2017年 RJS. All rights reserved.
//

@class BaseRequest;

typedef void(^MLRequestFailureBlock)(__kindof BaseRequest* request);
typedef void(^MLRequestSucessBlock) (__kindof BaseRequest* request);
typedef void(^MLUploadRequestProgressBlock)(__kindof BaseRequest* request, NSProgress* uploadProgress);

@interface BaseRequest : YTKRequest<YTKRequestDelegate>

//请求成功回调
@property(copy,nonatomic) MLRequestSucessBlock  successBlock;

/**
 失败的回调, 包含后端返回的失败
 */
@property(copy,nonatomic) MLRequestFailureBlock failureBlock;

/**
 上传进度回调
 */
@property(copy,nonatomic) MLUploadRequestProgressBlock uploadProgressBlock;

/**
 后端返回的status
 */
@property(nonatomic, assign) NSInteger  status;

/**
 后端返回msg
 */
@property (nonatomic, strong) NSString  *message;

/**
 是否显示HUD，默认为YES
 */
@property (nonatomic, assign) BOOL  showHUD;

/**
 是否在控制台打印Log，默认为YES
 */
@property (nonatomic, assign) BOOL  printLog;

/**
 是否更改界面 显示登录提示框或者回退到根目录，默认为YES
 */
@property (nonatomic, assign) BOOL  changeInterface;

/**
 后端返回数据在本地缓存的时间，>0
 */
@property (nonatomic, assign) NSInteger cacheTime;

/**
 是否使用缓存，如果没有缓存，会直接发起网络请求
 */
@property (assign, nonatomic) BOOL      useCache;

/**
 参数拼接

 @param specificArguments <#specificArguments description#>
 @return <#return value description#>
 */
- (NSDictionary *)mergeRequestArgument:(id)specificArguments;

/**
 
 开始请求

 @param success 成功回调
 @param failure 失败回调
 */
- (void)mlStartWithCompletionBlockWithSuccess:(nullable MLRequestSucessBlock)success failure:(nullable MLRequestFailureBlock)failure;

/**
 请求成功结束前 回调
 */
- (void)requestSucceedPreprocessor;

/**
 请求失败结束前 回调
 */
- (void)requestFailedPreprocessor;

/**
 取消请求
 */
- (void)cancel;

@end
