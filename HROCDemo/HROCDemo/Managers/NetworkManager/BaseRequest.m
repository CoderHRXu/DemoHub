//
//  BaseRequest.m
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 2017/1/19.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import "BaseRequest.h"

@interface BaseRequest()

@property (nonatomic, strong) NSProgress *uploadProgress;
@end

@implementation BaseRequest

- (instancetype)init {
    self = [super init];
    
    self.showHUD            = YES;
    self.printLog           = YES;
    self.changeInterface    = YES;
    self.status             = -1000;
    
    self.uploadProgress                 = [[NSProgress alloc] initWithParent:nil userInfo:nil];
    self.uploadProgress.totalUnitCount  = NSURLSessionTransferSizeUnknown;
    
    return self;
}

- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodPOST;
}

- (NSTimeInterval)requestTimeoutInterval {
    
    return 30;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return @{
             
             @"host":@"japi.xiangfajr.com"
             
             };
}


//如果子类未重写，使用默认参数
- (id)requestArgument {
    
    return [self mergeRequestArgument:nil];
}

// This method should shift to Commen Info Provider
- (NSDictionary *)mergeRequestArgument:(id)specificArguments {
    
//    NSString *token                 =  CacheHandlerInstance.currentUser.token;
//    NSString *appVersion            =  CacheHandlerInstance.currentSetting.appVersion;
    
    NSString *token = @"XXX";
    NSString *appVersion            = @"1.2.2";
    
    NSMutableDictionary *commenInfoDic      =  [NSMutableDictionary dictionaryWithDictionary: @{
                                                                                                @"platform"          :@"ios",
                                                                                                @"app_version"       :appVersion,
                                                                                                @"os_version"        :[NSString stringWithFormat:@"%.2f", [UIDevice.currentDevice.systemVersion floatValue]],
                                                                                                @"phone_model"       :[Utils deviceVersion] ,
                                                                                                @"network_type"      :[NSNumber numberWithInt:[Utils getNetStatus]],
                                                                                                @"service_provider"  :[NSNumber numberWithInt:[Utils serviceProvider]],
                                                                                                @"session_token"     :token? :@"",
                                                                                                @"data"              :[NSNull null]
                                                                                                
                                                                                                }];
    
    if (specificArguments != nil) {
        
        commenInfoDic[@"data"]  = specificArguments;
    }
    
    return commenInfoDic;
}

- (NSString *)baseUrl {
    
    return kNetPath_Base;
}

- (void)mlStartWithCompletionBlockWithSuccess:(MLRequestSucessBlock)success failure:(MLRequestFailureBlock)failure {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    
    self.successBlock   = success;
    self.failureBlock   = failure;
    
    self.delegate       = self;
    
    [self start];
    
    [self.requestTask addObserver:self
           forKeyPath:NSStringFromSelector(@selector(countOfBytesSent))
              options:NSKeyValueObservingOptionNew
              context:NULL];
    
    [self.requestTask addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(countOfBytesExpectedToSend))
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
    
    [self.uploadProgress addObserver:self
                          forKeyPath:NSStringFromSelector(@selector(fractionCompleted))
                             options:NSKeyValueObservingOptionNew
                             context:NULL];
    if (self.printLog) {
        NSLog(@"\n%@",self);
    }
}

- (void)requestFailed:(BaseRequest *)request {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [self handleFailedRequest:request];
}

- (void)handleFailedRequest:(BaseRequest *)request {
    
    [self requestFailedPreprocessor];
    
    switch (self.status) {
        case -1:
        case -2: {
            
            CacheHandlerInstance.resetCache;
            [NotificationManager postWithName:XFUserStatusChanged object:nil];
            
            if (self.status == -1) {
                
                if (self.changeInterface) {
                    [NotificationManager postWithName:XFBackToRootViewController object:nil];
                }
                
                if (self.printLog) {
                    NSLog(@"\n%@ --> 接口调用成功，未登录状态！", NSStringFromClass([self class]));
                }
            } else {
                
                if (self.changeInterface) {
                    [NotificationManager postWithName:XFShowLoginStatusAlertView object:nil];
                }
                
                if (self.printLog) {
                    NSLog(@"\n%@ --> 接口调用成功，被踢下状态！", NSStringFromClass([self class]));
                }
            }
        }
            break;
        case 1080: {
            
            if (self.printLog) {
                NSLog(@"\n%@ --> 未实名认证", NSStringFromClass([self class]));
            }
        }
            break;
        case 1029: {
            
            if (self.printLog) {
                NSLog(@"\n%@ --> 未平台认证", NSStringFromClass([self class]));
            }
        }
            break;
        case 6666: {
            
            if (self.printLog) {
                NSLog(@"\n%@ --> 信息确认页", NSStringFromClass([self class]));
            }
        }
            break;
        default: {
            
            if (self.showHUD) {
                
                if (self.status == -1000 && self.message == nil) {
                    
                    //如果未成功连接服务器
                    [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:@"请检查网络连接是否正常"];
                    NSLog(@"\n%@ --> 请检查网络连接是否正常", NSStringFromClass([self class]));

                } else {
                   
                    //弹出后端返回的msg
                    [XFProgressHUD showAutomaticallyDisappearWindowHUDwithString:self.message];
                    NSLog(@"\n%@ --> %@", NSStringFromClass([self class]), self.message);
                }
            }
        }
            break;
    }
    
    if (self.failureBlock) {
        
        self.failureBlock(request);
    }
    
    self.failureBlock = nil;
}

- (void)requestFinished:(BaseRequest *)request {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.printLog) {
        NSLog(@"\nResponse:  %@ -->%@", NSStringFromClass([self class]), self.responseString);
    }
    
    
    BaseBean *bb   = [BaseBean mj_objectWithKeyValues:self.responseObject];
    
    self.message    = bb.message;
    self.status     = bb.status;
    
    if (self.status != 1 && self.responseSerializerType == YTKResponseSerializerTypeJSON) {
        
        [self handleFailedRequest:request];
        return;
    }
    
    [self requestSucceedPreprocessor];
    if (self.successBlock){
        
        self.successBlock(request);
    }
    
    self.successBlock = nil;
}

- (void)requestCompletePreprocessor {
    [super requestCompletePreprocessor];
    
}


- (void)requestSucceedPreprocessor {
    
    //主线程
}

- (void)requestFailedPreprocessor {
    
    //主线程
}

- (YTKResponseSerializerType)responseSerializerType {
    
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestSerializerType)requestSerializerType {
    
    return YTKRequestSerializerTypeJSON;
}

//缓存
- (BOOL)ignoreCache {
    
    return !self.useCache;
}

- (NSInteger)cacheTimeInSeconds {
    
    return self.cacheTime;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([object isKindOfClass:[NSURLSessionTask class]]) {
       
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesSent))]) {
            
            self.uploadProgress.completedUnitCount = [change[NSKeyValueChangeNewKey] longLongValue];
        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesExpectedToSend))]) {
            
            self.uploadProgress.totalUnitCount = [change[NSKeyValueChangeNewKey] longLongValue];
        }
        
    } else if ([object isEqual:self.uploadProgress]) {
        
        if (self.uploadProgressBlock) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.uploadProgressBlock(self, object);
            });
        }
    }
}

- (void)cleanUpProgressForTask:(NSURLSessionTask *)task {
    
    @try {
        
        [task removeObserver:self forKeyPath:NSStringFromSelector(@selector(countOfBytesSent))];
        [task removeObserver:self forKeyPath:NSStringFromSelector(@selector(countOfBytesExpectedToSend))];
        [self.uploadProgress removeObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted))];
        
    } @catch (NSException *exception) {
        
    } @finally {
    
    }
    
    self.successBlock = nil;
    self.failureBlock = nil;
}

- (void)cancel {
    
    if (self) {
        
        self.successBlock = nil;
        self.failureBlock = nil;
        [[YTKNetworkAgent sharedAgent] cancelRequest:self];
    }
}

- (void)dealloc {
    
    [self cleanUpProgressForTask:self.requestTask];
    
    if (self.printLog) {
        NSLog(@"%@",[NSString stringWithFormat:@"\n%@ --> ald released",NSStringFromClass([self class])]);
    }
}
@end
