//
//  RequestHelper.m
//  XiangFa
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn) on 09/02/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

#import "RequestHelper.h"
#import "HandlePushClientIdRequest.h"

@implementation RequestHelper


+ (void)handlePushClicentId:(BOOL)isBind {

    
    HandlePushClientIdRequest *handlePushClientIdRequest    = [[HandlePushClientIdRequest alloc] init];
    handlePushClientIdRequest.isBind                        = isBind;
    handlePushClientIdRequest.clientId                      = @"1";
    handlePushClientIdRequest.changeInterface               = NO;
    [handlePushClientIdRequest mlStartWithCompletionBlockWithSuccess:^(__kindof BaseRequest *request) {
        
        if (isBind) {
            
            NSLog(@"---------------ClientId 绑定成功---------------");
            
        }else{
            
            NSLog(@"---------------ClientId 已解绑---------------");
        }
        
    } failure:nil];

}

+ (void)bindClientId {
    
    [self handlePushClicentId:YES];
}

+ (void)unbindClientId {
    
    [self handlePushClicentId:NO];
}


@end
