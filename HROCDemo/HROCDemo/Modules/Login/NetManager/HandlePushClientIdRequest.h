//
//  HandlePushClientIdRequest.h
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 04/02/2017.
//  Copyright © 2017 RJS. All rights reserved.
//

#import "BaseRequest.h"

@interface HandlePushClientIdRequest : BaseRequest

@property (strong, nonatomic) NSString *clientId;

@property (assign, nonatomic) BOOL      isBind;

@end
