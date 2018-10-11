//
//  SendVerificationCodeRequest.h
//  HROCDemo
//
//  Created by xuhaoran on 17/2/5.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import "BaseRequest.h"

@interface SendVerificationCodeRequest : BaseRequest

#pragma mark - input
/** 手机号  */
@property (nonatomic, strong) NSString *phone;
/** 未知参数  */
@property (nonatomic, strong) NSNumber *triggerScene;




@end
