//
//  FCBaseDataModel.m
//  MCVVM-iOS
//
//  Created by 邹时新 on 2017/12/11.
//  Copyright © 2017年 zoushixin. All rights reserved.
//

#import "FCBaseDataModel.h"
#import "YYModel.h"

@implementation FCBaseDataModel

+ (instancetype)fc_modelWithResponse:(id)response{
    
    FCBaseDataModel *model = [self yy_modelWithJSON:response];
    // 特殊接口code不一样，由子类重写方法
    model.isSuccess = (model.error_code == 0) ||(model.error_code == 10010);
    return model;

}


/**
 有个特殊接口返回的参数有问题特殊处理v2/learning/clzssscoreinfo
 */
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"error_code": @[@"error_code", @"resCode", @"code"],
             @"error_msg": @[@"error_msg", @"resMessage", @"message"],
             };
}

@end
