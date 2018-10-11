//
//  SetUserTypeRequest.h
//  XiangFa
//
//  Created by Jeremy on 2017/5/26.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "BaseRequest.h"

@interface SetUserTypeRequest : BaseRequest

@property (nonatomic, assign) DDTUserType ddtUserType;
@property (nonatomic, strong) NSString *token;
@end
