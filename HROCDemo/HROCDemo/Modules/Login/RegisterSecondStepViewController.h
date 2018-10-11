//
//  RegisterSecondStepViewController.h
//  HROCDemo
//
//  Created by Jeremy on 2017/8/29.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "XFBaseViewController.h"

@interface RegisterSecondStepViewController : XFBaseViewController

@property (nonatomic, assign) DDTUserType userType;
/** 推荐人手机号 */
@property (nonatomic, strong) NSString *invitationCode;
@end
