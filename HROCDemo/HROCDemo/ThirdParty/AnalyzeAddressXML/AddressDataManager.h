//
//  AddressDataManager.h
//  Dingdong
//
//  Created by Jeremy on 2016/10/28.
//  Copyright © 2016年 RJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressDataManager : NSObject
+ (instancetype)shareInstance;
- (void)setAddress:(NSInteger)cityId;
@end
