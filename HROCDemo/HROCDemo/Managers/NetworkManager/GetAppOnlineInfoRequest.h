//
//  GetAppOnlineInfoRequest.h
//  XiangFa
//
//  Created by xuhaoran on 2017/7/18.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "BaseRequest.h"

@interface GetAppOnlineInfoRequest : BaseRequest

/** 本地版本是否大于AppStore版本 */
@property (nonatomic, assign) BOOL isLarger;

@end
